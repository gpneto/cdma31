
import "package:built_value/built_value.dart";
import 'package:built_value/serializer.dart';

// ignore: prefer_double_quotes
part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {

  static Serializer<User> get serializer => _$userSerializer;

  @nullable
  String get uid;

  @nullable
  String get pass;

  @nullable
  String get passEncrypt;


  @nullable
  String get salt;

  @nullable
  String get email;

  @nullable
  String get name;

  @nullable
  String get status;

  @nullable
  String get image;

  @nullable
  String get imageLocal;

  User._();

  factory User([void Function(UserBuilder) updates]) = _$User;



}

class UserHelper {
  static List<String> userIds(List<dynamic> userIds) {
    if (userIds == null) return [];
    return userIds.whereType<String>().toList();
  }
}
