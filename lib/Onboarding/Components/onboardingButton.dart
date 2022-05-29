import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class OnboardingButton extends StatelessWidget {
  final String buttonText;
  final Function buttonFunction;
  const OnboardingButton({Key? key, required this.buttonText, required this.buttonFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0), color: HexColor("#3f3d56")),
      child: TextButton(
          onPressed: () {
            buttonFunction();
          },
          child: Text(
            buttonText,
            style: GoogleFonts.roboto(fontSize: 12, color: Colors.white),
          )),
    );
  }
}

