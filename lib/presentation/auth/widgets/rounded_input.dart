import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteRoundedCircularInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController controller;
  const WhiteRoundedCircularInput(
      {Key? key, required this.icon, required this.placeholder, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 320,
        height: 53,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.white),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(
                this.icon,
                color: const Color(0xff0BA400),
                size: 40,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Flexible(
              child: TextField(
                controller: controller,
                obscureText: placeholder.contains("Password") ? true : false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: this.placeholder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
