import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_gig_workers_app/main.dart';

class HomePage extends StatefulWidget {
  static String id = "/homePage";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    removeSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 150,
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                FirebaseAuth.instance.signOut();
                navigatorKey.currentState!.popUntil((route) => route.isFirst);
              });
            },
            child: const Center(
                child: Text(
              "Log Out",
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }

  Future<void> removeSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(FirebaseAuth.instance.currentUser!.email!);
  }
}
