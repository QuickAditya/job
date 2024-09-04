import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isLog;
  final getStorage = GetIt.instance<GetStorage>();

  @override
  void initState() {
    isLog = getStorage.read('isLogin');
    // TODO: implement initState
    super.initState();
    navigation();
    // Timer(
    //   Duration(seconds: 2),
    //   () {
    //     log('onboard');
    //     Navigator.pushReplacementNamed(context, '/onboard');
    //   },
    // );
  }

  void navigation() {
    Timer(Duration(seconds: 3), () {
      if (isLog == true) {
        Navigator.pushReplacementNamed(context, '/home');
        log('user is logged in');
      } else {
        // Navigator.pushReplacementNamed(context, '/login');
        Navigator.pushReplacementNamed(context, '/onboard');
        log('user is not logged in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var siz = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      child: Container(
        height: siz.height,
        width: siz.width,
        color: Color(0xff1452B5),
        child: Center(
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(
          //       'job',
          //       style: TextStyle(
          //           fontSize: 48,
          //           fontWeight: FontWeight.w900,
          //           color: const Color.fromARGB(255, 247, 239, 239)),
          //     ),
          //     Text(
          //       'placement',
          //       style: TextStyle(
          //           fontSize: 48,
          //           fontWeight: FontWeight.w900,
          //           color: const Color.fromARGB(255, 247, 239, 239)),
          //     ),
          //   ],
          // ),
          child: Image(
            image: AssetImage('assets/images/splash_logo.png'),
            height: siz.height * 0.1,
            width: siz.width * 0.9,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
