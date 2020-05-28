

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:cdma31/model/user.dart';




part 'serializers.g.dart';

/// Collection of generated serializers for the built_value chat example.
@SerializersFor([
  User

])
final Serializers serializers =   (
    _$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
).build();

Serializers standardSerializers =
(serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();


T deserialize<T>(dynamic value) =>
    standardSerializers.deserializeWith<T>(standardSerializers.serializerForType(T), value);


BuiltList<T> deserializeListOf<T>(dynamic value) =>
    BuiltList.from(value.map((value) => deserialize<T>(value)).toList(growable: false));