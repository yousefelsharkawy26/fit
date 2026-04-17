import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          'IDENTITY HUB',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.cyanAccent),
      ),
      body: authState.isSyncing
          ? _buildSyncingState()
          : (authState.isAuthenticated
              ? _buildAuthenticatedState(context, ref, authState)
              : _buildLoginState(context, ref)),
    );
  }

  Widget _buildSyncingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const CircularProgressIndicator(
              color: Colors.cyanAccent,
              strokeWidth: 4,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'MERGING ANONYMOUS PROFILE',
            style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Syncing local database to the Global Flywheel...',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthenticatedState(BuildContext context, WidgetRef ref, AuthState state) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 64),
          const SizedBox(height: 24),
          const Text(
            'IDENTITY VERIFIED',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.greenAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Connected as:\n${state.userId}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 48),
          OutlinedButton(
            onPressed: () {
              ref.read(authProvider.notifier).signOut();
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.redAccent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text('DISCONNECT LOCAL PROVENANCE', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginState(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.cloud_sync_outlined, color: Colors.cyanAccent, size: 64),
          const SizedBox(height: 24),
          const Text(
            'CONNECT TO THE FLYWHEEL',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Your local history will be securely merged with your cloud identity. Unlock cross-device sync and community tier promotion.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 64),
          _buildAuthButton(
            icon: Icons.apple,
            label: 'CONTINUE WITH APPLE',
            color: Colors.white,
            textColor: Colors.black,
            onPressed: () => ref.read(authProvider.notifier).mergeAnonymousToIdentity('apple'),
          ),
          const SizedBox(height: 16),
          _buildAuthButton(
            icon: Icons.g_mobiledata,
            label: 'CONTINUE WITH GOOGLE',
            color: Colors.white,
            textColor: Colors.black,
            onPressed: () => ref.read(authProvider.notifier).mergeAnonymousToIdentity('google'),
          ),
          const SizedBox(height: 16),
          _buildAuthButton(
            icon: Icons.email_outlined,
            label: 'MAGIC LINK LOG IN',
            color: Colors.transparent,
            textColor: Colors.cyanAccent,
            borderColor: Colors.cyanAccent,
            onPressed: () => ref.read(authProvider.notifier).mergeAnonymousToIdentity('magic'),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: borderColor != null ? Border.all(color: borderColor, width: 2) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 28),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
