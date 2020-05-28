// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<User> _$userSerializer = new _$UserSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable<Object> serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.uid != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(object.uid,
            specifiedType: const FullType(String)));
    }
    if (object.pass != null) {
      result
        ..add('pass')
        ..add(serializers.serialize(object.pass,
            specifiedType: const FullType(String)));
    }
    if (object.passEncrypt != null) {
      result
        ..add('passEncrypt')
        ..add(serializers.serialize(object.passEncrypt,
            specifiedType: const FullType(String)));
    }
    if (object.salt != null) {
      result
        ..add('salt')
        ..add(serializers.serialize(object.salt,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.status != null) {
      result
        ..add('status')
        ..add(serializers.serialize(object.status,
            specifiedType: const FullType(String)));
    }
    if (object.image != null) {
      result
        ..add('image')
        ..add(serializers.serialize(object.image,
            specifiedType: const FullType(String)));
    }
    if (object.imageLocal != null) {
      result
        ..add('imageLocal')
        ..add(serializers.serialize(object.imageLocal,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pass':
          result.pass = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'passEncrypt':
          result.passEncrypt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'salt':
          result.salt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageLocal':
          result.imageLocal = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$User extends User {
  @override
  final String uid;
  @override
  final String pass;
  @override
  final String passEncrypt;
  @override
  final String salt;
  @override
  final String email;
  @override
  final String name;
  @override
  final String status;
  @override
  final String image;
  @override
  final String imageLocal;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.uid,
      this.pass,
      this.passEncrypt,
      this.salt,
      this.email,
      this.name,
      this.status,
      this.image,
      this.imageLocal})
      : super._();

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        uid == other.uid &&
        pass == other.pass &&
        passEncrypt == other.passEncrypt &&
        salt == other.salt &&
        email == other.email &&
        name == other.name &&
        status == other.status &&
        image == other.image &&
        imageLocal == other.imageLocal;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, uid.hashCode), pass.hashCode),
                                passEncrypt.hashCode),
                            salt.hashCode),
                        email.hashCode),
                    name.hashCode),
                status.hashCode),
            image.hashCode),
        imageLocal.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('uid', uid)
          ..add('pass', pass)
          ..add('passEncrypt', passEncrypt)
          ..add('salt', salt)
          ..add('email', email)
          ..add('name', name)
          ..add('status', status)
          ..add('image', image)
          ..add('imageLocal', imageLocal))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  String _pass;
  String get pass => _$this._pass;
  set pass(String pass) => _$this._pass = pass;

  String _passEncrypt;
  String get passEncrypt => _$this._passEncrypt;
  set passEncrypt(String passEncrypt) => _$this._passEncrypt = passEncrypt;

  String _salt;
  String get salt => _$this._salt;
  set salt(String salt) => _$this._salt = salt;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  String _imageLocal;
  String get imageLocal => _$this._imageLocal;
  set imageLocal(String imageLocal) => _$this._imageLocal = imageLocal;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _uid = _$v.uid;
      _pass = _$v.pass;
      _passEncrypt = _$v.passEncrypt;
      _salt = _$v.salt;
      _email = _$v.email;
      _name = _$v.name;
      _status = _$v.status;
      _image = _$v.image;
      _imageLocal = _$v.imageLocal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ??
        new _$User._(
            uid: uid,
            pass: pass,
            passEncrypt: passEncrypt,
            salt: salt,
            email: email,
            name: name,
            status: status,
            image: image,
            imageLocal: imageLocal);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
