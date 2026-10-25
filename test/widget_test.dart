// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:visionmate_ai/app.dart';

void main() {
  testWidgets('VisionMate AI welcome screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VisionMateApp());

    // Verify that the app title is present on welcome screen.
    expect(find.text('VisionMate AI'), findsOneWidget);
    
    // Verify that the Start button is present.
    expect(find.text('Start'), findsOneWidget);
    
    // Tap the Start button and trigger navigation
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle(); // Wait for navigation animation
    
    // Verify that we're now on the home screen
    expect(find.text('VisionMate AI Home'), findsOneWidget);
    expect(find.text('Welcome to VisionMate AI'), findsOneWidget);
    
    // Verify key features are displayed
    expect(find.text('Read Text'), findsOneWidget);
    expect(find.text('Describe Surroundings'), findsOneWidget);
  });
}
