import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job/features/auth/controllers/auth_controller.dart';
import 'package:job/features/profile/screens/profile_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../auth/screens/login_page_test.mocks.dart';

@GenerateMocks([AuthController, GetStorage])
void main() {
  provideDummy<Either<String, bool>>(const Right(true));
  late MockAuthController mockAuthController;
  late MockGetStorage mockGetStorage;

  setUp(() {
    mockAuthController = MockAuthController();
    mockGetStorage = MockGetStorage();
    GetIt.instance.registerSingleton<GetStorage>(mockGetStorage);
    // GetIt.instance.registerSingleton<AuthController>(mockAuthController);
  });

  // group('Profile', () {

  testWidgets('ProfilePage displays correct Null/Non-null data',
      (tester) async {
    // Setup mock data
    when(mockGetStorage.read<String>('email')).thenReturn('test@example.com');
    when(mockGetStorage.read<String>('name')).thenReturn('John Doe');
    when(mockGetStorage.read<String>('number')).thenReturn('1234567890');
    when(mockAuthController.fetchProfile()).thenAnswer((_) async => Right(true));

    // Build the ProfilePage widget
    await tester.pumpWidget(
      CupertinoApp(
        home: ChangeNotifierProvider<AuthController>.value(
          value: mockAuthController,
          child: const ProfilePage(),
        ),
      ),
    );

    // Verify the profile information is displayed correctly
    expect(find.text('Profile'), findsNWidgets(2));
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('1234567890'), findsOneWidget);



    when(mockGetStorage.read<String>('email')).thenReturn(null);
    when(mockGetStorage.read<String>('name')).thenReturn(null);
    when(mockGetStorage.read<String>('number')).thenReturn(null);
    when(mockAuthController.fetchProfile()).thenAnswer((_) async => Right(true));

    // Build the ProfilePage widget
    await tester.pumpWidget(
      CupertinoApp(
        home: ChangeNotifierProvider<AuthController>.value(
          value: mockAuthController,
          child: const ProfilePage(),
        ),
      ),
    );

    // Verify default values are displayed
    expect(find.text('No email available'), findsOneWidget);
    expect(find.text('No name available'), findsOneWidget);
    expect(find.text('No number available'), findsOneWidget);
  });

  // testWidgets('ProfilePage displays default values when no data is available',
  //     (tester) async {
  //         // provideDummy<Either<String, bool>>(const Right(true));

  //   // Setup mock data
  //   when(mockGetStorage.read<String>('email')).thenReturn(null);
  //   when(mockGetStorage.read<String>('name')).thenReturn(null);
  //   when(mockGetStorage.read<String>('number')).thenReturn(null);
  //   when(mockAuthController.fetchProfile()).thenAnswer((_) async => Right(true));

  //   // Build the ProfilePage widget
  //   await tester.pumpWidget(
  //     CupertinoApp(
  //       home: ChangeNotifierProvider<AuthController>.value(
  //         value: mockAuthController,
  //         child: const ProfilePage(),
  //       ),
  //     ),
  //   );

  //   // Verify default values are displayed
  //   expect(find.text('No email available'), findsOneWidget);
  //   expect(find.text('No name available'), findsOneWidget);
  //   expect(find.text('No number available'), findsOneWidget);
  // });


  // });

}