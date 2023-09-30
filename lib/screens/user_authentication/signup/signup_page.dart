import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_gig_workers_app/screens/user_authentication/terms_and_conditions/terms_and_conditions_page.dart';
import 'package:the_gig_workers_app/utils/widgets/components.dart';

import '../../../main.dart';
import '../../../utils/values/colors.dart';
import '../../../utils/values/strings.dart';
import '../../../utils/widgets/custom_form_button.dart';
import '../../../utils/widgets/custom_input_field.dart';

class SignUpPage extends StatefulWidget {
  static String id = '/SignupPage';
  final VoidCallback onClickLoginSignup;

  const SignUpPage({Key? key, required this.onClickLoginSignup}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _signupError = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 61, right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Strings.signup,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  CustomInputField(
                                      controller: _firstNameController,
                                      labelText: Strings.firstName,
                                      hintText: Strings.yourFirstName,
                                      prefixIcon: false,
                                      validator: (textValue) {
                                        if (textValue == null || textValue.isEmpty) {
                                          return Strings.firstNameRequired;
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 18),
                                  CustomInputField(
                                      controller: _lastNameController,
                                      labelText: Strings.lastName,
                                      hintText: Strings.yourLastName,
                                      obscureText: true,
                                      prefixIcon: false,
                                      validator: (textValue) {
                                        if (textValue == null || textValue.isEmpty) {
                                          return Strings.lastNameRequired;
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 18),
                                  CustomInputField(
                                      controller: _emailController,
                                      labelText: Strings.email,
                                      hintText: Strings.tempMail,
                                      validator: (textValue) {
                                        if (textValue == null || textValue.isEmpty) {
                                          return Strings.emailRequired;
                                        }
                                        if (!EmailValidator.validate(textValue)) {
                                          return Strings.enterValidMail;
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 18),
                                  CustomInputField(
                                    controller: _passwordController,
                                    labelText: Strings.password,
                                    hintText: Strings.yourPassword,
                                    obscureText: true,
                                    suffixIcon: true,
                                    validator: (textValue) {
                                      if (textValue == null || textValue.isEmpty) {
                                        return Strings.passwordRequired;
                                      } else if (textValue.length < 6) {
                                        return "Password should contain minimum 6 characters.";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 18),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: Strings.bySigningUp,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: Strings.tAmpersandC,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: Strings.and,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: Strings.privacyPolicy,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        TextSpan(
                                            text: Strings.learnMore,
                                            style: const TextStyle(
                                              color: ColorSys.authBlue,
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                navigatorKey.currentState!.pushNamed(TermsAndConditionsPage.id);
                                              }),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  CustomFormButton(
                                    innerText: Strings.continu,
                                    onPressed: _handleSignupUser,
                                  ),
                                  if (_signupError)
                                    Column(
                                      children: [
                                        const SizedBox(height: 18),
                                        Text(Strings.signupError,
                                            style: GoogleFonts.poppins()
                                                .copyWith(fontSize: 14, color: Colors.red, fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                  const SizedBox(height: 18),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(Strings.facebookLogo),
                                      const SizedBox(width: 24),
                                      Image.asset(Strings.googleLogo),
                                      const SizedBox(width: 24),
                                      Image.asset(Strings.linkedinLogo),
                                    ],
                                  ),
                                  const SizedBox(height: 120)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Strings.alreadySignedUp,
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 2),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.onClickLoginSignup();
                                  });
                                },
                                child: Text(
                                  Strings.login,
                                  style:
                                      GoogleFonts.poppins().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: ColorSys.authBlue),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignupUser() async {
    if (formKey.currentState!.validate() == false) return;
    //show loading circle
    showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));
    // sign Up
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Components.showSnackBar(e.message);
      setState(() {
        _signupError = true;
      });
    }

    //pop the loading circle
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
