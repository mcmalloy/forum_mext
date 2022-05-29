import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class OnboardingTextBody extends StatelessWidget {
  final String bodyText;
  const OnboardingTextBody({Key? key, required this.bodyText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(bottom: 12), child: Text(
      bodyText,
      style: GoogleFonts.roboto(
          fontSize: 16,
          color: HexColor("#3f3d56"),
          fontWeight: FontWeight.bold),
    ),);
  }
}
