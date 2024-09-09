import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job/features/auth/screens/signup_page.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:job/features/auth/controllers/auth_controller.dart';
import 'package:mockito/mockito.dart';

import 'login_page_test.mocks.dart';

// class MockAuthController extends Mock implements AuthController {}
@GenerateMocks([AuthController])
void main() {
  group('SignUp Page', () {
    testWidgets('Signup page displays correctly and has all necessary fields',
        (tester) async {
      final mockAuthController = MockAuthController();
      when(mockAuthController.isloading).thenReturn(false);
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthController>.value(
            value: mockAuthController,
            child: const SignupPage(),
          ),
        ),
      );

      // Verify the presence of UI elements
      expect(find.text('TO MY JOBS'), findsOneWidget);
      expect(find.byKey(const Key('signup-name-text-field')), findsOneWidget);
      expect(find.byKey(const Key('signup-number-text-field')), findsOneWidget);
      expect(find.byKey(const Key('signup-email-text-field')), findsOneWidget);
      expect(
          find.byKey(const Key('signup-password-text-field')), findsOneWidget);
      expect(find.byType(CupertinoButton),
          findsNWidgets(2)); // Includes the 'Signup' button and 'Login' link
      // expect(find.text('Already have an account?'), findsOneWidget);
      expect(find.byKey(const Key('signup-button')), findsOneWidget);
      expect(find.byKey(const Key('signup-to-login-button')), findsOneWidget);
      expect(find.text('Signup'), findsNWidgets(2));
    });

    testWidgets('Password visibility toggle works correctly', (tester) async {
      final mockAuthController = MockAuthController();
      when(mockAuthController.isloading).thenReturn(false);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthController>.value(
            value: mockAuthController,
            child: const SignupPage(),
          ),
        ),
      );

//check initial
      expect(find.byIcon(CupertinoIcons.eye_slash), findsNWidgets(2));

      // Tap the icon to toggle the password visibility
      await tester.tap(find.byKey(const Key('passwordVisibilityToggle')));
      await tester.pump(); // Rebuild the widget tree

      // Verify if the icon changed to eye (visible)
      expect(find.byIcon(CupertinoIcons.eye), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.eye_slash), findsNWidgets(1));

      // Tap the icon to toggle the confirm password visibility
      await tester
          .tap(find.byKey(const Key('confirmPasswordVisibilityToggle')));
      await tester.pump(); // Rebuild the widget tree

      // Verify if the icon changed to eye (visible) for confirm password
      expect(find.byIcon(CupertinoIcons.eye), findsNWidgets(2));
      expect(find.byIcon(CupertinoIcons.eye_slash), findsNothing);
    });

    testWidgets('Empty Signup Fields', (tester) async {
      final mockAuthController = MockAuthController();
      // when(mockGetStorage.read<String>('email')).thenReturn(null);

      when(mockAuthController.isloading).thenReturn(false);
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthController>.value(
            value: mockAuthController,
            child: const SignupPage(),
          ),
        ),
      );

      // Initial state, the button should be enabled if fields are filled correctly
      expect(
          find.byKey(
            const Key('passwordVisibilityToggle'),
          ),
          findsOneWidget);

      expect(find.byKey(const Key('confirmPasswordVisibilityToggle')),
          findsOneWidget);
      expect(find.byKey(const Key('signup-to-login-button')), findsOneWidget);
      expect(find.byKey(const Key('signup-button')), findsOneWidget);

      // Enter empty data
      await tester.enterText(
          find.byKey(const Key('signup-name-text-field')), '');
      await tester.enterText(
          find.byKey(const Key('signup-number-text-field')), '');
      await tester.enterText(
          find.byKey(const Key('signup-email-text-field')), '');
      await tester.enterText(
          find.byKey(const Key('signup-password-text-field')), '');
      await tester.pump();

      // Tap signup button
      await tester.tap(find.byKey(const Key('signup-button')));
      await tester.pump();

      // Verify error dialog is shown
      expect(find.byType(CupertinoAlertDialog), findsOneWidget);
      expect(find.text('Invalid Field'), findsOneWidget);
      expect(find.text('Invalid Email/Password'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    /*
  testWidgets('Signup button triggers signup action and navigates on success', (tester) async {
    final mockAuthController = MockAuthController();
    when(mockAuthController.signup('John Doe', 'john.doe@example.com', 'password123', '1234567890'))
        .thenAnswer(
      (_) async => const Right(true), // Assuming your `signup` returns a `Right` on success
    );

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthController>.value(
          value: mockAuthController,
          child: const SignupPage(),
        ),
        onGenerateRoute: (settings) {
          if (settings.name == '/home') {
            return MaterialPageRoute(
              builder: (context) => const Scaffold(body: Text('Home Page')),
            );
          }
          return null;
        },
      ),
    );

    // Enter valid data
    await tester.enterText(find.byKey(const Key('signup-name-text-field')), 'John Doe');
    await tester.enterText(find.byKey(const Key('signup-email-text-field')), 'john.doe@example.com');
    await tester.enterText(find.byKey(const Key('signup-password-text-field')), 'password123');
    await tester.enterText(find.byKey(const Key('signup-number-text-field')), '1234567890');
    await tester.pump();

    // Tap signup button
    await tester.tap(find.byKey(const Key('signup-button')));
    await tester.pumpAndSettle();

    // Verify navigation to home page
    expect(find.text('Home Page'), findsOneWidget);
  });
  */

  //   testWidgets('Navigation to Login page works', (tester) async {
  //     final mockAuthController = MockAuthController();
  //     when(mockAuthController.isloading).thenReturn(false);

  //     await tester.pumpWidget(
  //       MaterialApp(
  //         home: ChangeNotifierProvider<AuthController>.value(
  //           value: mockAuthController,
  //           child: const SignupPage(),
  //         ),
  //         onGenerateRoute: (settings) {
  //           if (settings.name == '/login') {
  //             return MaterialPageRoute(
  //               builder: (context) => const Scaffold(body: Text('Login Page')),
  //             );
  //           }
  //           return null;
  //         },
  //       ),
  //     );

  //     // Tap Login link
  //     await tester.tap(find.text("Login"));
  //     await tester.pumpAndSettle();

  //     // Verify navigation to login page
  //     expect(find.text('Login Page'), findsOneWidget);
  //   });
  });

  /*
  testWidgets('Error dialog is shown when signup fails', (tester) async {
    final mockAuthController = MockAuthController();
    when(mockAuthController.signup('John Doe', 'john.doe@example.com', 'password123', '1234567890'))
        .thenAnswer(
      (_) async => const Left('Error message'), // Assuming your `signup` returns a `Left` on failure
    );

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthController>.value(
          value: mockAuthController,
          child: const SignupPage(),
        ),
      ),
    );

    // Enter valid data
    await tester.enterText(find.byKey(const Key('signup-name-text-field')), 'John Doe');
    await tester.enterText(find.byKey(const Key('signup-email-text-field')), 'john.doe@example.com');
    await tester.enterText(find.byKey(const Key('signup-password-text-field')), 'password123');
    await tester.enterText(find.byKey(const Key('signup-number-text-field')), '1234567890');
    await tester.pump();

    // Tap signup button
    await tester.tap(find.byKey(const Key('signup-button')));
    await tester.pump();

    // Verify error dialog is shown
    expect(find.byType(CupertinoAlertDialog), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
    expect(find.text('Error message'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
  });
  */
}
