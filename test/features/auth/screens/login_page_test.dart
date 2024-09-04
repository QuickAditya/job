import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job/features/auth/repos/auth_repo.dart';
import 'package:job/features/auth/screens/login_page.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:job/features/auth/controllers/auth_controller.dart';
import 'package:mockito/mockito.dart';

import 'login_page_test.mocks.dart';

// class MockAuthController extends Mock implements AuthController {}

// class MockAuthRepo extends Mock implements AuthRepo {}

// class MockGetStorage extends Mock implements GetStorage {}

// // Import the generated mocks
// import 'mocks.mocks.dart';

// Annotate your test with @GenerateMocks
@GenerateMocks([AuthController, AuthRepo, GetStorage])
void main() {
  provideDummy<Either<String, bool>>(const Right(true));

  late MockAuthController mockAuthController;
  late MockAuthRepo mockAuthRepo;
  late MockGetStorage mockGetStorage;

  final GetIt getIt = GetIt.instance;

  setUp(() {
    getIt.reset();
    mockAuthRepo = MockAuthRepo();
    mockGetStorage = MockGetStorage();
    mockAuthController = MockAuthController();

    getIt.registerLazySingleton<AuthRepo>(() => mockAuthRepo);
    getIt.registerLazySingleton<GetStorage>(() => mockGetStorage);
  });

  group('Login Page', () {
    testWidgets('Login page displays correctly and has all necessary fields',
        (tester) async {
      final mockAuthController = MockAuthController();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthController>.value(
            value: mockAuthController,
            child: const LoginPage(),
          ),
        ),
      );

      // Verify the presence of UI elements
      expect(find.text('JOB PORTAL'), findsOneWidget);
      expect(find.byKey(const Key('login-email-text-field')), findsOneWidget);
      expect(
          find.byKey(const Key('login-password-text-field')), findsOneWidget);
      expect(find.byType(CupertinoButton),
          findsNWidgets(3)); // Includes the 'Login' button
      expect(find.text("Don't have an account? Sign Up"), findsOneWidget);
      expect(find.byKey(const Key('login-button')), findsOneWidget);
      expect(find.text('Login'), findsNWidgets(2));
    });

    testWidgets('Password visibility toggle works correctly', (tester) async {
      final mockAuthController = MockAuthController();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthController>.value(
            value: mockAuthController,
            child: const LoginPage(),
          ),
        ),
      );

      // Check initial visibility icon
      expect(find.byIcon(CupertinoIcons.eye), findsOneWidget);

      // Tap the icon to toggle visibility
      await tester.tap(find.byIcon(CupertinoIcons.eye));
      await tester.pump();

      // Check if the icon changed to eye_slash
      expect(find.byIcon(CupertinoIcons.eye_slash), findsOneWidget);
    });

    /*
  testWidgets('Login button is enabled/disabled based on form validation',
      (tester) async {
    final mockAuthController = MockAuthController();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthController>.value(
          value: mockAuthController,
          child: const LoginPage(),
        ),
      ),
    );

    // Initial state, the button should be enabled if fields are filled correctly
    expect(find.byKey(const Key('login-eye-button')), findsOneWidget);
    expect(find.byKey(const Key('login-to-signup-button')), findsOneWidget);
    expect(find.byKey(const Key('login-button')), findsOneWidget);

    // Enter invalid data
    await tester.enterText(
        find.byKey(const Key('login-email-text-field')).first, 'invalidema');
    await tester.enterText(
        find.byKey(const Key('login-password-text-field')), 'invalid');
    await tester.pump();

    // Tap login button
    await tester.tap(find.byKey(const Key('login-button')));
    await tester.pump();
    await Future.delayed(Duration(seconds: 5));
    // Verify error dialog is shown
    expect(find.byType(CupertinoAlertDialog), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
    expect(find.text('Login failed'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
  });
  */

    testWidgets('Empty Login Fields', (tester) async {
      final mockAuthController = MockAuthController();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthController>.value(
            value: mockAuthController,
            child: const LoginPage(),
          ),
        ),
      );

      // Initial state, the button should be enabled if fields are filled correctly
      expect(find.byKey(const Key('login-eye-button')), findsOneWidget);
      expect(find.byKey(const Key('login-to-signup-button')), findsOneWidget);
      expect(find.byKey(const Key('login-button')), findsOneWidget);

      // Enter invalid data
      await tester.enterText(
          find.byKey(const Key('login-email-text-field')).first, '');
      await tester.enterText(
          find.byKey(const Key('login-password-text-field')), '');
      await tester.pump();

      // Tap login button
      await tester.tap(find.byKey(const Key('login-button')));
      await tester.pump();

      // Verify error dialog is shown
      expect(find.byType(CupertinoAlertDialog), findsOneWidget);
      expect(find.text('Invalid Field'), findsOneWidget);
      expect(find.text('Invalid Email/Password'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('Navigation to Sign Up page works', (tester) async {
      final mockAuthController = MockAuthController();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthController>.value(
            value: mockAuthController,
            child: const LoginPage(),
          ),
          onGenerateRoute: (settings) {
            if (settings.name == '/signup') {
              return MaterialPageRoute(
                builder: (context) =>
                    const Scaffold(body: Text('Sign Up Page')),
              );
            }
            return null;
          },
        ),
      );

      // Tap Sign Up link
      await tester.tap(find.text("Don't have an account? Sign Up"));
      await tester.pumpAndSettle();

      // Verify navigation to sign up page
      expect(find.text('Sign Up Page'), findsOneWidget);
    });
  });

  /*
  test('successful login returns Right(true)', () async {
    final mockResponse = Response(
      requestOptions: RequestOptions(path: '/login'),
      statusCode: 200,
      data: {
        'message': 'Success',
        'items': {'name': 'Dhruv', 'token': 'fake-token', 'id': 'user-id'}
      },
    );

    when(mockAuthRepo.login(
      'dhruvsoni7220@gmail.com',
      '123456',
    )).thenAnswer((_) async => mockResponse); // Provide dummy value directly

    when(mockAuthController.login(
      'dhruvsoni7220@gmail.com',
      '123456',
      // mocRepo: mockAuthRepo,
      // mocStorage: mockGetStorage,
    )).thenAnswer((_) async => const Right(true));

    final result = await mockAuthController.login(
      'dhruvsoni7220@gmail.com',
      '123456',
      // mocRepo: mockAuthRepo,
      // mocStorage: mockGetStorage,
    );

    expect(result, equals(const Right(true)));
  });

  testWidgets('Login button triggers login action and navigates on success',
      (tester) async {
    final mockAuthController = MockAuthController();
    when(mockAuthController.login('dhruvsoni7220@gmail.com', '123456'))
        .thenAnswer((_) async {
      return const Right(true);
    });

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthController>.value(
          value: mockAuthController,
          child: const LoginPage(),
        ),
        onGenerateRoute: (settings) {
          if (settings.name == '/home') {
            return MaterialPageRoute(
              builder: (context) => const Scaffold(body: Text('Job Listings')),
            );
          }
          return null;
        },
      ),
    );

    // Enter valid data
    await tester.enterText(find.byKey(const Key('login-email-text-field')),
        'dhruvsoni7220@gmail.com');
    await tester.enterText(
        find.byKey(const Key('login-password-text-field')), '123456');
    await tester.pump();

    // Tap login button
    await tester.tap(
        find.byKey(const Key('login-button'))); // Adjust index if necessary
    await tester.pumpAndSettle();

    // Verify navigation to home page
    expect(find.text('Job Listings'), findsOneWidget);
  });

  testWidgets('Error dialog is shown when login fails', (tester) async {
    final mockAuthController = MockAuthController();
    when(mockAuthController.login("dhruvsoni7220@gmail.com", "")).thenAnswer(
      (_) async => const Left(
          'Error message'), // Assuming your `login` returns a `Left` on failure
    );

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthController>.value(
          value: mockAuthController,
          child: const LoginPage(),
        ),
      ),
    );

    // Enter valid data
    await tester.enterText(
        find.byType(CupertinoTextField).first, 'validemail@example.com');
    await tester.enterText(
        find.byType(CupertinoTextField).at(1), 'validpassword');
    await tester.pump();

    // Tap login button
    await tester.tap(find.byType(CupertinoButton));
    await tester.pump();

    // Verify error dialog is shown
    expect(find.byType(CupertinoAlertDialog), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
    expect(find.text('Error message'), findsOneWidget);
  });
  */
}
