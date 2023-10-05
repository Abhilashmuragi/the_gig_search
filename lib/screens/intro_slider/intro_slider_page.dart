import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../utils/values/numerics.dart';
import '../../utils/values/strings.dart';
import '../../utils/widgets/slider_indicator.dart';
import '../../utils/widgets/slider_page.dart';

class IntroSliderPage extends StatefulWidget {
  static String id = '/introSliderPage';

  const IntroSliderPage({Key? key}) : super(key: key);

  @override
  State<IntroSliderPage> createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
    _handleSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
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
                controller: pageController,
                children: _sliderImages()),
          ),
          _buildIndicator(currentIndex),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.only(right: 23),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FilledButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: const BorderSide(color: Colors.black)),
                    )),
                onPressed: () {
                  if (pageController.hasClients) {
                    pageController.animateToPage(
                      pageController.page!.floor() + 1,
                      duration: const Duration(milliseconds: Numerics.sliderTransitionTimeMilliSeconds),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10), child: Text(currentIndex == 5 ? Strings.letsGo : Strings.next)),
              ),
            ),
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

Widget _buildIndicator(int currentIndex) {
  List<Widget> indicators = [];
  for (int i = 0; i < 6; i++) {
    if (currentIndex == i) {
      indicators.add(const SliderIndicator(isActive: true));
    } else {
      indicators.add(const SliderIndicator(isActive: false));
    }
  }
  return Container(
    margin: const EdgeInsets.only(left: 23),
    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: indicators),
  );
}

List<Widget> _sliderImages() {
  return const [
    SliderPage(image: Strings.introSliderImage_1, title: Strings.introStepTitle_1, content: Strings.introStepContent_1),
    SliderPage(image: Strings.introSliderImage_2, title: Strings.introStepTitle_2, content: Strings.introStepContent_2),
    SliderPage(image: Strings.introSliderImage_3, title: Strings.introStepTitle_3, content: Strings.introStepContent_3),
    SliderPage(image: Strings.introSliderImage_4, title: Strings.introStepTitle_4, content: Strings.introStepContent_4),
    SliderPage(image: Strings.introSliderImage_5, title: Strings.introStepTitle_5, content: Strings.introStepContent_5),
    SliderPage(image: Strings.introSliderImage_6, title: Strings.introStepTitle_6, content: Strings.introStepContent_6),
  ];
}

void _handleSplashScreen() async {
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}
