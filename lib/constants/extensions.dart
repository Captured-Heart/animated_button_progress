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


extension LayoutExtension on BuildContext {
  bool layout(LayoutEnums layoutEnums) {
    switch (layoutEnums) {
      case LayoutEnums.mobile:
        return isMobile();
      case LayoutEnums.tablet:
        return isTablet();
      case LayoutEnums.desktop:
        return isDesktop();
    }
  }

  bool isMobile() => MediaQuery.of(this).size.width < 680;

  bool isTablet() => MediaQuery.sizeOf(this).width < 980 && MediaQuery.sizeOf(this).width >= 680;

  bool isDesktop() => MediaQuery.sizeOf(this).width >= 980;
}

enum LayoutEnums {
  mobile,
  tablet,
  desktop,
}