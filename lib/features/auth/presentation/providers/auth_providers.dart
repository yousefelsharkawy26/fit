import 'package:flutter_riverpod/legacy.dart';

import 'package:fit/features/core/providers/core_providers.dart';
import 'package:fit/features/auth/domain/services/identity_migration_service.dart';

class AuthState {
  final bool isAuthenticated;
  final String userId;
  final bool isSyncing;

  AuthState({
    required this.isAuthenticated,
    required this.userId,
    this.isSyncing = false,
  });

  factory AuthState.anonymous() => AuthState(
    isAuthenticated: false,
    userId: 'local-user', // Baseline offline identity
  );
}

class AuthNotifier extends StateNotifier<AuthState> {
  final IdentityMigrationService _migrationService;

  AuthNotifier(this._migrationService) : super(AuthState.anonymous());

  Future<void> mergeAnonymousToIdentity(String provider) async {
    // 1. Enter the merge state
    state = AuthState(
      isAuthenticated: false,
      userId: state.userId,
      isSyncing: true,
    );

    // 2. Simulate Cloud Handshake + Supabase Auth
    await Future.delayed(const Duration(seconds: 1));

    // 3. Trigger SQLite atomic migration
    final newUuid = 'usr_${DateTime.now().millisecondsSinceEpoch}';
    await _migrationService.atomicMerge(newUuid);

    // 4. Complete and assign persistent UUID
    state = AuthState(
      isAuthenticated: true,
      userId: newUuid,
      isSyncing: false,
    );
  }

  void signOut() {
    state = AuthState.anonymous();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AuthNotifier(IdentityMigrationService(db));
});
