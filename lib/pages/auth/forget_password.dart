import 'package:flutter/material.dart';
import 'package:task_management/pages/auth/otp.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isSendingCode = false;

  Future<void> resetPassword(BuildContext context) async {
    try {
      setState(() {
        isSendingCode = true;
      });
      await _auth.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Code sent to email!')));
      setState(() {
        isSendingCode = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Otp(
            email: _emailController.text.trim(),
            newPassword: _passwordController.text.trim(),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong!')));
      setState(() {
        isSendingCode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            CustomFormField(
              title: 'Email',
              form: CustomTextField(
                controller: _emailController,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            CustomFormField(
              title: 'New Password',
              form: CustomTextField(
                controller: _passwordController,
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            CustomFormField(
              title: 'Confirm New Password',
              form: CustomTextField(
                controller: _confirmPasswordController,
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            CustomButton(
              text: 'Continue',
              isLoading: isSendingCode,
              action: () => resetPassword(context),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
