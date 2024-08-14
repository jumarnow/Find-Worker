import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/sign_up_controller.dart';
import 'package:myapp/widgets/input_auth.dart';
import 'package:myapp/widgets/input_auth_password.dart';
import 'package:myapp/widgets/secondary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final signUpController = Get.put(SignUpController());
  @override
  void dispose() {
    signUpController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/signin_background.png',
                  fit: BoxFit.fitWidth,
                ),
                Center(
                  child: Image.asset(
                    'assets/applogo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: Transform.translate(
                    offset: const Offset(0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'New Account',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        DView.height(8),
                        const Text("Let's grow your business today"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          DView.height(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                InputAuth(
                  editingController: signUpController.edtName,
                  hint: 'Write your name',
                  title: 'Complate Name',
                ),
                DView.height(20),
                InputAuth(
                  editingController: signUpController.edtEmail,
                  hint: 'Write your email',
                  title: 'Email Address',
                ),
                DView.height(20),
                InputAuthPassword(
                  editingController: signUpController.edtPassword,
                  hint: 'Write your password',
                  title: 'Password',
                ),
                DView.height(30),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Material(
                        borderRadius: BorderRadius.circular(6),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    DView.height(8),
                    const Text(
                      'I agree with terms and condisions',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                DView.height(30),
                Obx(() {
                  bool loading = signUpController.loading;
                  if (loading) {
                    return DView.loadingCircle();
                  }
                  return FilledButton(
                      onPressed: () {
                        signUpController.excecute(context);
                      },
                      child: const Text('Sign Up'));
                }),
                DView.height(16),
                SecondaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Sign In to My Account'),
                ),
              ],
            ),
          ),
          DView.height(30),
        ],
      ),
    );
  }
}
