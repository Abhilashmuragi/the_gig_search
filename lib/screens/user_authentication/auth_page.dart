import 'package:flutter/material.dart';
import 'package:the_gig_workers_app/screens/user_authentication/login/login_page.dart';
import 'package:the_gig_workers_app/screens/user_authentication/signup/signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin ? LoginPage(onClickLoginSignup: toggle) : SignUpPage(onClickLoginSignup: toggle);

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
