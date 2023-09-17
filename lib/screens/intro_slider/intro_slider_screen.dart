import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:the_gig_workers_app/widgets/slider_indicator.dart';
import 'package:the_gig_workers_app/widgets/slider_page.dart';

import '../../utils/constants/strings.dart';

class IntroSliderScreen extends StatefulWidget {
  const IntroSliderScreen({Key? key}) : super(key: key);

  @override
  State<IntroSliderScreen> createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
    handleSplashScreen();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: <Widget>[
                SliderPage(
                    image: 'assets/images/intro_slider_1.png',
                    title: Strings.intoStepOneTitle,
                    content: Strings.introStepOneContent),
                SliderPage(
                    image: 'assets/images/intro_slider_2.png',
                    title: Strings.introStepTwoTitle,
                    content: Strings.introStepTwoContent),
                SliderPage(
                    image: 'assets/images/intro_slider_3.png',
                    title: Strings.introStepThreeTitle,
                    content: Strings.introStepThreeContent),
                SliderPage(
                    image: 'assets/images/intro_slider_4.png',
                    title: Strings.introStepFourTitle,
                    content: Strings.introStepFourContent),
                SliderPage(
                    image: 'assets/images/intro_slider_5.png',
                    title: Strings.introStepFiveTitle,
                    content: Strings.introStepFiveContent),
                SliderPage(
                    image: 'assets/images/intro_slider_6.png',
                    title: Strings.introStepSixTitle,
                    content: Strings.introStepSixContent),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _buildIndicator(),
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.only(right: 23),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FilledButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: Colors.black)),
                    )),
                onPressed: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      _pageController.page!.floor() + 1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(currentIndex == 5 ? "Let's go!" : "Next")),
              ),
            ),
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 6; i++) {
      if (currentIndex == i) {
        indicators.add(const SliderIndicator(isActive: true));
      } else {
        indicators.add(const SliderIndicator(
          isActive: false,
        ));
      }
    }
    return indicators;
  }
}

void handleSplashScreen() async {
  //Remove the splash screen after specified seconds
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}
