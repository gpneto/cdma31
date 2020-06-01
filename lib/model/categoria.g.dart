// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Categoria extends Categoria {
  @override
  final String id;
  @override
  final String status;
  @override
  final String nome;
  @override
  final String descricao;
  @override
  final DocumentReference ref;

  factory _$Categoria([void Function(CategoriaBuilder) updates]) =>
      (new CategoriaBuilder()..update(updates)).build();

  _$Categoria._({this.id, this.status, this.nome, this.descricao, this.ref})
      : super._();

  @override
  Categoria rebuild(void Function(CategoriaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoriaBuilder toBuilder() => new CategoriaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Categoria &&
        id == other.id &&
        status == other.status &&
        nome == other.nome &&
        descricao == other.descricao &&
        ref == other.ref;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), status.hashCode), nome.hashCode),
            descricao.hashCode),
        ref.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Categoria')
          ..add('id', id)
          ..add('status', status)
          ..add('nome', nome)
          ..add('descricao', descricao)
          ..add('ref', ref))
        .toString();
  }
}

class CategoriaBuilder implements Builder<Categoria, CategoriaBuilder> {
  _$Categoria _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  String _nome;
  String get nome => _$this._nome;
  set nome(String nome) => _$this._nome = nome;

  String _descricao;
  String get descricao => _$this._descricao;
  set descricao(String descricao) => _$this._descricao = descricao;

  DocumentReference _ref;
  DocumentReference get ref => _$this._ref;
  set ref(DocumentReference ref) => _$this._ref = ref;

  CategoriaBuilder();

  CategoriaBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _status = _$v.status;
      _nome = _$v.nome;
      _descricao = _$v.descricao;
      _ref = _$v.ref;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Categoria other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Categoria;
  }

  @override
  void update(void Function(CategoriaBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Categoria build() {
    final _$result = _$v ??
        new _$Categoria._(
            id: id, status: status, nome: nome, descricao: descricao, ref: ref);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
