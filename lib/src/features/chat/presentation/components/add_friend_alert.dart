import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:my_friend/src/config/helpers/alerts.dart';
import 'package:my_friend/src/config/utils/constants.dart';
import 'package:my_friend/src/config/utils/friends_service.dart';

Future<dynamic> addFriend(
    BuildContext contextBuilder, TextEditingController _controller) {
  return showDialog(
      context: contextBuilder,
      builder: (contextBuilder) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              decoration: BoxDecoration(),
              width: 100,
              height: 150,
              child: Stack(children: [
                Align(
                  // These values are based on trial & error method
                  alignment: Alignment(1.475, -1.6),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(contextBuilder);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Input your friends email',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    TextField(
                      style: TextStyle(fontSize: 20),
                      controller: _controller,
                    ),
                    Spacer(flex: 2),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 150,
                      child: TextButton(
                        onPressed: () async {
                          final userExist =
                              await FriendsService.addFriend(_controller.text);
                          if (userExist) {
                            showCustomAlert(
                                contextBuilder,
                                'Friend has been added',
                                'You just added a new fried');
                          } else if (userExist == false) {
                            showCustomAlert(
                                contextBuilder,
                                'This user does not exist',
                                'please try with another email');
                          }
                        },
                        child: Text(
                          'Agregar',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ));
      });
}

void showFloatingFlushbar(BuildContext context) {
  Flushbar(
    padding: EdgeInsets.all(10),

    borderRadius: BorderRadius.circular(20),
    backgroundGradient: LinearGradient(
      colors: [Colors.green.shade800, Colors.greenAccent.shade700],
      stops: [0.6, 1],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    // All of the previous Flushbars could be dismissed by swiping down
    // now we want to swipe to the sides
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    // The default curve is Curves.easeOut
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: 'This is a floating Flushbar',
    message: 'Lorem ipsum dolor sit amet',
  )..show(context);
}
