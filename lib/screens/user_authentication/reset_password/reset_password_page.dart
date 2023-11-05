import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_gig_workers_app/main.dart';
import 'package:the_gig_workers_app/screens/user_authentication/auth_page.dart';
import 'package:the_gig_workers_app/utils/widgets/components.dart';

import '../../../utils/values/colors.dart';
import '../../../utils/values/strings.dart';
import '../../../utils/values/textStyles.dart';
import '../../../utils/widgets/custom_form_button.dart';
import '../../../utils/widgets/custom_input_field.dart';

class ResetPasswordPage extends StatefulWidget {
  static String id = '/resetPassword';

  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

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
                        child: Form(
                          key: _loginFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.resetPass, textAlign: TextAlign.center, style: TextStyles.poppins28Normal()),
                                  const SizedBox(height: 28),
                                  Text(Strings.willMailInstruction, style: TextStyles.poppins14Normal()),
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
                                  CustomFormButton(
                                    innerText: Strings.sendLink,
                                    onPressed: _handleResetPassword,
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
                              Text(Strings.dontHaveAccount, style: TextStyles.poppins12Normal()),
                              GestureDetector(
                                onTap: () {
                                  AuthPage.isLogin = false;
                                  navigatorKey.currentState!.popUntil((route) {
                                    return route.isFirst;
                                  });
                                  navigatorKey.currentState!.pushNamed(AuthPage.id);
                                },
                                child: Text(
                                  Strings.signup,
                                  style: TextStyles.poppins12Normal(color: ColorSys.authBlue),
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

  Future _handleResetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      Components.showSnackBar(Strings.resetMailSent);
    } on FirebaseAuthException catch (e) {
      Components.showSnackBar(Strings.resetMailSendError);
    }
  }
}
