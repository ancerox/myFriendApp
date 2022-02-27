import 'package:flutter/material.dart';
import 'package:my_friend/src/config/screen_size.dart';

class CustomImput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Icon prefixIcon;
  final bool obscureText;

  const CustomImput({
    Key? key,
    required this.obscureText,
    required this.textEditingController,
    required this.hintText,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.heightSize(context, 2.0)),
      height: SizeConfig.heightSize(context, 7.0),
      width: SizeConfig.widthSize(context, 80),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(
                0.0,
                0.0,
              ),
              blurRadius: 8.0,
              spreadRadius: 0.0,
            ), //BoxShad
          ]),
      child: Center(
        child: TextField(
          obscureText: obscureText,
          textAlign: TextAlign.left,
          controller: textEditingController,
          // controller: // Todo Later,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: TextStyle(
              height: 1.1,
              fontSize: SizeConfig.heightSize(context, 1.6),
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
          ),
          key: key,
        ),
      ),
    );
  }
}
