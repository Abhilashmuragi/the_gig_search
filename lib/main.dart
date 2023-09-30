import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_gig_workers_app/screens/home_page/home_page.dart';
import 'package:the_gig_workers_app/screens/intro_slider/intro_slider_page.dart';
import 'package:the_gig_workers_app/screens/user_authentication/auth_page.dart';
import 'package:the_gig_workers_app/screens/user_authentication/check_mail/check_mail_page.dart';
import 'package:the_gig_workers_app/screens/user_authentication/reset_password/reset_password_page.dart';
import 'package:the_gig_workers_app/screens/user_authentication/terms_and_conditions/terms_and_conditions_page.dart';
import 'package:the_gig_workers_app/screens/user_authentication/verify_mail/verify_mail_page.dart';
import 'package:the_gig_workers_app/utils/widgets/components.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static String id = '/myApp';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: messengerKey,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //user is logged in
            return const VerifyMail();
          } else {
            return const AuthPage();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        MyApp.id: (context) => const MyApp(),
        IntroSliderPage.id: (context) => const IntroSliderPage(),
        HomePage.id: (context) => const HomePage(),
        ResetPasswordPage.id: (context) => const ResetPasswordPage(),
        CheckMailPage.id: (context) => const CheckMailPage(),
        ResetPasswordPage.id: (context) => const ResetPasswordPage(),
        TermsAndConditionsPage.id: (context) => const TermsAndConditionsPage(),
        VerifyMail.id: (context) => const VerifyMail(),
      },
    );
  }
}
