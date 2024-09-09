// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:job/features/auth/controllers/auth_controller.dart';
// import 'package:job/utils/validators.dart';

// import 'widgets/custom_button.dart';
// import 'widgets/custom_text_field.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final authController = GetIt.instance<AuthController>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Signup')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               CustomTextField(
//                 controller: nameController,
//                 labelText: 'Name',
//                 validator: Validators.nameValidator,
//               ),
//               const SizedBox(height: 20),
//               CustomTextField(
//                 controller: emailController,
//                 labelText: 'Email',
//                 validator: Validators.emailValidator,
//               ),
//               const SizedBox(height: 20),
//               CustomTextField(
//                 controller: passwordController,
//                 labelText: 'Password',
//                 isPasswordField: true,
//                 validator: Validators.passwordValidator,
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                 onPressed: () async {
//                   if (_formKey.currentState?.validate() ?? false) {
//                     final result = await authController.signup(
//                       nameController.text,
//                       emailController.text,
//                       passwordController.text,
//                     );
//                     result.fold(
//                       (error) => ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(error)),
//                       ),
//                       (success) =>
//                           Navigator.pushReplacementNamed(context, '/home'),
//                     );
//                   }
//                 },
//                 child: const Text(
//                   'Signup',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () =>
//                     Navigator.pushReplacementNamed(context, '/login'),
//                 child: const Text(
//                   "Already have an account? Login",
//                 ),
//               ),
//               TextButton(
//                   onPressed: () =>
//                       Navigator.pushReplacementNamed(context, '/home'),
//                   child: const Text("Home Page"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:job/features/auth/controllers/auth_controller.dart';
import 'package:job/features/auth/screens/widgets/custom_text_field.dart';
import 'package:job/features/home/controllers/home_controller.dart';
import 'package:job/utils/custombutton.dart';
import 'package:job/utils/validators.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confpasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true; // State variable for password visibility
  bool obstext = true; // State variable for password visibility

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<AuthController>(
      builder: (_, auth, __) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Signup'),
            backgroundColor: CupertinoColors.systemGrey6,
          ),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
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
                              height: 50,
                            ),
                            const Text('TO MY JOBS'),
                            const SizedBox(
                              height: 50,
                            ),

                            CustomCupertinoTextField(
                              key: Key('signup-name-text-field'),
                              controller: nameController,
                              placeholder: 'Your Name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xffC5C1C1),
                              ),
                            ),
                            const SizedBox(height: 20),

                            CupertinoTextField(
                              key: Key('signup-number-text-field'),
                              keyboardType: TextInputType.number,
                              prefix: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.call,
                                  color: Color(0xffC5C1C1),
                                ),
                              ),
                              maxLength: 10,
                              controller: numberController,
                              placeholder: 'Phone number',
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                // color: CupertinoColors.black,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey4),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              //  textInputAction: TextInputAction.done,
                            ),
                            const SizedBox(height: 20),

                            CustomCupertinoTextField(
                              key: Key('signup-email-text-field'),
                              controller: emailController,
                              placeholder: 'Email Address',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xffC5C1C1),
                              ),
                            ),

                            const SizedBox(height: 20),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                CupertinoTextField(
                                  key: Key('signup-password-text-field'),
                                  prefix: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Icon(
                                      Icons.lock_open,
                                      color: Color(0xffC5C1C1),
                                    ),
                                  ),
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
                                     key:  Key('passwordVisibilityToggle'),

                              // key:     Key('signup-eye-button2'),
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
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                CupertinoTextField(
                                  prefix: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Icon(
                                      Icons.lock_open,
                                      color: Color(0xffC5C1C1),
                                    ),
                                  ),
                                  maxLength: 12,
                                  controller: confpasswordController,
                                  placeholder: 'Confirm Password',
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    // color: CupertinoColors.black,
                                    border: Border.all(
                                        color: CupertinoColors.systemGrey4),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  obscureText: obstext,
                                  textInputAction: TextInputAction.done,
                                ),
                                CupertinoButton(
                                                key: const Key('confirmPasswordVisibilityToggle'),
                                  // key: Key('signup-eye-button1'),
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    obstext
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obstext = !obstext;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // CupertinoButton.filled(
                            //   child: const Text(
                            //     'Signup',
                            //     style: TextStyle(
                            //       fontSize: 16.0,
                            //       color: CupertinoColors.white,
                            //     ),
                            //   ),
                            //   onPressed: () async {
                            //     if ((_formKey.currentState?.validate() ?? false) &&
                            //         emailController.text.isNotEmpty &&
                            //         passwordController.text.isNotEmpty &&
                            //         nameController.text.isNotEmpty &&
                            //         numberController.text.isNotEmpty) {
                            //       final result = await authController.signup(
                            //         nameController.text,
                            //         emailController.text,
                            //         passwordController.text,
                            //         numberController.text,
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
                            //         (success) => Navigator.pushReplacementNamed(
                            //             context, '/home'),
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
                              key: Key('signup-button'),
                              width: MediaQuery.of(context).size.width * 0.8,
                              text: 'Signup',
                              onPressed: () async {
                                if ((_formKey.currentState?.validate() ??
                                        false) &&
                                    emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty &&
                                    nameController.text.isNotEmpty &&
                                    numberController.text.isNotEmpty) {
                                  final result = await authController.signup(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    numberController.text,
                                  );
                                  result.fold(
                                    (error) => showCupertinoDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
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
                                    // (success) => Navigator.pushReplacementNamed(
                                    //     context, '/home'),
                                    (success) => Navigator.pushReplacementNamed(
                                        context, '/login'),
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
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RichText(
                              key: Key('signup-to-login-button'),
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    
                                    text: 'Already have an account?',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Handle the SignUp tap
                                        Navigator.pushReplacementNamed(
                                            context, '/login');
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
                  if (auth.isloading)
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
          ),
        );
      },
    );
  }
}
