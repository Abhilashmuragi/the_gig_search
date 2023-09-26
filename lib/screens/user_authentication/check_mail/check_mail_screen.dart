import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../utils/constants/strings.dart';

class CheckMailScreen extends StatefulWidget {
  const CheckMailScreen({super.key});

  @override
  State<CheckMailScreen> createState() => _CheckMailScreenState();
}

class _CheckMailScreenState extends State<CheckMailScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.grey;
    const fillColor = Colors.white;
    const borderColor = Colors.grey;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
    );

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
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 61, right: 16),
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
                            Text(Strings.typeSentCode("email@gmail.com"),
                                style: GoogleFonts.poppins().copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal)),
                            const SizedBox(
                              height: 18,
                            ),
                            Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Directionality(
                                    // Specify direction if desired
                                    textDirection: TextDirection.ltr,
                                    child: Pinput(
                                      length: 6,
                                      controller: pinController,
                                      focusNode: focusNode,
                                      androidSmsAutofillMethod:
                                          AndroidSmsAutofillMethod
                                              .smsUserConsentApi,
                                      listenForMultipleSmsOnAndroid: true,
                                      defaultPinTheme: defaultPinTheme,
                                      separatorBuilder: (index) =>
                                          const SizedBox(width: 12),
                                      validator: (value) =>
                                          _handleCheckMail(value),
                                      hapticFeedbackType:
                                          HapticFeedbackType.lightImpact,
                                      cursor: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 9),
                                            width: 22,
                                            height: 1,
                                            color: focusedBorderColor,
                                          ),
                                        ],
                                      ),
                                      focusedPinTheme: defaultPinTheme.copyWith(
                                        decoration: defaultPinTheme.decoration!
                                            .copyWith(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: focusedBorderColor),
                                        ),
                                      ),
                                      submittedPinTheme:
                                          defaultPinTheme.copyWith(
                                        decoration: defaultPinTheme.decoration!
                                            .copyWith(
                                          color: fillColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: focusedBorderColor),
                                        ),
                                      ),
                                      errorPinTheme:
                                          defaultPinTheme.copyBorderWith(
                                        border:
                                            Border.all(color: Colors.redAccent),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      focusNode.unfocus();
                                      formKey.currentState!.validate();
                                    },
                                    child: const Text(Strings.validate),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Strings.codeNotReceived,
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  resendCode()))
                                    },
                                    child: Text(
                                      'Resend Code',
                                      style: GoogleFonts.poppins().copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0XFF2805FF)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }

  String? _handleCheckMail(String? value) {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting data..')),
      );
    }
    return null;
  }

  resendCode() {}
}

class PinCodeTextField {}
