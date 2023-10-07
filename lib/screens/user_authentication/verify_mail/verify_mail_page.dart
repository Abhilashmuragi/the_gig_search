import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_gig_workers_app/screens/home_page/home_page.dart';
import 'package:the_gig_workers_app/screens/intro_slider/intro_slider.dart';
import 'package:the_gig_workers_app/utils/values/textStyles.dart';
import 'package:the_gig_workers_app/utils/widgets/components.dart';

import '../../../utils/values/colors.dart';
import '../../../utils/values/strings.dart';

class VerifyMail extends StatefulWidget {
  static String id = '/verifyMail';

  const VerifyMail({Key? key}) : super(key: key);

  @override
  State<VerifyMail> createState() => _VerifyMailState();
}

class _VerifyMailState extends State<VerifyMail> {
  bool _isEmailVerified = false;
  bool _verifyMailError = false;
  bool _canResendMail = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (_isEmailVerified == false) {
      _sendVerificationMail();
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) => _checkEmailVerified());
      _setUserSharedPref();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isEmailVerified == true
        ? FutureBuilder(
            future: isNewUser(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Components.showSnackBar("Some Error has occurred please try again");
                } else if (snapshot.hasData) {
                  return snapshot.data ? const IntroSliderPage() : const HomePage();
                } else {
                  return Components.showSnackBar("Some Error has occurred please try again");
                }
              } else {
                return Components.showSnackBar("Some Error has occurred please try again");
              }
            },
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, top: 61, right: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(Strings.checkMail, textAlign: TextAlign.center, style: TextStyles.poppins28Normal()),
                                      const SizedBox(height: 28),
                                      Text(Strings.checkVerificationMail(FirebaseAuth.instance.currentUser!.email!),
                                          style: TextStyles.poppins14Normal()),
                                      const SizedBox(height: 52),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(Strings.codeNotReceived, style: TextStyles.poppins14Normal()),
                                            const SizedBox(width: 5),
                                            GestureDetector(
                                              onTap: () => _canResendMail ? _sendVerificationMail() : null,
                                              child: Text(
                                                Strings.resendVerifyMail,
                                                style: TextStyles.poppins14Normal(color: _canResendMail ? ColorSys.authBlue : Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      Text(Strings.resendAfterXSeconds, style: TextStyles.poppins12Normal()),
                                      const SizedBox(height: 18),
                                      if (_verifyMailError)
                                        Text(Strings.verifyMailError, style: TextStyles.poppins14Normal(color: Colors.red)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future _sendVerificationMail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        _verifyMailError = false;
        _canResendMail = false;
      });
      await Future.delayed(const Duration(seconds: 60));
      setState(() {
        _canResendMail = true;
      });
    } catch (e) {
      Components.showSnackBar(e.toString());
      setState(() {
        _verifyMailError = true;
      });
    }
  }

  Future _checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (_isEmailVerified) {
      _timer?.cancel();
    }
  }

  Future<void> _setUserSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(FirebaseAuth.instance.currentUser!.email!, true);
  }

  Future<bool> isNewUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(FirebaseAuth.instance.currentUser!.email!) ?? false;
  }
}
