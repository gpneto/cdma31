import 'package:cdma31/screen/splash/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../application.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenLogo(),
    );
  }
}

Widget screenLogo() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Align(
        alignment: Alignment.center,
        child: Hero(
          tag: "heroVerde",
          child: Container(
            width: 1000,
            height: 1000,
            alignment: FractionalOffset.center,
            decoration: new BoxDecoration(
              color: const Color.fromRGBO(63, 185, 59, 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  image: logoBranco,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
