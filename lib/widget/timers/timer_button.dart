import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  final VoidCallback onPress;

  final Widget child;
  final EdgeInsets? margin;
  final ButtonStyle style;
  final Size? size;

  const TimerButton(
      {Key? key,
      required this.onPress,
      required this.child,
      this.margin,
      required this.style,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size!.width * 0.25,
      height: size!.height * 0.05,
      margin: margin,
      color: Colors.transparent,
      child: ElevatedButton(onPressed: onPress, child: child, style: style),
    );
  }
}
