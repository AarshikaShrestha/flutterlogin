// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auth_flow/main.dart';

void main() {
  testWidgets('login validates required fields and opens registration', (tester) async {
    tester.view.physicalSize = const Size(430, 900);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const AuthFlowApp());

    expect(find.text('AuthFlow'), findsOneWidget);
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    expect(find.text('Enter your email or username.'), findsOneWidget);
    expect(find.text('Enter your password.'), findsOneWidget);

    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    expect(find.text('Create your account'), findsOneWidget);
    expect(find.text('Confirm password'), findsOneWidget);

    await tester.tap(find.byTooltip('Back to login'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  testWidgets('registration validates email, password, and confirmation', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const AuthFlowApp());
    await tester.ensureVisible(find.text('Register'));
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    final passwordField = find.byKey(const ValueKey('register-password'));
    final passwordTextField = find.descendant(
      of: passwordField,
      matching: find.byType(TextField),
    );
    expect(tester.widget<TextField>(passwordTextField).obscureText, isTrue);
    await tester.tap(find.byTooltip('Show password').first);
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(passwordTextField).obscureText, isFalse);

    final confirmationField = find.byKey(const ValueKey('register-confirm-password'));
    final confirmationTextField = find.descendant(
      of: confirmationField,
      matching: find.byType(TextField),
    );
    await tester.ensureVisible(confirmationField);
    await tester.tap(find.byTooltip('Show password'));
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(confirmationTextField).obscureText, isFalse);

    await tester.enterText(find.byKey(const ValueKey('register-name')), 'Aashika Student');
    await tester.enterText(find.byKey(const ValueKey('register-email')), 'not-an-email');
    await tester.enterText(find.byKey(const ValueKey('register-password')), 'short');
    await tester.enterText(find.byKey(const ValueKey('register-confirm-password')), 'different');
    await tester.ensureVisible(find.text('Create account'));
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(find.text('Use at least 8 characters.'), findsOneWidget);
    expect(find.text('Passwords do not match.'), findsOneWidget);
    expect(tester.takeException(), isNull);
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  testWidgets('valid registration returns to login with success feedback', (tester) async {
    tester.view.physicalSize = const Size(430, 900);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const AuthFlowApp());
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const ValueKey('register-name')), 'Aashika Student');
    await tester.enterText(find.byKey(const ValueKey('register-email')), 'aashika@example.com');
    await tester.enterText(find.byKey(const ValueKey('register-password')), 'flowpass123');
    await tester.enterText(find.byKey(const ValueKey('register-confirm-password')), 'flowpass123');
    await tester.ensureVisible(find.text('Create account'));
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Account created. You can now sign in.'), findsOneWidget);
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
