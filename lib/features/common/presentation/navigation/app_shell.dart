import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../coaching/presentation/screens/coach_dashboard_screen.dart';
import '../../../workout/presentation/screens/gym_mode_screen.dart';
import '../../../analytics/presentation/screens/analytics_dashboard_screen.dart';
import '../../../onboarding/presentation/screens/biometric_interview_screen.dart';
import '../../../onboarding/presentation/providers/onboarding_flow_service.dart';
import '../../../ontology/data/sync/sync_manager.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 0);

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  @override
  void initState() {
    super.initState();
    // Initialize the background Flywheel Sync engine
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(syncManagerProvider).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingFlowProvider);
    if (!onboardingState.isCompleted) {
      return const BiometricInterviewScreen();
    }

    final currentIndex = ref.watch(navigationIndexProvider);

    final screens = [
      const CoachDashboardScreen(),
      const GymModeScreen(),
      const AnalyticsDashboardScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withValues(alpha: 0.8),
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.1),
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => ref.read(navigationIndexProvider.notifier).state = index,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.cyanAccent,
          unselectedItemColor: Colors.white38,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.psychology_outlined),
              activeIcon: Icon(Icons.psychology_rounded),
              label: 'COACH',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center_outlined),
              activeIcon: Icon(Icons.fitness_center_rounded),
              label: 'GYM MODE',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              activeIcon: Icon(Icons.bar_chart_rounded),
              label: 'ANALYTICS',
            ),
          ],
        ),
      ),
    );
  }
}
