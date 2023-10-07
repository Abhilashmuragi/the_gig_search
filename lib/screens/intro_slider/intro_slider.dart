import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_gig_workers_app/main.dart';

import '../../utils/values/colors.dart';
import '../../utils/values/strings.dart';
import '../../utils/values/textStyles.dart';

class IntroSliderPage extends StatefulWidget {
  static String id = '/introSliderPage';

  const IntroSliderPage({Key? key}) : super(key: key);

  @override
  State<IntroSliderPage> createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  var selectedIndex = 2;

  @override
  void initState() {
    super.initState();
  }

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
                Image.asset("assets/images/app_logo/gig_logo.png"),
                Padding(
                  padding: const EdgeInsets.only(top: 46, left: 16, right: 32),
                  child: Column(children: [
                    Align(alignment: Alignment.topLeft, child: Text("Join Us!", style: TextStyles.poppins30w700())),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "To begin this journey, tell us what type of account you’d be opening"
                        ".",
                        style: TextStyles.poppins18Normal(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 108,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        shadows: const [BoxShadow(color: Color(0x0F000000), blurRadius: 14, offset: Offset(0, 2), spreadRadius: 1)],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, left: 41, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 52,
                                width: 52,
                                child: SvgPicture.asset(selectedIndex == 0
                                    ? "assets/images/intro_slider/worker_polygon_selected.svg"
                                    : "assets/images/intro_slider/worker_polygon_unselected.svg")),
                            const SizedBox(width: 28),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Individual", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                                SizedBox(height: 13),
                                Text(
                                  "Looking for Jobs",
                                  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 108,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        shadows: const [BoxShadow(color: Color(0x0F000000), blurRadius: 14, offset: Offset(0, 2), spreadRadius: 1)],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, left: 41, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 52,
                                width: 52,
                                child: SvgPicture.asset(
                                  selectedIndex == 1
                                      ? "assets/images/intro_slider/company_polygon_selected.svg"
                                      : "assets/images/intro_slider/company_polygon_unselected.svg",
                                )),
                            const SizedBox(width: 28),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Company", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                                SizedBox(height: 13),
                                Text(
                                  "Looking for Staff",
                                  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
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
}
