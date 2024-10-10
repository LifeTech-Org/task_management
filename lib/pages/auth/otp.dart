import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Otp extends StatefulWidget {
  const Otp({
    super.key,
    required this.email,
    required this.newPassword,
  });
  final String email;
  final String newPassword;
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String otp = "";
  final _auth = FirebaseAuth.instance;
  bool isVerifyingCode = false;

  Future<void> resetPassword(BuildContext context) async {
    try {
      setState(() {
        isVerifyingCode = true;
      });
      await _auth.confirmPasswordReset(
          code: otp, newPassword: widget.newPassword);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Code sent to email!')));
      setState(() {
        isVerifyingCode = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong!')));
      setState(() {
        isVerifyingCode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              'Enter the 5-digit that we have sent via the email ${widget.email}',
            ),
            OtpTextField(
              numberOfFields: 5,
              handleControllers: (List<TextEditingController?> controllers) {},
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
                setState(() {
                  otp = code;
                });
              },
            ),
            CustomButton(
              text: "Continue",
              action: resetPassword,
              isLoading: isVerifyingCode,
            )
          ],
        ),
      ),
    );
  }
}
