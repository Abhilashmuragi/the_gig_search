import 'package:flutter/material.dart';

import 'package:the_gig_workers_app/screens/intro_slider/intro_slider_page.dart';
import 'package:the_gig_workers_app/screens/user_authentication/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_gig_workers_app/screens/user_authentication/login/login_page.dart';
import 'package:the_gig_workers_app/screens/user_authentication/signup/signup_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static String id = '/myApp';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        SignUpPage.id: (context) => const SignUpPage(),
        MyApp.id: (context) => const MyApp()
      },
    );
  }
}
