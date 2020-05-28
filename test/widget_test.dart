// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'dart:async';

import 'package:cdma31/data/user_repository.dart';
import 'package:cdma31/model/user.dart';
import 'package:cdma31/redux/app_actions.dart';
import 'package:cdma31/redux/app_reducer.dart';
import 'package:cdma31/redux/app_state.dart';
import 'package:cdma31/redux/login/auth_actions.dart';
import 'package:cdma31/redux/login/auth_middleware.dart';

import "package:flutter/foundation.dart";
import "package:redux/redux.dart";
import "package:mockito/mockito.dart";
import "package:test/test.dart";
import "package:flutter/widgets.dart" as w;

class MockUserRepository extends Mock implements UserRepository {}

class MockMiddleware extends Mock implements MiddlewareClass<AppState> {}


// ignore: must_be_immutable
class MockGlobalKey extends Mock implements w.GlobalKey<w.NavigatorState> {}

class MockNavigatorState extends Mock implements w.NavigatorState {
  @override
  // ignore: invalid_override_different_default_values_named
  String toString({DiagnosticLevel minLevel}) => "";
}


main() {
//  TestWidgetsFlutterBinding.ensureInitialized();

  group("Authentication Middleware", () {
    MockMiddleware _captor;
    MockUserRepository _userRepository;
    Store<AppState> _store;
    MockGlobalKey _globalKey;
    MockNavigatorState _navigatorState;
    final _user = User((u) => u
      ..uid = "UID"
      ..email = "EMAIL"
      ..name = "NAME");



    setUp(() {
      _captor = MockMiddleware();
      _userRepository = MockUserRepository();
      _globalKey = MockGlobalKey();
      _navigatorState = MockNavigatorState();
      _store = Store<AppState>(appReducer,
          initialState: AppState.init(),
          middleware:
          createAuthenticationMiddleware(_userRepository,_globalKey)
            ..add(_captor));
    });

//    print(_globalKey.currentState);

    test("should perform logOut", () {
      _store.dispatch(LogOutAction());
      verify(_userRepository.logOut());

      verify(_captor.call(
        any,
        TypeMatcher<LogOutAction>(),
        any,
      ) as dynamic);
    });

    test("should fail logOut", () {
      when(_userRepository.logOut()).thenThrow(Exception());
      _store.dispatch(LogOutAction());
      verify(_userRepository.logOut());

      verify(_captor.call(
        any,
        TypeMatcher<OnLogoutFail>(),
        any,
      ) as dynamic);
    });

//    test("should sign user in on LogIn", () {
//      when(_userRepository.signIn("secret@teste.xyz", "secret"))
//          .thenAnswer((_) => SynchronousFuture(_user));
//      when(_globalKey.currentState).thenReturn(_navigatorState);
//
//      _store.dispatch(
//          LogIn(user: "secret@teste.xyz", pass: "secret"));
//      verify(_userRepository.signIn("secret@teste.xyz", "secret"));
//
//      verify(_captor.call(
//        any,
//        TypeMatcher<OnAuthenticated>(),
//        any,
//      ) as dynamic);
//    });
  });
}