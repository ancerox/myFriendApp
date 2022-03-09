import 'package:flutter/material.dart';
import 'package:my_friend/src/config/utils/screen_size.dart';

class RegisterImage extends StatelessWidget {
  const RegisterImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('registerimage'),
      width: SizeConfig.widthSize(context, 70.0),
      child: const Image(
        fit: BoxFit.fill,
        image: AssetImage('assets/icons/Texting-pana.png'),
      ),
    );
  }
}
