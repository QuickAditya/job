import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool emailError = false;
  bool passError = false;
  bool pass2Error = false;
  bool validEmail = false;

  FocusNode passwordNode = FocusNode();
  FocusNode emailNode = FocusNode();
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

                          // CustomCupertinoTextField(
                          //   key: Key('login-email-text-field'),
                          //   controller: emailController,
                          //   placeholder: 'Email Address',
                          //   prefixIcon: Icon(
                          //     Icons.email_outlined,
                          //     color: Color(0xffC5C1C1),
                          //   ),
                          // ),
                          emailfield(),
                          emailController.text.isEmpty
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 5, top: 3),
                                  child: Text(
                                      emailError ? 'Enter email address' : '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.red)),
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 2),
                                  child: Text(
                                      validEmail ? 'Enter valid email id' : '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.red)),
                                ),
                          const SizedBox(height: 20),
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              // CupertinoTextField(
                              //   key: Key('login-password-text-field'),
                              //   onChanged: (value) {},
                              //   prefix: Padding(
                              //     padding: EdgeInsets.only(left: 5),
                              //     child: Icon(
                              //       Icons.lock_open,
                              //       color: Color(0xffC5C1C1),
                              //     ),
                              //   ),
                              //   maxLength: 12,
                              //   controller: passwordController,
                              //   placeholder: 'Password',
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 16.0, vertical: 12.0),
                              //   decoration: BoxDecoration(
                              //     // color: CupertinoColors.black,
                              //     border: Border.all(
                              //         color: CupertinoColors.systemGrey4),
                              //     borderRadius: BorderRadius.circular(8.0),
                              //   ),
                              //   obscureText: _obscureText,
                              //   textInputAction: TextInputAction.done,
                              // ),
                              passwordField(),
                              CupertinoButton(
                                key: Key('login-eye-button'),
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
                          Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 5, top: 3),
                              child: passwordController.text.isEmpty
                                  ? Text(passError ? 'Enter Password' : '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.red))
                                  : Text(
                                      pass2Error
                                          ? 'Password length should be at leat 8'
                                          : '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.red))),

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
                            key: Key('login-button'),
                            width: s.width * 0.8,
                            // onPressed: () async {
                            //   if ((_formKey.currentState?.validate() ??
                            //           false) &&
                            //       emailController.text.isNotEmpty &&
                            //       passwordController.text.isNotEmpty) {
                            //     final result = await authController.login(
                            //       emailController.text,
                            //       passwordController.text,
                            //     );
                            //     result.fold(
                            //       (error) => showCupertinoDialog(
                            //         context: context,
                            //         builder: (context) => CupertinoAlertDialog(
                            //           title: const Text('Error'),
                            //           content: Text(error),
                            //           actions: [
                            //             CupertinoDialogAction(
                            //               child: const Text('OK'),
                            //               onPressed: () {
                            //                 Navigator.of(context).pop();
                            //               },
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       (success) => Navigator.pushReplacementNamed(
                            //           context, '/home'),
                            //     );
                            //   } else {
                            //     showCupertinoDialog(
                            //       context: context,
                            //       builder: (context) => CupertinoAlertDialog(
                            //         title: const Text('Invalid Field'),
                            //         content:
                            //             const Text("Invalid Email/Password"),
                            //         actions: [
                            //           CupertinoDialogAction(
                            //             child: const Text('OK'),
                            //             onPressed: () {
                            //               Navigator.of(context).pop();
                            //             },
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   }
                            // },

                            // onPressed: () async {
                            //   if (emailController.text.isEmpty) {
                            //     setState(() {
                            //       emailError = true;
                            //     });
                            //     emailNode.requestFocus();
                            //   } else if (passwordController.text.isEmpty) {
                            //     setState(() {
                            //       passError = true;
                            //     });
                            //     passwordNode.requestFocus();
                            //   } else if (!RegExp(
                            //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            //       .hasMatch(emailController.text)) {
                            //     setState(() {
                            //       validEmail = true;
                            //     });
                            //     emailNode.requestFocus();
                            //   } else if (!RegExp(r'^.{8,}$')
                            //       .hasMatch(passwordController.text)) {
                            //     setState(() {
                            //       pass2Error = true;
                            //     });
                            //     passwordNode.requestFocus();
                            //     print('at least 8 length');
                            //   } else {
                            //     setState(() {
                            //       emailError = false;
                            //       passError = false;
                            //     });
                            //     final result = await authController.login(
                            //       emailController.text,
                            //       passwordController.text,
                            //     );
                            //     result.fold(
                            //       (error) => showCupertinoDialog(
                            //         context: context,
                            //         builder: (context) => CupertinoAlertDialog(
                            //           title: const Text('Error'),
                            //           content: Text(error),
                            //           actions: [
                            //             CupertinoDialogAction(
                            //               child: const Text('OK'),
                            //               onPressed: () {
                            //                 Navigator.of(context).pop();
                            //               },
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       (success) => Navigator.pushReplacementNamed(
                            //           context, '/home'),
                            //     );
                            //   }
                            // },
                            onPressed: () async {
                              if (emailController.text.isEmpty) {
                                setState(() {
                                  emailError = true;
                                });
                                if (passwordController.text.isEmpty) {
                                  setState(() {
                                    passError = true;
                                  });
                                }
                                emailNode.requestFocus();
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailController.text)) {
                                setState(() {
                                  validEmail = true;
                                });
                              } else if (passwordController.text.isEmpty) {
                                setState(() {
                                  passError = true;
                                });
                                passwordNode.requestFocus();
                              } else if (!RegExp(r'^.{8,}$')
                                  .hasMatch(passwordController.text)) {
                                setState(() {
                                  pass2Error = true;
                                });
                                passwordNode.requestFocus();
                                print('at least 8 length');
                              } else {
                                setState(() {
                                  emailError = false;
                                  passError = false;
                                });
                                print('succesfully login');
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
                              }
                            },
                            text: 'Login',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                            key: Key('login-to-signup-button'),
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

  passwordField() {
    return CupertinoTextField(
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')), // Disallow spaces
      ],
      focusNode: passwordNode,
      onChanged: (value) {
        value = passwordController.text;
        if (value.isEmpty) {
          setState(() {
            passError = true;
          });
        } else if (!RegExp(r'^.{8,}$').hasMatch(passwordController.text)) {
          setState(() {
            pass2Error = true;
          });
          passwordNode.requestFocus();
          print('at least 8 length');
        } else {
          setState(() {
            passError = false;
            pass2Error = false;
          });
        }
      },
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        // color: CupertinoColors.black,
        border: Border.all(
            color: passError || pass2Error
                ? Colors.red
                : CupertinoColors.systemGrey4),
        borderRadius: BorderRadius.circular(8.0),
      ),
      obscureText: _obscureText,
      textInputAction: TextInputAction.done,
    );
  }

  emailfield() {
    return CupertinoTextField(
      key: Key('login-email-text-field'),
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')), // Disallow spaces
      ],
      onChanged: (value) {
        value = emailController.text;
        if (value.isEmpty) {
          setState(() {
            emailError = true;
          });
        } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          setState(() {
            validEmail = true;
          });
        } else {
          setState(() {
            log('emailError');
            emailError = false;
            validEmail = false;
          });
        }
      },
      focusNode: emailNode,
      prefix: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Icon(
          Icons.email_outlined,
          color: Color(0xffC5C1C1),
        ),
      ),
      // maxLength: 12,
      controller: emailController,
      placeholder: 'Email',
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        // color: CupertinoColors.black,
        border: Border.all(
            color: emailError || validEmail
                ? Colors.red
                : CupertinoColors.systemGrey4),
        borderRadius: BorderRadius.circular(8.0),
      ),
      //obscureText: _obscureText,
      textInputAction: TextInputAction.done,
    );
  }
}
