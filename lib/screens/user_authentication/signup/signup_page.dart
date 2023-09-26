import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_gig_workers_app/screens/user_authentication/login/login_page.dart';
import 'package:the_gig_workers_app/screens/user_authentication/terms_and_conditions/terms_and_conditions_screen.dart';

import '../../../components/common/custom_form_button.dart';
import '../../../components/common/custom_input_field.dart';
import '../../../utils/constants/strings.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _loginFormKey = GlobalKey<FormState>();
  bool rememberMe = false;

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
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 61, right: 16),
                        child: Form(
                          key: _loginFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Strings.login,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  CustomInputField(
                                      labelText: Strings.firstName,
                                      hintText: Strings.yourFirstName,
                                      prefixIcon: false,
                                      validator: (textValue) {
                                        if (textValue == null ||
                                            textValue.isEmpty) {
                                          return Strings.firstNameRequired;
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 18),
                                  CustomInputField(
                                      labelText: Strings.lastName,
                                      hintText: Strings.yourLastName,
                                      obscureText: true,
                                      prefixIcon: false,
                                      validator: (textValue) {
                                        if (textValue == null ||
                                            textValue.isEmpty) {
                                          return Strings.lastNameRequired;
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 18),
                                  CustomInputField(
                                      labelText: Strings.email,
                                      hintText: Strings.tempMail,
                                      validator: (textValue) {
                                        if (textValue == null ||
                                            textValue.isEmpty) {
                                          return Strings.emailRequired;
                                        }
                                        if (!EmailValidator.validate(
                                            textValue)) {
                                          return Strings.enterValidMail;
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 18),
                                  CustomInputField(
                                    labelText: Strings.password,
                                    hintText: Strings.yourPassword,
                                    obscureText: true,
                                    suffixIcon: true,
                                    validator: (textValue) {
                                      if (textValue == null ||
                                          textValue.isEmpty) {
                                        return Strings.passwordRequired;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 18),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: Strings.bySigningUp,
                                          style: TextStyle(
                                            color: Color(0xFF747980),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: Strings.tAmpersandC,
                                          style: TextStyle(
                                            color: Color(0xFF312E49),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: Strings.and,
                                          style: TextStyle(
                                            color: Color(0xFF747980),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: Strings.privacyPolicy,
                                          style: TextStyle(
                                            color: Color(0xFF312E49),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        TextSpan(
                                            text: Strings.learnMore,
                                            style: const TextStyle(
                                              color: Color(0xFF2705FF),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const TermsAndConditionsScreen()));
                                              }),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  CustomFormButton(
                                    innerText: Strings.continu,
                                    onPressed: _handleLoginUser,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/images/user_authentication/facebook_logo.png'),
                                      const SizedBox(width: 24),
                                      Image.asset(
                                          'assets/images/user_authentication/google_logo.png'),
                                      const SizedBox(width: 24),
                                      Image.asset(
                                          'assets/images/user_authentication/linkedin_logo.png'),
                                    ],
                                  ),
                                  const SizedBox(height: 120)
                                ],
                              ),
                            ],
                          ),
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
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()))
                                },
                                child: Text(
                                  Strings.login,
                                  style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0XFF2805FF)),
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

  void _handleLoginUser() {
    // login user
    if (_loginFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting data..')),
      );
    }
  }
}
