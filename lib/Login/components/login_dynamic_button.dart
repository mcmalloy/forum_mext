import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback loginFunction;
  final String buttonText;
  final String? asset;
  const LoginButton(
      {Key? key,
      required this.loginFunction,
      required this.buttonText,
      this.asset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loginFunction,
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey.withOpacity(0.4),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText + " ",
              style: GoogleFonts.roboto(
                color: HexColor("#fafafa"),
                fontSize: 18,
              ),
            ),
            asset != null ?
            Image(
              height: 15,
              image: AssetImage(asset!),
            ) : Container()
          ],
        ),
      ),
    );
  }
}
