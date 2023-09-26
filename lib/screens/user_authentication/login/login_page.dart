import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_gig_workers_app/screens/user_authentication/reset_password/reset_password_screen.dart';
import 'package:the_gig_workers_app/screens/user_authentication/signup/signup_page.dart';

import '../../../components/common/custom_form_button.dart';
import '../../../components/common/custom_input_field.dart';
import '../../../utils/constants/strings.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                                    'Login',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 28),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 16,
                                            width: 16,
                                            child: Checkbox(
                                                activeColor: Colors.transparent,
                                                checkColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    side: const BorderSide(
                                                      width: 12,
                                                    )),
                                                side:
                                                    const BorderSide(width: 1),
                                                value: rememberMe,
                                                onChanged: (value) {
                                                  setState(() {
                                                    rememberMe = value ?? false;
                                                  });
                                                }),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            Strings.rememberMe,
                                            style:
                                                GoogleFonts.poppins().copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ResetPasswordScreen()))
                                          },
                                          child: Text(
                                            Strings.forgotPass,
                                            style: GoogleFonts.poppins()
                                                .copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: const Color(
                                                        0XFF2805FF)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  CustomFormButton(
                                    innerText: Strings.login,
                                    onPressed: _handleLoginUser,
                                  ),
                                  const SizedBox(height: 52),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(Strings.orContinueWith,
                                            style: GoogleFonts.poppins()
                                                .copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                      ),
                                      Flexible(
                                        child: Container(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 52),
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
                                Strings.dontHaveAccount,
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()))
                                },
                                child: Text(
                                  Strings.signup,
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
