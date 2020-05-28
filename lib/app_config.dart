import 'package:flutter/material.dart';
import 'package:meta/meta.dart';



int versaoApp;
String SERVER_SHA1;
String SERVER;
TargetPlatformNative defaultTargetPlatformNative ;

class AppConfig extends InheritedWidget{
  final String appTitle;
  final String buildFlavor;
  final Widget child;
  final String urlLogin;
  final String serverSHA1;
  final int versao;
  final String server;

  AppConfig({
    @required this.child,
    @required this.appTitle,
    @required this.buildFlavor,
    @required this.urlLogin,
    @required this.versao,
    @required this.serverSHA1,
    @required this.server}) {
    versaoApp = this.versao;
    SERVER_SHA1 = this.serverSHA1;
    SERVER = this.server;
  }

  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}


enum TargetPlatformNative {
  /// Android: <https://www.android.com/>
  android,

  /// Fuchsia: <https://fuchsia.googlesource.com/>
  fuchsia,

  /// iOS: <http://www.apple.com/ios/>
  iOS,

  /// iOS: <http://www.apple.com/ios/>
  app,
}