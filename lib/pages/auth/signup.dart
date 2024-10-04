import 'package:flutter/material.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/widgets/custom_textfield.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> signUp() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            CustomFormField(
              title: 'Email',
              form: CustomTextField(
                type: TextInputType.emailAddress,
                controller: _emailController,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomFormField(
              title: 'Password',
              form: CustomTextField(
                controller: _passwordController,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomFormField(
              title: 'Confirm Password',
              form: CustomTextField(
                controller: _confirmPasswordController,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            TextButton(
              onPressed: () {},
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
              child: const Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
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
    );
  }
}
