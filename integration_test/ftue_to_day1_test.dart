import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:fit/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Complete Biometric Interview FTUE and land on Day 1 Split', (WidgetTester tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // 1. Welcome Screen
    expect(find.text('Begin Diagnostic'), findsOneWidget);
    await tester.tap(find.text('Begin Diagnostic'));
    await tester.pumpAndSettle();

    // 2. Goal Selection (Primary Objective)
    final hypertrophyCard = find.text('HYPERTROPHY');
    expect(hypertrophyCard, findsOneWidget);
    await tester.tap(hypertrophyCard);
    
    // Wait for the simulated delay in the widget (400ms + animation)
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // 3. Experience Level
    final intermediateCard = find.text('INTERMEDIATE');
    expect(intermediateCard, findsOneWidget);
    await tester.tap(intermediateCard);

    // Wait for the simulated delay (300ms + animation)
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // 4. Biometrics Input
    expect(find.text('Biometrics'), findsOneWidget);
    
    // Fill in Age
    await tester.enterText(find.ancestor(
      of: find.text('Age (Years)'), 
      matching: find.byType(TextFormField)
    ).first, '30');
    
    // Fill in Weight
    await tester.enterText(find.ancestor(
      of: find.text('Weight (kg)'), 
      matching: find.byType(TextFormField)
    ).first, '80');
    
    // Fill in Height
    await tester.enterText(find.ancestor(
      of: find.text('Height (cm)'), 
      matching: find.byType(TextFormField)
    ).first, '180');
    
    // Tap Next
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // 5. Equipment Exclusions
    expect(find.text('Equipment Availability'), findsOneWidget);
    
    // Tap Cables to toggle them
    await tester.tap(find.text('CABLES'));
    await tester.pumpAndSettle();

    // Generate Day 1 Split
    await tester.tap(find.text('Generate Day 1 Split'));
    
    // 6. Processing Screen & Dashboard Load
    // the pumpAndSettle needs to account for the background operation completing.
    // The OnboardingFlowService takes an artificial or real processing time before setting isCompleted to true.
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // 7. Verification: We should now be on the AppShell, landing on the Coach Dashboard
    // 'GYM MODE' is a label on the bottom navigation bar exclusive to the main shell.
    expect(find.text('GYM MODE'), findsOneWidget);
  });
}
