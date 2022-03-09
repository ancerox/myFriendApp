import 'package:flutter/material.dart';
import 'package:my_friend/src/config/utils/constants.dart';
import 'package:my_friend/src/config/utils/screen_size.dart';
import 'package:my_friend/src/config/utils/utils.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const CustomBtn({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: SizeConfig.heightSize(context, 8.0),
      width: Utils().getDeviceType() == 'phone'
          ? deviceWidth / 1.5
          : deviceWidth / 2.5,
      decoration: BoxDecoration(
        color: onPressed != null ? kContentColorLightTheme : Colors.grey[600],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        key: const Key('button'),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: Utils().getDeviceType() == 'phone' ? 18 : 45),
        ),
      ),
    );
  }
}
