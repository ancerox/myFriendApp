import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showCustomAlert(BuildContext context, String title, String subtitle) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: [
                MaterialButton(
                  child: Text('Ok'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }
  return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ));
}
