
import "package:redux/redux.dart";

import '../app_actions.dart';
import '../app_state.dart';




final pushReducers = <AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, UpdateUserTokenAction>(_updateUserAction),
];

AppState _updateUserAction(AppState state, UpdateUserTokenAction action) {
  return state.rebuild((s) => s..fcmToken = action.token);
}
