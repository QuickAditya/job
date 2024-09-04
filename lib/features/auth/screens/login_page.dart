import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:job/features/auth/controllers/auth_controller.dart';
import 'package:job/features/auth/screens/widgets/custom_button.dart';
import 'package:job/features/auth/screens/widgets/custom_text_field.dart';
import 'package:job/utils/custombutton.dart';
import 'package:job/utils/validators.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true; // State variable for password visibility

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final authController = Provider.of<AuthController>(context, listen: false);
    var s = MediaQuery.of(context).size;
    return Consumer<AuthController>(
      builder: (_, authc, __) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Login'),
            backgroundColor: CupertinoColors.systemGrey6,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            "We Say Hello!",
                            style: TextStyle(
                                color: Color(0xff1452B5),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Welcome back use your email and\npassword to login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 50,
                          ),

                          CustomCupertinoTextField(
                            controller: emailController,
                            placeholder: 'Email Address',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Color(0xffC5C1C1),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              CupertinoTextField(
                                onChanged: (value) {},
                                prefix: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.lock_open,
                                    color: Color(0xffC5C1C1),
                                  ),
                                ),
                                maxLength: 12,
                                controller: passwordController,
                                placeholder: 'Password',
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                                decoration: BoxDecoration(
                                  // color: CupertinoColors.black,
                                  border: Border.all(
                                      color: CupertinoColors.systemGrey4),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                obscureText: _obscureText,
                                textInputAction: TextInputAction.done,
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  _obscureText
                                      ? CupertinoIcons.eye_slash
                                      : CupertinoIcons.eye,
                                  color: CupertinoColors.systemGrey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                          // CupertinoButton.filled(
                          //   child: const Text(
                          //     'Login',
                          //     style: TextStyle(
                          //       fontSize: 16.0,
                          //       color: CupertinoColors.white,
                          //     ),
                          //   ),
                          //   onPressed: () async {
                          //     if ((_formKey.currentState?.validate() ?? false) &&
                          //         emailController.text.isNotEmpty &&
                          //         passwordController.text.isNotEmpty) {
                          //       final result = await authController.login(
                          //         emailController.text,
                          //         passwordController.text,
                          //       );
                          //       result.fold(
                          //         (error) => showCupertinoDialog(
                          //           context: context,
                          //           builder: (context) => CupertinoAlertDialog(
                          //             title: const Text('Error'),
                          //             content: Text(error),
                          //             actions: [
                          //               CupertinoDialogAction(
                          //                 child: const Text('OK'),
                          //                 onPressed: () {
                          //                   Navigator.of(context).pop();
                          //                 },
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         (success) =>
                          //             Navigator.pushReplacementNamed(context, '/home'),
                          //       );
                          //     } else {
                          //       showCupertinoDialog(
                          //         context: context,
                          //         builder: (context) => CupertinoAlertDialog(
                          //           title: const Text('Invalid Field'),
                          //           content: const Text("Invalid Email/Password"),
                          //           actions: [
                          //             CupertinoDialogAction(
                          //               child: const Text('OK'),
                          //               onPressed: () {
                          //                 Navigator.of(context).pop();
                          //               },
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //     }
                          //   },
                          // ),
                          CustomButton2(
                            width: s.width * 0.8,
                            onPressed: () async {
                              if ((_formKey.currentState?.validate() ??
                                      false) &&
                                  emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                final result = await authController.login(
                                  emailController.text,
                                  passwordController.text,
                                );
                                result.fold(
                                  (error) => showCupertinoDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                      title: const Text('Error'),
                                      content: Text(error),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  (success) => Navigator.pushReplacementNamed(
                                      context, '/home'),
                                );
                              } else {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    title: const Text('Invalid Field'),
                                    content:
                                        const Text("Invalid Email/Password"),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            text: 'Login',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                TextSpan(
                                  text: 'SignUp',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle the SignUp tap
                                      // Navigator.pushReplacementNamed(
                                      //     context, '/signup');
                                      Navigator.pushNamed(context, '/signup');
                                      print('SignUp tapped!');
                                      // You can navigate to a sign-up screen here.
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (authc.isloading)
                  Stack(
                    children: [
                      Container(
                        height: height * 1,
                        width: width * 1,
                        decoration: const BoxDecoration(),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const Center(
                        child: CupertinoActivityIndicator(
                          color: Color.fromARGB(255, 2, 2, 2),
                          radius: 15,
                          animating: true,
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
