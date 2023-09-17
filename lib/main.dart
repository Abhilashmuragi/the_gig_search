import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:the_gig_workers_app/screens/intro_slider/intro_slider_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The GIG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IntroSliderScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
