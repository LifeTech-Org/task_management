import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/pages/auth/forget_password.dart';
import 'package:task_management/pages/auth/signup.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/pages/home.dart';
import 'package:task_management/widgets/custom_textfield.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  bool isSigningIn = false;

  Future<void> signIn(BuildContext context) async {
    try {
      setState(() {
        isSigningIn = true;
      });
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Signed In successfully!')));
      setState(() {
        isSigningIn = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong!')));
      setState(() {
        isSigningIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomFormField(
                form: CustomTextField(
                  controller: _emailController,
                ),
                title: 'Email',
              ),
              const SizedBox(
                height: 12,
              ),
              CustomFormField(
                form: CustomTextField(
                  controller: _passwordController,
                ),
                title: 'Password',
              ),
              const SizedBox(
                height: 36,
              ),
              CustomButton(
                text: 'Login',
                action: () => signIn(context),
                isLoading: isSigningIn,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPassword(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forget Password?',
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
                  InkWell(
                    child: Text('Register'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.action,
    this.isLoading = false,
  });

  final String text;
  final Function action;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        action();
      },
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        minimumSize: const Size(
          double.infinity,
          50,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
    );
  }
}
