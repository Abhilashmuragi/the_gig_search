import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'jobs/jobs_bloc.dart';
import 'models/place_model.dart';
import 'repositories/geolocation/geolocation_repository.dart';
import 'repositories/jobs/jobs_repository.dart';
import 'repositories/local_storage/local_storage_repository.dart';
import 'repositories/places/places_repository.dart';
import 'screens/home_page/home_page.dart';
import 'screens/home_page/sub_pages/worker/job_search_page/autocomplete/autocomplete_bloc.dart';
import 'screens/home_page/sub_pages/worker/job_search_page/location/bloc/location_bloc.dart';
import 'screens/intro_slider/intro_slider.dart';
import 'screens/intro_slider/intro_slider_employer.dart';
import 'screens/intro_slider/intro_slider_worker.dart';
import 'screens/user_authentication/auth_page.dart';
import 'screens/user_authentication/linkedin.dart';
import 'screens/user_authentication/reset_password/reset_password_page.dart';
import 'screens/user_authentication/terms_and_conditions/terms_and_conditions_page.dart';
import 'screens/user_authentication/verify_mail/verify_mail_page.dart';
import 'utils/apple_sign_in_available.dart';
import 'utils/values/statics.dart';
import 'utils/widgets/components.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Statics.isAppleSignInAvailable = await AppleSignInAvailable.check() ?? false;

  await Hive.initFlutter();
  Hive.registerAdapter(PlaceAdapter());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static String id = '/myApp';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocationRepository>(
          create: (_) => GeolocationRepository(),
        ),
        RepositoryProvider<PlacesRepository>(
          create: (_) => PlacesRepository(),
        ),
        RepositoryProvider<JobsRepository>(
          create: (_) => JobsRepository(),
        ),
        RepositoryProvider<LocalStorageRepository>(
          create: (_) => LocalStorageRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => JobsBloc(
              jobRepository: context.read<JobsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AutocompleteBloc(
              placesRepository: context.read<PlacesRepository>(),
            )..add(const LoadAutocomplete()),
          ),
          BlocProvider(
            create: (context) => LocationBloc(
              geolocationRepository: context.read<GeolocationRepository>(),
              placesRepository: context.read<PlacesRepository>(),
              localStorageRepository: context.read<LocalStorageRepository>(),
              jobsRepository: context.read<JobsRepository>(),
            )..add(const LoadMap()),
          ),
        ],
        child: MaterialApp(
          scaffoldMessengerKey: messengerKey,
          navigatorKey: navigatorKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //user is logged in
                return const VerifyMail();
              } else {
                return const AuthPage();
              }
            },
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            MyApp.id: (context) => const MyApp(),
            IntroSliderPage.id: (context) => const IntroSliderPage(),
            HomePage.id: (context) => const HomePage(),
            ResetPasswordPage.id: (context) => const ResetPasswordPage(),
            TermsAndConditionsPage.id: (context) => const TermsAndConditionsPage(),
            VerifyMail.id: (context) => const VerifyMail(),
            AuthPage.id: (context) => const AuthPage(),
            IntroSliderWorkerPage.id: (context) => const IntroSliderWorkerPage(),
            IntroSliderEmployerPage.id: (context) => const IntroSliderEmployerPage(),
            LinkedIn.id: (context) => const LinkedIn(),
          },
        ),
      ),
    );
  }
}
