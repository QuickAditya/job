import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job/features/profile/screens/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:job/features/auth/controllers/auth_controller.dart';
import 'package:job/features/auth/screens/login_page.dart';
import 'package:job/features/auth/screens/signup_page.dart';
import 'package:job/di.dart';

import 'features/home/controllers/home_controller.dart';
import 'features/home/screens/home_screen.dart';

Future<void> main() async {
  await setup();
  runApp(MyApp());
}

// Test build 2

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final getStorage = GetIt.instance<GetStorage>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future:
          _initializeGetStorage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoApp(
            home: CupertinoActivityIndicator(),
          );
        } else if (snapshot.hasError) {
          return const CupertinoApp(
            home: Center(
              child: Text('Error initializing storage'),
            ),
          );
        } else {
          final isLogin = snapshot.data ?? false;

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthController()),
              ChangeNotifierProvider(create: (_) => HomeController()),
            ],
            child: CupertinoApp(
              title: 'Flutter Demo',
              routes: {
                '/login': (_) => const LoginPage(),
                '/home': (_) => const HomePage(),
                '/signup': (_) => const SignupPage(),
                '/profile': (_) => const ProfilePage(),
                '/': (_) => isLogin ? const HomePage() : const LoginPage(),
              },
              // initialRoute: isLogin ? '/home' : '/login',
            ),
          );
        }
      },
    );
  }

  Future<bool> _initializeGetStorage() async {
    return getStorage.read('isLogin') ?? false;
  }
}
