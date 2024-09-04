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
                    const Text("JOB PORTAL"),
                    const SizedBox(
                      height: 50,
                    ),
                    CupertinoTextField(
                      key: const Key('signup-name-text-field'),
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
                      key: const Key('signup-number-text-field'),
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
                      key: const Key('signup-email-text-field'),
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
                          key: const Key('signup-password-text-field'),
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
                          key: const Key('signup-eye-button'),
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
                      key: const Key('signup-to-login-button'),
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
                      key: const Key('signup-button'),
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
