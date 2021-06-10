import 'package:flutter/material.dart';

class BmiTextFields extends StatelessWidget {
  final String hintText;
  final EdgeInsets? edgeInsets;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final Function? onSubmitted;

  const BmiTextFields(
      {Key? key,
      required this.hintText,
      this.edgeInsets,
      this.textInputAction,
      required this.controller,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: edgeInsets,
      child: TextField(
        onSubmitted: onSubmitted as void Function(String)?,
        controller: controller,
        textDirection: TextDirection.ltr,
        style: const TextStyle(
            color: Colors.white, letterSpacing: 1, fontSize: 20),
        textInputAction: textInputAction,
        keyboardType: TextInputType.number,
        cursorColor: Colors.white38,
        cursorHeight: 25,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white70, fontSize: 18),
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white60)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
