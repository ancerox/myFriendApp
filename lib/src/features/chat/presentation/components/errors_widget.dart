import 'package:flutter/material.dart';
import 'package:my_friend/src/config/utils/screen_size.dart';

class Errors extends StatelessWidget {
  final String text;
  const Errors({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('errorswidget'),
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.widthSize(context, 15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.align_vertical_center_rounded, color: Colors.red),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(color: Colors.red),
          )
        ],
      ),
    );
  }
}
