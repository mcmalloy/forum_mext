
import 'package:flutter/material.dart';

class AnimatedBubble extends StatefulWidget {
  final Image asset;
  final bool isTopItem;
  final Duration animationDuration;

  const AnimatedBubble({Key? key, required this.asset, required this.isTopItem, required this.animationDuration}) : super(key: key);

  @override
  State<AnimatedBubble> createState() => _AnimatedBubbleState();
}

class _AnimatedBubbleState extends State<AnimatedBubble> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _animationController = AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      )..repeat(reverse: true);
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
        rect: getPositionOfBubble().animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.linear,
        ))
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          }),
        child: Container(
          padding: EdgeInsets.all(72),
          height: 50,
          width: 50,
          child: widget.asset,
        ));
  }

  RelativeRectTween getPositionOfBubble(){
    if(widget.isTopItem){
      return RelativeRectTween(
        begin: RelativeRect.fromLTRB(110, -125, 0,200),
        end: RelativeRect.fromLTRB(110, -100, 0, 200),
      );
    } else {
      return RelativeRectTween(
        begin: RelativeRect.fromLTRB(0, 150, 100, 200),
        end: RelativeRect.fromLTRB(0, 200, 100, 200),
      );
    }
  }
}
