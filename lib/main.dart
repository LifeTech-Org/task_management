import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/home.dart';
import 'package:task_management/pages/onboard.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final stream = FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),
      home: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return SignIn();
            } else {
              return Home();
            }
          }),
    );
  }
}
