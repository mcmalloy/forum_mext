import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:forum_mext/Login/choose_municipalities_page.dart';
import 'package:forum_mext/Login/components/animatedBubble.dart';
import 'package:forum_mext/Login/components/login_dynamic_button.dart';
import 'package:forum_mext/Login/pin_page.dart';
import 'package:forum_mext/Mock/statestorage_mock.dart';
import 'package:forum_mext/Onboarding/onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  //TODO: Feature Recommendations
  /// When opening the app - check if user has logged in before
  /// If false, the top button should be "Vælg din kommune"
  /// Else, it should save the name of the last selected municipality
  ///
  /// Log ind med MitID should not be shown if the accessToken is still valid, and a pincode has been saved

  HexColor forumTheme = HexColor("#3f3d56");
  late AnimationController bubble1Controller;
  bool showMunicipalityList = false;
  bool hasSelectedMunicipality = false;
  GlobalKey<_LoginPageState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bubble1Controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);
    bubble1Controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: forumTheme,
      body: Stack(
        alignment: Alignment.center,
        children: [
          background(), // Background at bottom layer
          schultzLogo(),
          AnimatedBubble(
              asset: Image.asset("assets/bubble1-optimized.png"),
              isTopItem: true,
              animationDuration: Duration(milliseconds: 2500)),
          AnimatedBubble(
              asset: Image.asset("assets/bubble2-optimized.png"),
              isTopItem: false,
              animationDuration: Duration(milliseconds: 3000)),
          Positioned(
            bottom: 210,
            left: 60,
            child: Text(
              "Log ind",
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          loginWidget()
        ],
      ),
    );
  }

  Widget loginWidget() {
    return Positioned(
        bottom: 130,
        left: 60,
        child: Wrap(
          spacing: 12,
          alignment: WrapAlignment.start,
          direction: Axis.vertical,
          children: [dynamicLoginButton()],
        ));
  }

  Widget dynamicLoginButton() {
    StateStorageMock storageMock = StateStorageMock();
    if (!storageMock.hasAccessToken()) {
      return LoginButton(
        loginFunction: goToMunicipalityPage,
        buttonText: "LOG IN MED",
        asset: "assets/mitId.png",
      );
      //remove '!' negation
    } else if (!storageMock.NoAccessToken() &&
        !storageMock.lastSelectedMunicipality().isEmpty) {
      return LoginButton(
          loginFunction: goToOnboardingPage, buttonText: "Vælg din kommune");
    } else {
      return LoginButton(
          loginFunction: goToOnboardingPage,
          buttonText: storageMock.lastSelectedMunicipality());
    }
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

  Widget schultzLogo() {
    return Positioned(
        top: 100,
        child: Row(
          children: [
            const Image(
                height: 56,
                width: 56,
                image: AssetImage("assets/forumLogo.png")),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "Schultz Forum",
                style: GoogleFonts.roboto(
                    color: forumTheme,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }

  Widget imageAsset() {
    return const Positioned(
        top: 180,
        child: Image(
          height: 300,
          width: 300,
          image: Svg("assets/forum_next.svg"),
        ));
  }

  loginToMunicipality(String municipality){
    print("municipality: " + municipality);
    Navigator.pop(context);
  }

  goToMunicipalityPage() {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => MuniciPalityListPage(key: _key,),
    );
  }

  goToOnboardingPage() {
    bool showOnboarding = true; // mock that we haven't shown onboarding before
    if (showOnboarding) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const OnboardPage(), fullscreenDialog: false),
      );
    }
  }

  goToPinPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => const PinPage(), fullscreenDialog: false),
    );
  }

}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double startHeight = size.height / 1.5; // original (size.height - 240)
    double endHeight = size.height / 1.5;
    double maxHeight = size.height / 1.65; // original  size.height - 330

    path.lineTo(0.0, startHeight);

    path.quadraticBezierTo(size.width / 2, maxHeight, size.width, endHeight);

    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
