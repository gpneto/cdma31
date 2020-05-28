import "dart:async";


import 'package:cdma31/model/user.dart';
import "package:meta/meta.dart";




@immutable
class UpdateUserAction {
  final User user;
  final Completer completer;

  const UpdateUserAction(this.user, this.completer);
}


@immutable
class OnUserUpdateAction {
  final User user;

  const OnUserUpdateAction(this.user);
}
