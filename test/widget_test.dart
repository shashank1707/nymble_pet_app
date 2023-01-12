import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_pet_app/screens/onboarding.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Test onboarding screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Onboarding()));

    // Find the email text field
    final getStartedButton = find.byKey(const Key('get started'));
    expect(getStartedButton, findsOneWidget);

  });
}
