import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/biometric_profile.dart';
import '../providers/onboarding_flow_service.dart';

class BiometricInterviewScreen extends ConsumerStatefulWidget {
  const BiometricInterviewScreen({super.key});

  @override
  ConsumerState<BiometricInterviewScreen> createState() =>
      _BiometricInterviewScreenState();
}

class _BiometricInterviewScreenState
    extends ConsumerState<BiometricInterviewScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    HapticFeedback.lightImpact();
    ref.read(onboardingFlowProvider.notifier).nextStep();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingFlowProvider);

    // If processing, show the computation state
    if (state.currentStep == OnboardingStep.processing) {
      return _buildProcessingScreen();
    }

    return Scaffold(
      backgroundColor: Colors.black, // Premium dark theme
      body: SafeArea(
        child: Column(
          children: [
            // Floating Coach Context Tip
            _buildCoachTip(state.currentStep),

            // The main interview pages
            Expanded(
              child: PageView(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Force using the buttons
                children: [
                  // Welcome Screen
                  _buildWelcomeStep(),
                  // Goal Selection
                  _buildGoalStep(state),
                  // Experience Level
                  _buildExperienceStep(state),
                  // Biometrics Input
                  _buildBiometricsStep(state),
                  // Equipment Exclusions
                  _buildEquipmentStep(state),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoachTip(OnboardingStep step) {
    String tipText = "";
    switch (step) {
      case OnboardingStep.goal:
        tipText =
            "Defining your primary goal allows me to calibrate your volume thresholds.";
        break;
      case OnboardingStep.experience:
        tipText =
            "This helps me avoid recommending movements that require advanced CNS control.";
        break;
      case OnboardingStep.biometrics:
        tipText =
            "I use this to establish a baseline for your relative strength capacity.";
        break;
      case OnboardingStep.equipment:
        tipText = "No access? No problem. I will route around it dynamically.";
        break;
      default:
        return const SizedBox(height: 80);
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Container(
        key: ValueKey(step),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.cyan.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.cyan.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.psychology, color: Colors.cyan),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                tipText,
                style: const TextStyle(color: Colors.cyanAccent, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeStep() {
    return _StepContainer(
      title: "Welcome to FitOS",
      subtitle:
          "Let's calibrate your biomechanical profile to generate your Day 1 Split.",
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          ),
          onPressed: _nextPage,
          child: const Text(
            "Begin Diagnostic",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalStep(OnboardingState state) {
    return _StepContainer(
      title: "Primary Objective",
      subtitle: "What is the primary adaptation you are training for?",
      child: Column(
        children: PrimaryGoal.values.map((goal) {
          final isSelected = state.profile.primaryGoal == goal;
          return _SelectionCard(
            title: goal.name.toUpperCase(),
            isSelected: isSelected,
            onTap: () {
              HapticFeedback.heavyImpact(); // Locked-in feel
              ref.read(onboardingFlowProvider.notifier).setGoal(goal);
              Future.delayed(const Duration(milliseconds: 400), _nextPage);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExperienceStep(OnboardingState state) {
    return _StepContainer(
      title: "Training Age",
      subtitle: "How long have you been lifting consistently?",
      child: Column(
        children: ExperienceLevel.values.map((level) {
          final isSelected = state.profile.experienceLevel == level;
          return _SelectionCard(
            title: level.name.toUpperCase(),
            isSelected: isSelected,
            onTap: () {
              HapticFeedback.mediumImpact();
              ref.read(onboardingFlowProvider.notifier).setExperience(level);
              Future.delayed(const Duration(milliseconds: 300), _nextPage);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBiometricsStep(OnboardingState state) {
    return _StepContainer(
      title: "Biometrics",
      subtitle: "Calibrating baseline relative strength.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildNumericInput(
            label: 'Age (Years)',
            initialValue: state.profile.age?.toString() ?? '',
            onChanged: (val) {
              if (int.tryParse(val) != null) {
                ref
                    .read(onboardingFlowProvider.notifier)
                    .updateBiometrics(age: int.parse(val));
              }
            },
          ),
          const SizedBox(height: 16),
          _buildNumericInput(
            label: 'Weight (kg)',
            initialValue: state.profile.weight?.toString() ?? '',
            onChanged: (val) {
              if (double.tryParse(val) != null) {
                ref
                    .read(onboardingFlowProvider.notifier)
                    .updateBiometrics(weight: double.parse(val));
              }
            },
          ),
          const SizedBox(height: 16),
          _buildNumericInput(
            label: 'Height (cm)',
            initialValue: state.profile.height?.toString() ?? '',
            onChanged: (val) {
              if (double.tryParse(val) != null) {
                ref
                    .read(onboardingFlowProvider.notifier)
                    .updateBiometrics(height: double.parse(val));
              }
            },
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              _nextPage();
            },
            child: const Text(
              "Next",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumericInput({
    required String label,
    required String initialValue,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.cyanAccent, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.cyan),
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildEquipmentStep(OnboardingState state) {
    return _StepContainer(
      title: "Equipment Availability",
      subtitle: "Are there any core tools you DO NOT have access to?",
      child: Column(
        children: [
          // Render a quick toggle for Cables just as an example
          _SelectionCard(
            title: "CABLES",
            isSelected: state.profile.availableEquipmentIds.contains('cables'),
            onTap: () {
              HapticFeedback.lightImpact();
              ref
                  .read(onboardingFlowProvider.notifier)
                  .toggleEquipment('cables');
            },
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              HapticFeedback.heavyImpact();
              ref.read(onboardingFlowProvider.notifier).completeOnboarding();
            },
            child: const Text(
              "Generate Day 1 Split",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingScreen() {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.cyan, strokeWidth: 2),
            SizedBox(height: 32),
            Text(
              "Calibrating your Coach...",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 18,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Generating your Day 1 Split.",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _StepContainer({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white60, fontSize: 16),
          ),
          const SizedBox(height: 48),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.cyan.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.cyan : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.cyanAccent : Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.cyanAccent),
          ],
        ),
      ),
    );
  }
}
