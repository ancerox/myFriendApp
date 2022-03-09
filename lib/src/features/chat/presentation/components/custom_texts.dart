import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_friend/src/config/utils/constants.dart';

class AuthText extends StatelessWidget {
  final String text;

  const AuthText({Key? key, required this.text}) : super(key: key);

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.volkhov(
          color: kContentColorLightTheme.withOpacity(0.8),
          textStyle: const TextStyle(fontSize: 55)),
    );
  }
}

class TextHomePage extends StatelessWidget {
  final String text;
  final double? fontSize;

  const TextHomePage({Key? key, required this.text, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: kContentColorLightTheme,
          textStyle: TextStyle(fontSize: fontSize)),
    );
  }
}
