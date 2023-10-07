import 'package:flutter/material.dart';
import 'package:the_gig_workers_app/main.dart';
import 'package:the_gig_workers_app/screens/home_page/home_page.dart';

import '../../utils/values/numerics.dart';
import '../../utils/values/strings.dart';
import '../../utils/widgets/slider_indicator.dart';
import '../../utils/widgets/slider_page.dart';

class IntroSliderEmployerPage extends StatefulWidget {
  static String id = '/introSliderEmployerPage';

  const IntroSliderEmployerPage({Key? key}) : super(key: key);

  @override
  State<IntroSliderEmployerPage> createState() => _IntroSliderEmployerPageState();
}

class _IntroSliderEmployerPageState extends State<IntroSliderEmployerPage> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
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
                  if (currentIndex == 3) navigatorKey.currentState!.pushNamed(HomePage.id);
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10), child: Text(currentIndex == 3 ? Strings.letsGo : Strings.next)),
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
  for (int i = 0; i < 4; i++) {
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
    SliderPage(image: Strings.introEmployerImage_1, title: Strings.introEmployerTitle_1, content: Strings.introEmployerContent_1),
    SliderPage(image: Strings.introEmployerImage_2, title: Strings.introEmployerTitle_2, content: Strings.introEmployerContent_2),
    SliderPage(image: Strings.introEmployerImage_3, title: Strings.introEmployerTitle_3, content: Strings.introEmployerContent_3),
    SliderPage(image: Strings.introEmployerImage_4, title: Strings.introEmployerTitle_4, content: Strings.introEmployerContent_4),
  ];
}
