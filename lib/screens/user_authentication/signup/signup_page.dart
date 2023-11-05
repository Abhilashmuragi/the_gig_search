import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_gig_workers_app/screens/user_authentication/terms_and_conditions/terms_and_conditions_page.dart';
import 'package:the_gig_workers_app/utils/values/textStyles.dart';

import '../../../main.dart';
import '../../../utils/values/colors.dart';
import '../../../utils/values/statics.dart';
import '../../../utils/values/strings.dart';
import '../../../utils/widgets/custom_form_button.dart';
import '../../../utils/widgets/custom_input_field.dart';

class SignUpPage extends StatefulWidget {
  static String id = '/SignupPage';
  final VoidCallback onClickSwitchLoginSignup;

  const SignUpPage({Key? key, required this.onClickSwitchLoginSignup}) : super(key: key);

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
                                  Text(Strings.signup, textAlign: TextAlign.center, style: TextStyles.poppins28Normal()),
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
                                        return Strings.minCharacters;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 18),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: Strings.bySigningUp, style: TextStyles.poppins14w500(color: Colors.grey)),
                                        TextSpan(text: Strings.tAmpersandC, style: TextStyles.poppins14w500()),
                                        TextSpan(text: Strings.and, style: TextStyles.poppins14w500(color: Colors.grey)),
                                        TextSpan(text: Strings.privacyPolicy, style: TextStyles.poppins14w500()),
                                        TextSpan(
                                            text: Strings.learnMore,
                                            style: TextStyles.poppins14w500(color: ColorSys.authBlue),
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
                                        Text(Strings.signupError, style: TextStyles.poppins14Normal(color: Colors.red))
                                      ],
                                    ),
                                  const SizedBox(height: 18),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: signInWithGoogle,
                                        child: SizedBox(width: 70, height: 70, child: Image.asset(Strings.googleLogo)),
                                      ),
                                      const SizedBox(width: 24),
                                      if (Statics.isAppleSignInAvailable)
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: GestureDetector(
                                            onTap: signInWithApple,
                                            child: Image.asset("assets/images/user_authentication/apple_logo.png"),
                                          ),
                                        ),
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
                              Text(Strings.alreadySignedUp, style: TextStyles.poppins12Normal()),
                              const SizedBox(width: 2),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.onClickSwitchLoginSignup();
                                  });
                                },
                                child: Text(Strings.login, style: TextStyles.poppins12Normal(color: ColorSys.authBlue)),
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
      await _setUserSharedPref(_emailController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _signupError = true;
      });
    }

    //pop the loading circle
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(idToken: gAuth.idToken, accessToken: gAuth.accessToken);
    var authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    if (authResult.additionalUserInfo!.isNewUser) {
      await _setUserSharedPref(gUser.email);
    }
  }

  Future<void> _setUserSharedPref(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(email, true);
  }

  void signInWithLinkedIn() {}

  void signInWithApple() {}

  void addUserToFireStore() {}
}
