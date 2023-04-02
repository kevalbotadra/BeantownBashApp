import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thriftly/data/providers/auth_provider.dart';
import 'package:thriftly/logic/auth/auth_bloc.dart';
import 'package:thriftly/logic/auth/auth_event.dart';
import 'package:thriftly/logic/auth/auth_state.dart';
import 'package:thriftly/presentation/auth/login_page.dart';
import 'package:thriftly/presentation/auth/register_page.dart';
import 'package:thriftly/presentation/home/home.dart';
import 'package:thriftly/presentation/landing.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
    create: (context) =>
        AuthBloc(AuthProvider(firebaseAuth: FirebaseAuth.instance))
          ..add(AppStarted()),
    child: const MyApp(),
  ));
}

//main directory
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "heal",
      home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        print(state);

        if (state is Authenticated) {
          return Home();
        }

        if (state is StartLoginState) {
          return LoginPage(
              authProvider:
                  new AuthProvider(firebaseAuth: FirebaseAuth.instance));
        }

        if (state is StartRegistrationState) {
          return RegistrationPage(
              authProvider:
                  new AuthProvider(firebaseAuth: FirebaseAuth.instance));
        }

        if (state is Unauthenticated) {
          return LandingPage();
        }

        return LandingPage();
      }),
    );
  }
}
