import 'package:flutter/material.dart';

class Tick extends StatelessWidget {
  final DecorationImage image;
  Tick({this.image});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: 250.0,
      height: 150.0,
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        image: image,

      ),
    ));
  }
}
