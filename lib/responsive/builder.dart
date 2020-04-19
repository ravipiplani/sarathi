import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Size size, Size widgets) builder;

  const ResponsiveBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        return builder(context, MediaQuery.of(context).size, Size(boxConstraints.maxWidth, boxConstraints.maxHeight));
      },
    );
  }
}
