import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'builder.dart';

class Device extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final Widget screen;

  static const mobileWidth = 720;
  static const desktopWidth = 1440;

  Device({Key key, this.mobile, this.screen, this.desktop}) : super(key: key);

  static bool isNarrow(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < mobileWidth;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size, widget) {
        Widget widget;
        var width = MediaQuery.of(context).size.shortestSide;
        if (width > desktopWidth) {
          widget = screen ?? Center(child: desktop) ?? Center(child: mobile);
        } else if (width > mobileWidth) {
          widget = desktop ?? Center(child: mobile);
        } else {
          widget = mobile;
        }
        return widget;
      },
    );
  }
}
