import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/data/providers/auth_provider.dart';
import 'package:thriftly/logic/auth/auth_bloc.dart';
import 'package:thriftly/logic/auth/auth_event.dart';
import 'package:thriftly/presentation/auth/widgets/rounded_input.dart';

class LoginPage extends StatelessWidget {
  final AuthProvider authProvider;

  const LoginPage({Key? key, required this.authProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = new TextEditingController();
    final TextEditingController passwordController =
        new TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xff060D14),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/thriftly-bc3f0.appspot.com/o/Mobile%20login-amico-2.png?alt=media&token=9b315977-97f0-47af-9da7-9a24465f680a",
              height: 300,
              width: 300,
            ),
            Text(
              "welcome to thriftly",
              style: GoogleFonts.beVietnamPro(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "please log in to continue",
              style: GoogleFonts.beVietnamPro(
                color: const Color(0xff0BA400),
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            WhiteRoundedCircularInput(
              icon: Icons.account_circle,
              placeholder: "Email",
              controller: emailController,
            ),
            WhiteRoundedCircularInput(
              icon: Icons.lock,
              placeholder: "Password",
              controller: passwordController,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: const Color(0xff0BA400),
              ),
              height: 53,
              width: 320,
              child: Center(
                child: MaterialButton(
                  onPressed: () {
                    authProvider.login(
                        email: emailController.text,
                        password: passwordController.text);
                    BlocProvider.of<AuthBloc>(context).add(LoggedIn());
                  },
                  child: Text(
                    "Log In",
                    style: GoogleFonts.beVietnamPro(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
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
                    BlocProvider.of<AuthBloc>(context)
                        .add(RegistrationRedirect());
                  },
                  child: Text(
                    "Register.",
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
      ),
    );
  }
}
