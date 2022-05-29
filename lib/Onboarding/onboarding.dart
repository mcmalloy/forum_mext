import 'package:flutter/material.dart';
import 'package:forum_mext/Onboarding/Components/onboardingTexts.dart';
import 'package:forum_mext/Onboarding/Module/onboarding_page_module.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import '../Login/pin_page.dart';
import 'Components/onboardingButton.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({Key? key}) : super(key: key);
  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  HexColor forumTheme = HexColor("#3f3d56");
  int _currentIndex = 0;
  final PageController pageController = PageController(initialPage: 0);

  skipOnBoarding() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => const PinPage(), fullscreenDialog: false),
    );
  }

  nextOnBoarding() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.linearToEaseOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: onBoardingPageView()),
          _currentIndex != 4
              ? Positioned(
                  bottom: 64,
                  child: PageViewDotIndicator(
                    currentItem: _currentIndex,
                    count: 5,
                    unselectedColor: forumTheme.withOpacity(0.4),
                    selectedColor: forumTheme,
                    size: const Size(12, 12),
                    unselectedSize: const Size(10, 10),
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    fadeEdges: false,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget onBoardingPageView() {
    List<Widget> onboardingButtons = [
      OnboardingButton(
          buttonText: "SPRING OVER", buttonFunction: skipOnBoarding),
      OnboardingButton(buttonText: "NÆSTE", buttonFunction: nextOnBoarding)
    ];
    return PageView(
      onPageChanged: _onPageChanged,
      controller: pageController,
      children: [
        OnboardingPageModule(
          assetName: "assets/onboarding_selfbook.svg",
          onboardingTitle: "Book",
          onboardingBodyText: OnBoardingText.onboardingDescription1,
          onboardingButtons: onboardingButtons,
        ),
        OnboardingPageModule(
          assetName: "assets/onboarding_chat.svg",
          onboardingTitle: "Chat",
          onboardingBodyText: OnBoardingText.onboardingDescription1,
          onboardingButtons: onboardingButtons,
        ),
        OnboardingPageModule(
          assetName: "assets/onboarding_news.svg",
          onboardingTitle: "Nyheder",
          onboardingBodyText: OnBoardingText.onboardingDescription1,
          onboardingButtons: onboardingButtons,
        ),
        OnboardingPageModule(
          assetName: "assets/pin.svg",
          onboardingTitle: "Login i Forum",
          onboardingBodyText: OnBoardingText.onboardingDescription1,
          onboardingButtons: [OnboardingButton(buttonText: "OPRET PINKODE", buttonFunction: nextOnBoarding)],
        ),
        //OnBoardingPinCodePage(nextFunction: nextOnBoarding),
        const PinPage()
      ],
    );
  }

  _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
