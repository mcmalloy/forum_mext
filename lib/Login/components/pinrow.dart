import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

class PinRow extends StatefulWidget {
  final List<String> selectedPins;
  const PinRow({Key? key, required this.selectedPins}) : super(key: key);

  @override
  State<PinRow> createState() => _PinRowState();
}

class _PinRowState extends State<PinRow> {
  HexColor forumTheme = HexColor("#3f3d56");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: MediaQuery.of(context).size.width * 0.80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedSwitcher(
            duration: Duration(seconds: 3),
            child: pinContainer(0),
          ),
          pinContainer(1),
          pinContainer(2),
          pinContainer(3),
          pinContainer(4),
          pinContainer(5),
        ],
      ),
    );
  }

  Widget pinContainer(int index) {
    bool isSelected =
        (index < widget.selectedPins.length && widget.selectedPins.isNotEmpty);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.linearToEaseOut,
      height: isSelected ? 24 : 2,
      width: 24,
      decoration: BoxDecoration(
          color: forumTheme,
          borderRadius: BorderRadius.circular(isSelected ? 12 : 0)),
      //child: switcher(index),
    );
  }
}
