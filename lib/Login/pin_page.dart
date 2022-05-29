import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum_mext/Onboarding/onboarding.dart';
import 'package:forum_mext/login/components/pinrow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class PinPage extends StatefulWidget {
  const PinPage({Key? key}) : super(key: key);

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  HexColor forumTheme = HexColor("#3f3d56");
  TextEditingController pinController = TextEditingController();
  List<String> currentPin = [];
  @override
  void initState() {
    super.initState();
  }

  void setSelectedPins() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: forumTheme,
      body: Stack(
        alignment: Alignment.center,
        children: [
          background(),
          const Positioned(
              top: 120,
              child: Image(
                height: 72,
                image: AssetImage("assets/forumshield.png"),
              )),
          Positioned(
              top: 240,
              child: PinRow(
                selectedPins: currentPin,
              )),
          Positioned(bottom: 60, child: pinPad()),
          //skipPinButton()
          // Background at bottom layer
        ],
      ),
    );
  }

  Widget pinPad() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      height: 320,
      width: 300,
      child: Column(
        children: [
          pinRow(1, 2, 3),
          pinRow(4, 5, 6),
          pinRow(7, 8, 9),
          pinRow(10, 0, 11)
        ],
      ),
    );
  }

  Widget pinRow(int firstIndex, int secondIndex, int thirdIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          pinButton(firstIndex),
          pinButton(secondIndex),
          pinButton(thirdIndex),
        ],
      ),
    );
  }

  Widget pinButton(int index) {
    String _index = index.toString();
    if (index <= 9) {
      return InkWell(
        onTap: () {
          if(currentPin.length<6){
            setState(() {
              currentPin.add(index.toString());
            });
            if(currentPin.length == 6){
              //When user has typed in pin
              /*
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const OnboardPage(),
                    fullscreenDialog: false),
              );
               */
            }
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            _index,
            style: GoogleFonts.roboto(
                color: forumTheme, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else if (index == 10) {
      return biometricButton();
    }
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextButton(
          onPressed: () {
            setState(() {
              currentPin.removeLast();
            });
          },
          child: Icon(Icons.arrow_back_ios_new_rounded,
              color: forumTheme, size: 22),
        ));
  }

  Widget biometricButton() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Image(
        height: 32,
        image: AssetImage("assets/faceid.png"),
      ),
    );
  }

  Widget background() {
    return ClipPath(
      clipper: BackgroundClipper(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white, // The background color
      ),
    );
  }

  /// This widget should show a button with "Spring over" if the user is logging in, but has not yet created a pincode
  Widget skipPinButton(){
    return Positioned(
      top: 64,
      right: 16,
      child: TextButton(
        child: Text("Spring over", style: GoogleFonts.roboto(color: forumTheme, fontWeight: FontWeight.bold),),
        onPressed: () {},
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double startheight = size.height / 2;
    double endHeight = startheight;
    double maxHeight = size.height / 2.75;

    path.lineTo(
        0.0, startheight); // x0 is 0 so it starts rendering at {0, startHeight}

    path.quadraticBezierTo(size.width / 2, maxHeight, size.width, endHeight);

    path.lineTo(size.width,
        0.0); // xLast is size.width so it ends at the edge of the screen

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
