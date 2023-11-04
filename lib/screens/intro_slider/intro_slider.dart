import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_gig_workers_app/main.dart';
import 'package:the_gig_workers_app/screens/intro_slider/intro_slider_employer.dart';
import 'package:the_gig_workers_app/screens/intro_slider/intro_slider_worker.dart';

import '../../utils/values/colors.dart';
import '../../utils/values/strings.dart';
import '../../utils/values/textStyles.dart';
import '../../utils/widgets/custom_form_button.dart';

class IntroSliderPage extends StatefulWidget {
  static String id = '/introSliderPage';

  const IntroSliderPage({Key? key}) : super(key: key);

  @override
  State<IntroSliderPage> createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  var selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 46),
            child: Column(
              children: [
                SizedBox(height: 100, width: 100, child: Image.asset("assets/images/app_logo/gig_logo.png")),
                Padding(
                  padding: const EdgeInsets.only(top: 46, left: 16, right: 32),
                  child: Column(children: [
                    Align(alignment: Alignment.topLeft, child: Text("Join Us!", style: TextStyles.poppins30w700())),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        Strings.chooseAccountType,
                        style: TextStyles.poppins18Normal(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Container(
                        height: 108,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: selectedIndex == 0 ? const Color(0xFFF5F9FF) : Colors.white,
                            border: Border.all(color: selectedIndex == 0 ? Colors.blue : Colors.white, width: 3.0),
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 14, offset: Offset(0, 2), spreadRadius: 1)]),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0, left: 41, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 52,
                                  width: 52,
                                  child: SvgPicture.asset(
                                      selectedIndex == 0 ? Strings.workerPolygonSelected : Strings.workerPolygonUnselected)),
                              const SizedBox(width: 28),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(Strings.individual,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                                  SizedBox(height: 13),
                                  Text(
                                    Strings.lookingJob,
                                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Container(
                        height: 108,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: selectedIndex == 1 ? const Color(0xFFF5F9FF) : Colors.white,
                            border: Border.all(color: selectedIndex == 1 ? Colors.blue : Colors.white, width: 3.0),
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 14, offset: Offset(0, 2), spreadRadius: 1)]),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0, left: 41, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 52,
                                  width: 52,
                                  child: SvgPicture.asset(
                                    selectedIndex == 1 ? Strings.companyPolygonSelected : Strings.companyPolygonUnselected,
                                  )),
                              const SizedBox(width: 28),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(Strings.company, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                                  SizedBox(height: 13),
                                  Text(
                                    Strings.lookingStaff,
                                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomFormButton(
                      innerText: Strings.next,
                      onPressed: () => _handleNext(selectedIndex),
                    ),
                  ]),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 55),
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
                          navigatorKey.currentState!.popUntil((route) => route.isFirst);
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
      )),
    );
  }

  _handleNext(int selectedIndex) {
    if (selectedIndex == 0) {
      navigatorKey.currentState!.pushNamed(IntroSliderWorkerPage.id);
    } else if (selectedIndex == 1) {
      navigatorKey.currentState!.pushNamed(IntroSliderEmployerPage.id);
    }
  }
}
