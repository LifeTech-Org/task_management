import 'package:flutter/material.dart';
import 'package:task_management/pages/auth/forget_password.dart';
import 'package:task_management/pages/auth/signup.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/pages/home.dart';
import 'package:task_management/widgets/custom_textfield.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
              const CustomFormField(
                form: CustomTextField(),
                title: 'Email',
              ),
              const SizedBox(
                height: 12,
              ),
              const CustomFormField(
                form: CustomTextField(),
                title: 'Password',
              ),
              const SizedBox(
                height: 36,
              ),
              CustomButton(
                text: 'Log In',
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
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
                          builder: (context) => const ForgetPassword(),
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
  });

  final String text;
  final Function action;

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
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
