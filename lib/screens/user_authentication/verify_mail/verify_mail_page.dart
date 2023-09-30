import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_gig_workers_app/screens/home_page/home_page.dart';
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
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isEmailVerified == true
        ? const HomePage()
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
                                      Text(
                                        Strings.checkMail,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins().copyWith(
                                          fontSize: 28,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 28),
                                      Text(Strings.checkVerificationMail(FirebaseAuth.instance.currentUser!.email!),
                                          style: GoogleFonts.poppins().copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
                                      const SizedBox(height: 52),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              Strings.codeNotReceived,
                                              style: GoogleFonts.poppins().copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            GestureDetector(
                                              onTap: () => _canResendMail ? _sendVerificationMail() : null,
                                              child: Text(
                                                'Resend Verification mail',
                                                style: GoogleFonts.poppins().copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: _canResendMail ? ColorSys.authBlue : Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      Text("You can re send verification mail every 60 seconds.",
                                          style: GoogleFonts.poppins().copyWith(fontSize: 12, fontWeight: FontWeight.normal)),
                                      const SizedBox(height: 18),
                                      if (_verifyMailError)
                                        Text(Strings.verifyMailError,
                                            style: GoogleFonts.poppins()
                                                .copyWith(fontSize: 14, color: Colors.red, fontWeight: FontWeight.normal)),
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
}
