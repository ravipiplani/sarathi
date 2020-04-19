import 'package:flutter/material.dart';

import 'builder.dart';

class Layout extends StatelessWidget {
  final Widget landscape;
  final Widget portrait;

  const Layout({Key key, this.landscape, this.portrait}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screen, widget) {
        Widget widget;
        switch (MediaQuery.of(context).orientation) {
          case Orientation.portrait:
            widget = portrait;
            break;
          case Orientation.landscape:
            widget = landscape ?? Center(child: portrait);
            break;
        }
        return widget;
      },
    );
  }
}
