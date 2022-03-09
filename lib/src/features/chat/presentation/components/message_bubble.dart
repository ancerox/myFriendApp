import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_friend/src/config/utils/screen_size.dart';

class BubbleMessage extends StatelessWidget {
  final String message;
  final String uid;
  final AnimationController animationController;

  const BubbleMessage(
      {Key? key,
      required this.message,
      required this.uid,
      required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _myMessage(context);
  }

  Widget _myMessage(context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Align(
            alignment:
                uid == '123' ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(11),
              margin: EdgeInsets.only(
                right: uid == '123' ? 10 : SizeConfig.widthSize(context, 20),
                bottom: 10,
                left: uid == '123' ? SizeConfig.widthSize(context, 29) : 20,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffff512f),
                    Color(0xffdd2476),
                  ],
                ),
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message,
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    textStyle: const TextStyle(fontSize: 17)),
              ),
            )),
      ),
    );
  }
}
