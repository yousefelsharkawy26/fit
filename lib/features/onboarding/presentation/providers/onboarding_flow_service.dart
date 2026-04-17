import 'package:flutter_riverpod/legacy.dart';
import 'dart:convert';
import 'package:drift/drift.dart';
import '../../domain/models/biometric_profile.dart';
import '../../../../features/ontology/presentation/providers/substitution_providers.dart';
import '../../../../features/coaching/domain/services/coach_reasoning_engine.dart';
import '../../../../features/auth/presentation/providers/auth_providers.dart';
import '../../../../features/ontology/data/database/database.dart';

enum OnboardingStep {
  welcome,
  goal,
  experience,
  biometrics,
  equipment,
  processing,
}

class OnboardingState {
  final OnboardingStep currentStep;
  final BiometricProfile profile;
  final bool isCompleted;

  OnboardingState({
    this.currentStep = OnboardingStep.welcome,
    this.profile = const BiometricProfile(),
    this.isCompleted = false,
  });

  OnboardingState copyWith({
    OnboardingStep? currentStep,
    BiometricProfile? profile,
    bool? isCompleted,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      profile: profile ?? this.profile,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class OnboardingFlowService extends StateNotifier<OnboardingState> {
  final AppDatabase _db;
  final CoachReasoningEngine _coachEngine;
  final String _userId;

  OnboardingFlowService(this._db, this._coachEngine, this._userId) : super(OnboardingState());

  void setGoal(PrimaryGoal goal) {
    state = state.copyWith(profile: state.profile.copyWith(primaryGoal: goal));
  }

  void setExperience(ExperienceLevel level) {
    state = state.copyWith(
      profile: state.profile.copyWith(experienceLevel: level),
    );
  }

  void updateBiometrics({double? weight, double? height, int? age}) {
    state = state.copyWith(
      profile: state.profile.copyWith(
        weight: weight ?? state.profile.weight,
        height: height ?? state.profile.height,
        age: age ?? state.profile.age,
      ),
    );
  }

  void toggleEquipment(String equipmentId) {
    final currentList = List<String>.from(state.profile.availableEquipmentIds);
    if (currentList.contains(equipmentId)) {
      currentList.remove(equipmentId);
    } else {
      currentList.add(equipmentId);
    }
    state = state.copyWith(
      profile: state.profile.copyWith(availableEquipmentIds: currentList),
    );
  }

  void nextStep() {
    final nextIndex = state.currentStep.index + 1;
    if (nextIndex < OnboardingStep.values.length) {
      state = state.copyWith(currentStep: OnboardingStep.values[nextIndex]);
    }
  }

  void previousStep() {
    final prevIndex = state.currentStep.index - 1;
    if (prevIndex >= 0) {
      state = state.copyWith(currentStep: OnboardingStep.values[prevIndex]);
    }
  }

  Future<void> completeOnboarding() async {
    // 1. Shift UI state to Processing (The Calibrating Loader)
    state = state.copyWith(currentStep: OnboardingStep.processing);

    // 2. Transact the Biometric Profile down to local SQLite
    await _db.into(_db.userBiometrics).insertOnConflictUpdate(
      UserBiometricsCompanion(
        userId: Value(_userId),
        experienceLevel: Value(state.profile.experienceLevel?.name),
        primaryGoal: Value(state.profile.primaryGoal?.name),
        equipmentAvailability: Value(jsonEncode(state.profile.availableEquipmentIds)),
        weight: Value(state.profile.weight),
        height: Value(state.profile.height),
        age: Value(state.profile.age),
        updatedAt: Value(DateTime.now().toIso8601String()),
      ),
    );

    // 3. Command the Coaching Engine to Spin Up the "Day 1 Split"
    await _coachEngine.initializeNewUserPlan(_userId, state.profile);

    // 4. Commit Completion - Breaks the AppShell Nav Gate
    state = state.copyWith(isCompleted: true);
  }
}

final onboardingFlowProvider =
    StateNotifierProvider<OnboardingFlowService, OnboardingState>((ref) {
      final db = ref.watch(appDatabaseProvider);
      final coachEngine = ref.watch(coachReasoningEngineProvider);
      final authState = ref.watch(authProvider);

      return OnboardingFlowService(db, coachEngine, authState.userId);
    });
