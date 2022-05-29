import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class OnboardingPicture extends StatelessWidget {
  final String assetName;
  const OnboardingPicture({Key? key, required this.assetName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 128),
      child: Image(
        height: 300,
        width: 300,
        image: Svg(assetName),
      ),
    );
  }
}
