import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_gig_workers_app/screens/home_page/sub_pages/worker/job_search_page/location/location_screen.dart';
import 'package:the_gig_workers_app/utils/values/colors.dart';

import 'bloc/home_page_bloc.dart';
import 'bloc/home_page_event.dart';
import 'bloc/home_page_state.dart';

class HomePage extends StatefulWidget {
  static String id = "/homePage";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  //TODO: Add check based on firestore value
  bool isWorker = true;

  @override
  void initState() {
    super.initState();
    removeSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => HomePageBloc(),
        child: BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
          if (state is HomePageLoaded) {
            return Scaffold(
                bottomNavigationBar: NavigationBar(
                  onDestinationSelected: (int index) {
                    context.read<HomePageBloc>().add(ChangeIndex(newIndex: index));
                  },
                  indicatorColor: ColorSys.bottomNavIndicatorColor,
                  selectedIndex: state.currentPageIndex,
                  destinations: const <Widget>[
                    NavigationDestination(
                      selectedIcon: Icon(Icons.home),
                      icon: Icon(Icons.home_outlined),
                      label: 'home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.business),
                      label: 'Business',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(Icons.school),
                      icon: Icon(Icons.school_outlined),
                      label: 'School',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(Icons.person_2),
                      icon: Icon(Icons.person_2_outlined),
                      label: 'Profile',
                    ),
                  ],
                ),
                body: <Widget>[
                  isWorker ? const LocationScreen() : Container(),
                  Container(
                    color: Colors.green,
                    alignment: Alignment.center,
                    child: const Text('Page 2'),
                  ),
                  Container(
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: const Text(''),
                  ),
                  Container(
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child:  TextButton(onPressed: (){
                      FirebaseAuth.instance.signOut();
                    }, child: const Text("Sign Out")),
                  ),
                ][state.currentPageIndex]);
          }
          return Container();
        }));
  }

  Future<void> removeSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(FirebaseAuth.instance.currentUser!.email!);
  }
}
