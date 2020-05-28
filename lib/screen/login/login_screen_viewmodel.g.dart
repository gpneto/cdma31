// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_screen_viewmodel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginScreenViewModel extends LoginScreenViewModel {
  @override
  final StateLogin stateLogin;

  factory _$LoginScreenViewModel(
          [void Function(LoginScreenViewModelBuilder) updates]) =>
      (new LoginScreenViewModelBuilder()..update(updates)).build();

  _$LoginScreenViewModel._({this.stateLogin}) : super._();

  @override
  LoginScreenViewModel rebuild(
          void Function(LoginScreenViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginScreenViewModelBuilder toBuilder() =>
      new LoginScreenViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginScreenViewModel && stateLogin == other.stateLogin;
  }

  @override
  int get hashCode {
    return $jf($jc(0, stateLogin.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginScreenViewModel')
          ..add('stateLogin', stateLogin))
        .toString();
  }
}

class LoginScreenViewModelBuilder
    implements Builder<LoginScreenViewModel, LoginScreenViewModelBuilder> {
  _$LoginScreenViewModel _$v;

  StateLogin _stateLogin;
  StateLogin get stateLogin => _$this._stateLogin;
  set stateLogin(StateLogin stateLogin) => _$this._stateLogin = stateLogin;

  LoginScreenViewModelBuilder();

  LoginScreenViewModelBuilder get _$this {
    if (_$v != null) {
      _stateLogin = _$v.stateLogin;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginScreenViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LoginScreenViewModel;
  }

  @override
  void update(void Function(LoginScreenViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginScreenViewModel build() {
    final _$result =
        _$v ?? new _$LoginScreenViewModel._(stateLogin: stateLogin);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
