import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerTextFields extends StatelessWidget {
  final TextEditingController controller;
  final Function? onChange;
  final TextInputAction action;

  const TimerTextFields(
      {Key? key,
      required this.controller,
       this.onChange,
      required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 30,
      child: TextField(
        onChanged: onChange as void Function(String)?,
        controller: controller,
        style: GoogleFonts.roboto(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textInputAction: action,
        maxLength: 2,
        cursorColor: Colors.yellowAccent,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 10),
          hintText: '00',
          counterText: '',
          hintStyle: GoogleFonts.openSans(color: Colors.grey, fontSize: 20),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellowAccent),
          ),
        ),
      ),
    );
  }
}
