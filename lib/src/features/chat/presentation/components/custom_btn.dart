import 'package:flutter/material.dart';
import 'package:my_friend/src/config/constants.dart';
import 'package:my_friend/src/config/screen_size.dart';

class CustomBtn extends StatelessWidget {
  final String text;

  const CustomBtn({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightSize(context, 8.0),
      width: SizeConfig.widthSize(context, 60.0),
      decoration: BoxDecoration(
        color: kContentColorLightTheme,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        key: const Key('button'),
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.heightSize(context, 1.9)),
        ),
      ),
    );
  }
}
