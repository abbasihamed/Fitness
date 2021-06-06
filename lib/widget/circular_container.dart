import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final Widget child;
  final Size? size;

  const CircularContainer({Key? key, required this.child, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size!.width * 0.3,
      height: size!.height * 0.3,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }
}
