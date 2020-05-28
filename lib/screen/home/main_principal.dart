import 'dart:async';

import 'package:cdma31/screen/home/screen/android_home.dart';
import 'package:cdma31/screen/home/screen/app_home.dart';
import 'package:cdma31/screen/home/screen/ios_home.dart';
import 'package:cdma31/util/platform_widget_native.dart';
import 'package:cdma31/util/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../../app_config.dart';

class AppHome extends StatefulWidget {
  final StreamController<String> controllerListenIncidente;

  const AppHome({Key key, this.controllerListenIncidente}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppHomeState();

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<AppHomeState>().restartApp();
  }
}

class AppHomeState extends State<AppHome> {
  AppHomeState();

  Key key = UniqueKey();

  void restartApp() {
    if (mounted) {
      setState(() {
        key = UniqueKey();
      });
    }
  }

  var homeScreen;
  var chatScreen;
  var infoPage;

  var animateStatus = 0;

  var dialogoAberto = false;

  @override
  void initState() {
    Prefs.singleton()
        .addListenerForPref(Prefs.THEME_NATIVE_PREF, changeListener);

    print('Abrindo a Tela Principal:' + DateTime.now().toString());

    super.initState();
  }

  PrefsListener changeListener(String key, Object value) {
    if(!mounted){
      restartApp();

    }else {
      setState(() {
        switch (value) {
          case "TargetPlatformNative.android":
            defaultTargetPlatformNative = TargetPlatformNative.android;
            break;
          case "TargetPlatformNative.iOS":
            defaultTargetPlatformNative = TargetPlatformNative.iOS;
            break;
          case "TargetPlatformNative.app":
            defaultTargetPlatformNative = TargetPlatformNative.app;
            break;
        }
      });
    }
  }

  @override
  Widget build(context) {
    return PlatformWidgetNative(
      key: key,
      androidBuilder: AndroidHome.init(key, context, this).buildAndroidHomePage,
      iosBuilder: IosHome.init(key, context, this).buildIosHomePage,
      appBuilder: AppHomeTheme.init(key, context, this).buildHomePage,
    );
  }

  @override
  void dispose() {
    widget.controllerListenIncidente.close();
    super.dispose();
  }


  final globalKey = GlobalKey<ScaffoldState>();
}
