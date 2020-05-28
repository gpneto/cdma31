
import 'package:cdma31/redux/user/user_actions.dart';
import "package:redux/redux.dart";

import '../app_state.dart';


final userReducers = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, OnUserUpdateAction>(_onUserUpdate),
];

AppState _onUserUpdate(AppState state, OnUserUpdateAction action) {
  return state.rebuild((a) => a
    // Update the app user
    ..user.imageLocal = action.user.imageLocal
      ..user.image = action.user.image
);
}

