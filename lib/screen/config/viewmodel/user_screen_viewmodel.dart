

import "package:built_value/built_value.dart";
import 'package:cdma31/model/user.dart';
import 'package:cdma31/redux/app_state.dart';


import "package:redux/redux.dart";


// ignore: prefer_double_quotes
part 'user_screen_viewmodel.g.dart';

abstract class UserScreenViewModel
    implements Built<UserScreenViewModel, UserScreenViewModelBuilder> {
  User get user;



  UserScreenViewModel._();

  factory UserScreenViewModel(
          [void Function(UserScreenViewModelBuilder) updates]) =
      _$UserScreenViewModel;

  static fromStore() {
    return (Store<AppState> store) {
      return UserScreenViewModel((u) => u
        ..user = store.state.user == null ? null :  store.state.user.toBuilder()
      );
    };
  }


}
