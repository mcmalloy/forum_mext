import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class OnboardingTitle extends StatelessWidget {
  final String title;
  const OnboardingTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.roboto(
            fontSize: 28,
            color: HexColor("#3f3d56"),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
