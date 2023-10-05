import 'package:flutter/material.dart';
import 'package:the_gig_workers_app/screens/user_authentication/login/login_page.dart';
import 'package:the_gig_workers_app/screens/user_authentication/signup/signup_page.dart';

class AuthPage extends StatefulWidget {
  static String id = '/authPage';
  static bool isLogin = true;

  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  static String id = '/authPage';
  bool isLogin = AuthPage.isLogin;

  @override
  Widget build(BuildContext context) => isLogin ? LoginPage(onClickLoginSignup: toggle) : SignUpPage(onClickSwitchLoginSignup: toggle);

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
