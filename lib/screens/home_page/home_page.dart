import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String id = "/homePage";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 150,
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
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
}
