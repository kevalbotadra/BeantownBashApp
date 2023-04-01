import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/logic/auth/auth_bloc.dart';
import 'package:thriftly/logic/auth/auth_event.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff060D14),
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Image.network(
            "https://firebasestorage.googleapis.com/v0/b/thriftly-bc3f0.appspot.com/o/4210361-removebg-preview.png?alt=media&token=57c60af6-c2fc-4bf4-980e-725187f5c742",
            height: 400,
            width: 400,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "thriftly",
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "thrifting clothes socially",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(RegistrationRedirect());
            },
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: const Color(0xff0BA400),
              ),
              child: Center(
                child: Text(
                  "Get Started",
                  style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Have an account.",
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(LoginRedirect());
                },
                child: Text(
                  "Log In.",
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xff0BA400),
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
