// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Produto extends Produto {
  @override
  final String id;
  @override
  final String path;
  @override
  final String status;
  @override
  final String nome;
  @override
  final String unidadeMedida;
  @override
  final DocumentReference ref;
  @override
  final DocumentReference categoria;

  factory _$Produto([void Function(ProdutoBuilder) updates]) =>
      (new ProdutoBuilder()..update(updates)).build();

  _$Produto._(
      {this.id,
      this.path,
      this.status,
      this.nome,
      this.unidadeMedida,
      this.ref,
      this.categoria})
      : super._();

  @override
  Produto rebuild(void Function(ProdutoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProdutoBuilder toBuilder() => new ProdutoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Produto &&
        id == other.id &&
        path == other.path &&
        status == other.status &&
        nome == other.nome &&
        unidadeMedida == other.unidadeMedida &&
        ref == other.ref &&
        categoria == other.categoria;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), path.hashCode),
                        status.hashCode),
                    nome.hashCode),
                unidadeMedida.hashCode),
            ref.hashCode),
        categoria.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Produto')
          ..add('id', id)
          ..add('path', path)
          ..add('status', status)
          ..add('nome', nome)
          ..add('unidadeMedida', unidadeMedida)
          ..add('ref', ref)
          ..add('categoria', categoria))
        .toString();
  }
}

class ProdutoBuilder implements Builder<Produto, ProdutoBuilder> {
  _$Produto _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _path;
  String get path => _$this._path;
  set path(String path) => _$this._path = path;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  String _nome;
  String get nome => _$this._nome;
  set nome(String nome) => _$this._nome = nome;

  String _unidadeMedida;
  String get unidadeMedida => _$this._unidadeMedida;
  set unidadeMedida(String unidadeMedida) =>
      _$this._unidadeMedida = unidadeMedida;

  DocumentReference _ref;
  DocumentReference get ref => _$this._ref;
  set ref(DocumentReference ref) => _$this._ref = ref;

  DocumentReference _categoria;
  DocumentReference get categoria => _$this._categoria;
  set categoria(DocumentReference categoria) => _$this._categoria = categoria;

  ProdutoBuilder();

  ProdutoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _path = _$v.path;
      _status = _$v.status;
      _nome = _$v.nome;
      _unidadeMedida = _$v.unidadeMedida;
      _ref = _$v.ref;
      _categoria = _$v.categoria;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Produto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Produto;
  }

  @override
  void update(void Function(ProdutoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Produto build() {
    final _$result = _$v ??
        new _$Produto._(
            id: id,
            path: path,
            status: status,
            nome: nome,
            unidadeMedida: unidadeMedida,
            ref: ref,
            categoria: categoria);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
