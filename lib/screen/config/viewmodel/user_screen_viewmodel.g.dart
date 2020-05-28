// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_screen_viewmodel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserScreenViewModel extends UserScreenViewModel {
  @override
  final User user;

  factory _$UserScreenViewModel(
          [void Function(UserScreenViewModelBuilder) updates]) =>
      (new UserScreenViewModelBuilder()..update(updates)).build();

  _$UserScreenViewModel._({this.user}) : super._() {
    if (user == null) {
      throw new BuiltValueNullFieldError('UserScreenViewModel', 'user');
    }
  }

  @override
  UserScreenViewModel rebuild(
          void Function(UserScreenViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserScreenViewModelBuilder toBuilder() =>
      new UserScreenViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserScreenViewModel && user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(0, user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserScreenViewModel')
          ..add('user', user))
        .toString();
  }
}

class UserScreenViewModelBuilder
    implements Builder<UserScreenViewModel, UserScreenViewModelBuilder> {
  _$UserScreenViewModel _$v;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  UserScreenViewModelBuilder();

  UserScreenViewModelBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserScreenViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserScreenViewModel;
  }

  @override
  void update(void Function(UserScreenViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserScreenViewModel build() {
    _$UserScreenViewModel _$result;
    try {
      _$result = _$v ?? new _$UserScreenViewModel._(user: user.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserScreenViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
