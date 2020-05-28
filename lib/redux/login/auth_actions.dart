import "dart:async";
import 'package:cdma31/model/user.dart';
import 'package:cdma31/screen/login/login_screen_viewmodel.dart';
import 'package:flutter/cupertino.dart';

import "package:meta/meta.dart";



// Authentication
class VerifyAuthenticationState {}

class LogIn {
  final String user;
  final String pass;
  final Completer completer;
  final Function onError;
  final BuildContext context;

  LogIn({this.user, this.pass, Completer completer, this.onError, this.context})
      : completer = completer ?? Completer();
}


class Sign {
  final String user;
  final String email;
  final String pass;
  final Completer completer;
  final Function onError;
  final BuildContext context;

  Sign({this.user, this.pass, this.email, Completer completer, this.onError, this.context})
      : completer = completer ?? Completer();
}



@immutable
class ActionStateLogin {
  final StateLogin stateLogin;

  const ActionStateLogin({@required this.stateLogin});

}



@immutable
class OnAuthenticated {
  final User user;

  const OnAuthenticated({@required this.user});

  @override
  String toString() {
    return "OnAuthenticated{user: $user}";
  }
}





class LogOutAction {}

class OnLogoutSuccess {
  OnLogoutSuccess();

  @override
  String toString() {
    return "LogOut{user: null}";
  }
}

class OnLogoutFail {
  final dynamic error;

  OnLogoutFail(this.error);

  @override
  String toString() {
    return "OnLogoutFail{There was an error logging in: $error}";
  }
}


class LoginLdapView {
  final User user;

  LoginLdapView(this.user);
}