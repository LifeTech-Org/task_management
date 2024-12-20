import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool isCreatingUser = false;

  Future<void> signUp(BuildContext context) async {
    try {
      if (_passwordController.text.trim() ==
          _confirmPasswordController.text.trim()) {
        setState(() {
          isCreatingUser = true;
        });
        final credential = await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        await _firestore.collection("users").doc(credential.user!.uid).set({
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
        });
        // await _auth.signInWithEmailAndPassword(
        //     email: _emailController.text.trim(),
        //     password: _passwordController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created successfully!')));
        setState(() {
          isCreatingUser = false;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Unmatched Password!')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong!')));
      setState(() {
        isCreatingUser = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              CustomFormField(
                title: 'Name',
                form: CustomTextField(
                  controller: _nameController,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
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
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomFormField(
                title: 'Confirm Password',
                form: CustomTextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              CustomButton(
                text: 'Register',
                action: () => signUp(context),
                isLoading: isCreatingUser,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  InkWell(
                    child: Text('Register'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
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
