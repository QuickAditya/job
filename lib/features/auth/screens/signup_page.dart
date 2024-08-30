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

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:job/features/auth/controllers/auth_controller.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true; // State variable for password visibility

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Signup'),
        backgroundColor: CupertinoColors.systemGrey6,
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text("TO MY JOBS"),
                    const SizedBox(
                      height: 50,
                    ),
                    CupertinoTextField(
                      controller: nameController,
                      placeholder: 'Name',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        // color: CupertinoColors.black,
                        border: Border.all(color: CupertinoColors.systemGrey4),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    CupertinoTextField(
                      controller: numberController,
                      placeholder: 'Number',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        // color: CupertinoColors.black,
                        border: Border.all(color: CupertinoColors.systemGrey4),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    CupertinoTextField(
                      controller: emailController,
                      placeholder: 'Email',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        // color: CupertinoColors.black,
                        border: Border.all(color: CupertinoColors.systemGrey4),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CupertinoTextField(
                          controller: passwordController,
                          placeholder: 'Password',
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            // color: CupertinoColors.black,
                            border:
                                Border.all(color: CupertinoColors.systemGrey4),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.done,
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Icon(
                            _obscureText
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
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
                    CupertinoButton(
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                    ),
                    const SizedBox(height: 10),
                    CupertinoButton.filled(
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: CupertinoColors.white,
                        ),
                      ),
                      onPressed: () async {
                        if ((_formKey.currentState?.validate() ?? false) &&
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
                              content: const Text("Invalid Email/Password"),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
