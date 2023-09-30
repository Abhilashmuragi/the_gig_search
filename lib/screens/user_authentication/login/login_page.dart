import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_gig_workers_app/main.dart';
import 'package:the_gig_workers_app/screens/user_authentication/reset_password/reset_password_page.dart';
import 'package:the_gig_workers_app/utils/widgets/components.dart';

import '../../../utils/values/colors.dart';
import '../../../utils/values/numerics.dart';
import '../../../utils/values/strings.dart';
import '../../../utils/widgets/custom_form_button.dart';
import '../../../utils/widgets/custom_input_field.dart';

class LoginPage extends StatefulWidget {
  static String id = '/LoginPage';

  final VoidCallback onClickLoginSignup;

  const LoginPage({super.key, required this.onClickLoginSignup});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;
  bool loginError = false;

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
                                    Strings.login,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 28),
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
                                  const SizedBox(height: Numerics.formFieldGap),
                                  CustomInputField(
                                    controller: _passwordController,
                                    labelText: Strings.password,
                                    hintText: Strings.yourPassword,
                                    obscureText: true,
                                    suffixIcon: true,
                                    validator: (textValue) {
                                      if (textValue == null || textValue.isEmpty) {
                                        return Strings.passwordRequired;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: Numerics.formFieldGap),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () => navigatorKey.currentState!.pushNamed(ResetPasswordPage.id),
                                      child: Text(
                                        Strings.forgotPass,
                                        style: GoogleFonts.poppins()
                                            .copyWith(fontSize: 12, fontWeight: FontWeight.normal, color: ColorSys.authBlue),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomFormButton(
                                    innerText: Strings.login,
                                    onPressed: _handleLoginUser,
                                  ),
                                  if (loginError)
                                    Column(
                                      children: [
                                        const SizedBox(height: 18),
                                        Text(Strings.loginError,
                                            style: GoogleFonts.poppins()
                                                .copyWith(fontSize: 14, color: Colors.red, fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                  const SizedBox(height: 52),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Text(Strings.orContinueWith,
                                            style: GoogleFonts.poppins().copyWith(fontSize: 12, fontWeight: FontWeight.normal)),
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
                                      Image.asset(Strings.facebookLogo),
                                      const SizedBox(width: 24),
                                      Image.asset(Strings.googleLogo),
                                      const SizedBox(width: 24),
                                      Image.asset(Strings.linkedinLogo),
                                    ],
                                  ),
                                  const SizedBox(height: Numerics.scaffoldBottomMargin),
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
                                Strings.dontHaveAccount,
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  setState(() {
                                    widget.onClickLoginSignup();
                                  })
                                },
                                child: Text(
                                  Strings.signup,
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLoginUser() async {
    if (formKey.currentState!.validate() == false) return;

    //show loading circle
    showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));

    // login user
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Components.showSnackBar(e.message);
      setState(() {
        loginError = true;
      });
    }

    //pop the loading circle
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
