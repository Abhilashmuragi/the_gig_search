import 'package:flutter/material.dart';
import 'package:the_gig_workers_app/main.dart';
import 'package:the_gig_workers_app/screens/home_page/home_page.dart';

import '../../utils/values/numerics.dart';
import '../../utils/values/strings.dart';
import '../../utils/widgets/slider_indicator.dart';
import '../../utils/widgets/slider_page.dart';

class IntroSliderWorkerPage extends StatefulWidget {
  static String id = '/introSliderWorkerPage';

  const IntroSliderWorkerPage({Key? key}) : super(key: key);

  @override
  State<IntroSliderWorkerPage> createState() => _IntroSliderWorkerPageState();
}

class _IntroSliderWorkerPageState extends State<IntroSliderWorkerPage> {
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
                  if (currentIndex == 5) navigatorKey.currentState!.pushNamed(HomePage.id);
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
    SliderPage(image: Strings.introWorkerImage_1, title: Strings.introWorkerTitle_1, content: Strings.introWorkerContent_1),
    SliderPage(image: Strings.introWorkerImage_2, title: Strings.introWorkerTitle_2, content: Strings.introWorkerContent_2),
    SliderPage(image: Strings.introWorkerImage_3, title: Strings.introWorkerTitle_3, content: Strings.introWorkerContent_3),
    SliderPage(image: Strings.introWorkerImage_4, title: Strings.introWorkerTitle_4, content: Strings.introWorkerContent_4),
    SliderPage(image: Strings.introWorkerImage_5, title: Strings.introWorkerTitle_5, content: Strings.introWorkerContent_5),
    SliderPage(image: Strings.introWorkerImage_6, title: Strings.introWorkerTitle_6, content: Strings.introWorkerContent_6),
  ];
}
