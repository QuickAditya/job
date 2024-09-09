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

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool name = false;
  bool email = false;
  bool phone = false;
  bool phone2 = false;
  bool pass = false;
  bool pass2 = false;
  bool confPass = false;
  bool validEmail = false;

  FocusNode nameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmNode = FocusNode();
  FocusNode phoneNode = FocusNode();

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

                            // CupertinoTextField(
                            //   key: Key('signup-number-text-field'),
                            //   keyboardType: TextInputType.number,
                            //   prefix: Padding(
                            //     padding: EdgeInsets.only(left: 5),
                            //     child: Icon(
                            //       Icons.call,
                            //       color: Color(0xffC5C1C1),
                            //     ),
                            //   ),
                            //   maxLength: 10,
                            //   controller: numberController,
                            //   placeholder: 'Phone number',
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 16.0, vertical: 12.0),
                            //   decoration: BoxDecoration(
                            //     // color: CupertinoColors.black,
                            //     border: Border.all(
                            //         color: CupertinoColors.systemGrey4),
                            //     borderRadius: BorderRadius.circular(8.0),
                            //   ),
                            //   //  textInputAction: TextInputAction.done,
                            // ),
                            // const SizedBox(height: 20),

                            // CustomCupertinoTextField(
                            //   key: Key('signup-email-text-field'),
                            //   controller: emailController,
                            //   placeholder: 'Email Address',
                            //   prefixIcon: Icon(
                            //     Icons.email,
                            //     color: Color(0xffC5C1C1),
                            //   ),
                            // ),

                            nameField(),
                            Container(
                              //how to aligin container in left in screen in flutter
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 5, top: 3),
                              child: Text(name ? 'Enter name' : '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.red)),
                            ),
                            const SizedBox(height: 20),

                            phonefield(),
                            numberController.text.isEmpty
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 5, top: 3),
                                    child: Text(
                                        phone ? 'Enter phone number' : '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.red)),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 5, top: 3),
                                    child: Text(
                                        phone2 ? 'Length should be 10' : '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.red)),
                                  ),
                            const SizedBox(height: 20),

                            emailfield(),
                            emailController.text.isEmpty
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 5, top: 3),
                                    child: Text(email ? 'Enter email' : '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.red)),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 5, top: 3),
                                    child: Text(
                                        validEmail
                                            ? 'Enter valid email id'
                                            : '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.red)),
                                  ),
                            const SizedBox(height: 20),

                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                CupertinoTextField(
                                  key: Key('signup-password-text-field'),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\s')), // Disallow spaces
                                  ],
                                  focusNode: passwordNode,
                                  onChanged: (val) {
                                    val = passwordController.text;
                                    if (val.isEmpty) {
                                      setState(() {
                                        pass = true;
                                      });
                                    } else if (!RegExp(
                                            r'^.{8,}$') //max length 8
                                        .hasMatch(val)) {
                                      setState(() {
                                        pass2 = true;
                                      });
                                      print('invalid password');
                                    } else {
                                      setState(() {
                                        pass2 = false;
                                        pass = false;
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
                                  controller: passwordController,
                                  placeholder: 'Password',
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    // color: CupertinoColors.black,
                                    border: Border.all(
                                        color: pass || pass2
                                            ? Colors.red
                                            : CupertinoColors.systemGrey4),
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

                            passwordController.text.isEmpty
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 5, top: 3),
                                    child: Text(pass ? 'Enter password' : '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.red)),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 5, top: 3),
                                    child: Text(
                                        pass2
                                            ? 'Password length must be at leat 8'
                                            : '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.red)),
                                  ),
                            const SizedBox(height: 20),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                CupertinoTextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\s')), // Disallow spaces
                                  ],
                                  focusNode: confirmNode,
                                  onChanged: (val) {
                                    val = confpasswordController.text;
                                    if (val != passwordController.text) {
                                      setState(() {
                                        confPass = true;
                                      });
                                      print('password is not matching');
                                    } else {
                                      setState(() {
                                        confPass = false;
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
                                  controller: confpasswordController,
                                  placeholder: 'Confirm Password',
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    // color: CupertinoColors.black,
                                    border: Border.all(
                                        color: confPass
                                            ? Colors.red
                                            : CupertinoColors.systemGrey4),
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

                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 5, top: 3),
                              child: Text(
                                  confPass ? 'Password is not matching' : '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.red)),
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
                             
                              // onPressed: () async {
                              //   if ((_formKey.currentState?.validate() ??
                              //           false) &&
                              //       emailController.text.isNotEmpty &&
                              //       passwordController.text.isNotEmpty &&
                              //       nameController.text.isNotEmpty &&
                              //       numberController.text.isNotEmpty) {
                              //     final result = await authController.signup(
                              //       nameController.text,
                              //       emailController.text,
                              //       passwordController.text,
                              //       numberController.text,
                              //     );
                              //     result.fold(
                              //       (error) => showCupertinoDialog(
                              //         context: context,
                              //         builder: (context) =>
                              //             CupertinoAlertDialog(
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
                              //       // (success) => Navigator.pushReplacementNamed(
                              //       //     context, '/home'),
                              //       (success) => Navigator.pushReplacementNamed(
                              //           context, '/login'),
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
                              onPressed: () async {
                                if (nameController.text.isEmpty) {
                                  setState(() {
                                    name = true;
                                  });
                                  nameNode.requestFocus();
                                } else if (numberController.text.isEmpty) {
                                  setState(() {
                                    phone = true;
                                  });
                                  phoneNode.requestFocus();
                                } else if (emailController.text.isEmpty) {
                                  setState(() {
                                    email = true;
                                  });
                                  emailNode.requestFocus();
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(emailController.text)) {
                                  setState(() {
                                    validEmail = true;
                                  });
                                  emailNode.requestFocus();
                                  print('invalid email id');
                                }
                                //  else if (
                                //   // !RegExp(
                                //   //       r'(^(?:[+0]9)?[0-9]{10,12}$)') //max length 8
                                //   //   .hasMatch(numberController.text)
                                //   numberController.
                                //     ) {
                                //   setState(() {
                                //     phone2 = true;
                                //   });
                                //   // phoneNode.requestFocus();
                                //   print('invalid pass');
                                // }
                                else if (passwordController.text.isEmpty) {
                                  setState(() {
                                    pass = true;
                                  });
                                  passwordNode.requestFocus();
                                } else if (!RegExp(r'^.{8,}$') //max length 8
                                    .hasMatch(passwordController.text)) {
                                  setState(() {
                                    pass2 = true;
                                  });
                                  passwordNode.requestFocus();
                                  print('invalid password');
                                } else if (confpasswordController
                                    .text.isEmpty) {
                                  setState(() {
                                    confPass = true;
                                  });
                                  confirmNode.requestFocus();
                                  print('confirm pass empty');
                                } else if (confpasswordController.text !=
                                    passwordController.text) {
                                  setState(() {
                                    confPass = true;
                                  });
                                  confirmNode.requestFocus();
                                  print('password is not matching');
                                } else {
                                  if (confpasswordController.text ==
                                      passwordController.text) {
                                    setState(() {
                                      confPass = false;
                                      name = false;
                                      email = false;
                                      validEmail = false;
                                      phone = false;
                                      phone2 = false;
                                      pass = false;
                                      pass2 = false;
                                    });
                                    //  confirmNode.requestFocus();
                                    print('password is matching');
                                    print('registerd sucessfully');
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
                                      (success) =>
                                          Navigator.pushReplacementNamed(
                                              context, '/login'),
                                    );
                                  }
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

  nameField() {
    return CupertinoTextField(
      onChanged: (val) {
        val = nameController.text;
        int spaceCount = val.split(' ').length - 1; // Count spaces
        if (val.isEmpty || spaceCount > 2) {
          setState(() {
            name = true; // Show red border
          });
          if (spaceCount > 2) {
            // Prevent further input if more than 2 spaces
            String newValue = val.replaceAll(RegExp(r' +'), ' ');
            nameController.value = TextEditingValue(
              text: newValue,
              selection: TextSelection.fromPosition(
                TextPosition(offset: newValue.length),
              ),
            );
          }
        } else {
          setState(() {
            name = false; // Set border back to grey
          });
        }
      },
      focusNode: nameNode,
      prefix: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Icon(
          Icons.person,
          color: Color(0xffC5C1C1),
        ),
      ),
      maxLength: 12,
      controller: nameController,
      placeholder: 'Your Name',
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        border:
            Border.all(color: name ? Colors.red : CupertinoColors.systemGrey4),
        borderRadius: BorderRadius.circular(8.0),
      ),
      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(
      //       RegExp(r'[a-zA-Z\s]')), // Allow only letters and spaces
      // ],
      textInputAction: TextInputAction.done,
    );
    ;
  }

  phonefield() {
    return CupertinoTextField(
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      focusNode: phoneNode,
      onChanged: (val) {
        val = numberController.text;

        if (val.isEmpty) {
          setState(() {
            phone = true;
          });
        }
        //  else if (!RegExp(r'^.{8,}$') //max length 8
        //     .hasMatch()) {
        //   setState(() {
        //     phone2 = true;
        //   });
        //   print('invalid password');
        // }
        else {
          setState(() {
            phone = false;
            phone2 = false;
          });
        }
      },
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        // color: CupertinoColors.black,
        border: Border.all(
            color: phone || phone2 ? Colors.red : CupertinoColors.systemGrey4),
        borderRadius: BorderRadius.circular(8.0),
      ),
      //obscureText: _obscureText,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
    );
  }

  emailfield() {
    return CupertinoTextField(
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')), // Disallow spaces
      ],
      focusNode: emailNode,
      onChanged: (val) {
        val = emailController.text;
        if (val.isEmpty) {
          setState(() {
            log('emailError');
            email = true;
          });
        } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val)) {
          setState(() {
            validEmail = true;
          });
          print('invalid email id');
        } else {
          setState(() {
            log('correct email');
            email = false;
            validEmail = false;
          });
        }
      },
      prefix: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Icon(
          Icons.email_outlined,
          color: Color(0xffC5C1C1),
        ),
      ),
      // maxLength: 12,
      controller: emailController,
      placeholder: 'Email address',
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        // color: CupertinoColors.black,
        border: Border.all(
            color:
                email || validEmail ? Colors.red : CupertinoColors.systemGrey4),
        borderRadius: BorderRadius.circular(8.0),
      ),
      //obscureText: _obscureText,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
