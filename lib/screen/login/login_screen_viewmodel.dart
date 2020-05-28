
import "package:built_value/built_value.dart";
import 'package:cdma31/redux/app_state.dart';
import "package:redux/redux.dart";


// ignore: prefer_double_quotes
part 'login_screen_viewmodel.g.dart';

abstract class LoginScreenViewModel
    implements Built<LoginScreenViewModel, LoginScreenViewModelBuilder> {



  @nullable
  StateLogin get stateLogin;


  LoginScreenViewModel._();

  factory LoginScreenViewModel(
      [void Function(LoginScreenViewModelBuilder) updates]) =
  _$LoginScreenViewModel;


  static LoginScreenViewModel fromStore(Store<AppState> store) {

      return LoginScreenViewModel((vm) => vm
        ..stateLogin = store.state.stateLogin);


  }
}


enum StateLogin { init, logando,logado }