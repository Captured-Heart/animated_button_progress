import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double sizeHeight(double h) {
    return MediaQuery.sizeOf(this).height * h;
  }

  double sizeWidth(double w) {
    return MediaQuery.sizeOf(this).width * w;
  }
}

extension DebugBorderWidgetExtension on Widget {
  Widget debugBorder({Color? color}) {
    if (kDebugMode) {
      return DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: color ?? Colors.red, width: 4),
        ),
        child: this,
      );
    } else {
      return this;
    }
  }
}
