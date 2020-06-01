


import 'package:cdma31/screen/login/login_screen_viewmodel.dart';
import "package:redux/redux.dart";

import '../../application.dart';
import '../app_state.dart';
import 'auth_actions.dart';


final authReducers = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, OnAuthenticated>(_onAuthenticated),
  TypedReducer<AppState, OnLogoutSuccess>(_onLogout),
  TypedReducer<AppState, LogIn>(_onLogIn),
  TypedReducer<AppState, Sign>(_onSigIn),
  TypedReducer<AppState, ActionStateLogin>(_onActionStateLogin),

];

AppState _onAuthenticated(AppState state, OnAuthenticated action) {
  AppState a = state.rebuild((a) => a..user = action.user.toBuilder());
  return a;
}

AppState _onLogout(AppState state, OnLogoutSuccess action) {
  return state.clear();
}


AppState _onLogIn(AppState state, LogIn action) {
  AppState a = state.rebuild((a) => a..stateLogin = StateLogin.logando);
  return a;
}



AppState _onSigIn(AppState state, Sign action) {
  AppState a = state.rebuild((a) => a..stateLogin = StateLogin.logando);
  return a;
}


AppState _onActionStateLogin(AppState state, ActionStateLogin action) {
  AppState a = state.rebuild((a) => a..stateLogin = action.stateLogin);
  return a;
}