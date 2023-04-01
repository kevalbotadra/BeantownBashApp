import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/data/providers/auth_provider.dart';
import 'package:thriftly/logic/auth/auth_bloc.dart';
import 'package:thriftly/logic/auth/auth_event.dart';
import 'package:thriftly/presentation/auth/widgets/rounded_input.dart';

class RegistrationPage extends StatefulWidget {
  final AuthProvider authProvider;
  const RegistrationPage({Key? key, required this.authProvider})
      : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: const Color(0xff060D14),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 75,
            ),
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/thriftly-bc3f0.appspot.com/o/Mobile%20login-amico-2.png?alt=media&token=9b315977-97f0-47af-9da7-9a24465f680a",
              height: 300,
              width: 300,
            ),
            Text(
              "create a thriftly account",
              style: GoogleFonts.beVietnamPro(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "enter details",
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
              placeholder: "Name",
              controller: nameController,
            ),
            WhiteRoundedCircularInput(
              icon: Icons.account_circle,
              placeholder: "Email",
              controller: emailController,
            ),
            WhiteRoundedCircularInput(
              icon: Icons.phone,
              placeholder: "Phone Number",
              controller: phoneNumberController,
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
                    authBloc.add(SubmitSignUp(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phoneNumber: phoneNumberController.text));
                  },
                  child: Text(
                    "Register",
                    style: GoogleFonts.beVietnamPro(
                      color: Colors.white,
                      fontSize: 20,
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
                  "Already have an account?",
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
      ),
    );
  }
}
