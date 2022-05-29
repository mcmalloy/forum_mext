import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Login/components/onboardingTitle.dart';
import '../Components/onboardingButton.dart';
import '../Components/onboardingPictureComponent.dart';
import '../Components/onboardingTextBody.dart';
import '../Components/onboardingTexts.dart';

class OnboardingPageModule extends StatefulWidget {
  final String assetName;
  final String onboardingTitle;
  final String onboardingBodyText;
  final List<Widget> onboardingButtons;

  const OnboardingPageModule(
      {Key? key,
      required this.assetName,
      required this.onboardingTitle,
      required this.onboardingBodyText, required this.onboardingButtons})
      : super(key: key);

  @override
  State<OnboardingPageModule> createState() => _OnboardingPageModuleState();
}

class _OnboardingPageModuleState extends State<OnboardingPageModule> {
  HexColor forumTheme = HexColor("#3f3d56");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OnboardingPicture(assetName: widget.assetName),
                OnboardingTitle(title: widget.onboardingTitle),
                const OnboardingTextBody(
                    bodyText: OnBoardingText.onboardingDescription1),
                buttonRow()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.onboardingButtons
      ),
    );
  }
}
