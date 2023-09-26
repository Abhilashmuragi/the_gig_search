import 'package:flutter/material.dart';

import 'package:the_gig_workers_app/screens/intro_slider/intro_slider_screen.dart';
import 'package:the_gig_workers_app/screens/user_authentication/login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    int screen = 1;
    return MaterialApp(
      title: 'The GIG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (screen == 0) ? const IntroSliderScreen() : const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
