import 'package:flutter/material.dart';

class Utils {
  String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

    return data.size.width < 550 ? 'phone' : 'tablet';
  }
}
