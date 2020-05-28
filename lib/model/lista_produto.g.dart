// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista_produto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListaProduto extends ListaProduto {
  @override
  final String id;
  @override
  final DocumentReference ref;
  @override
  final DocumentReference produto;
  @override
  final String quantidade;
  @override
  final String inicialNome;
  @override
  final bool selecionado;
  @override
  final String status;
  @override
  final String obs;

  factory _$ListaProduto([void Function(ListaProdutoBuilder) updates]) =>
      (new ListaProdutoBuilder()..update(updates)).build();

  _$ListaProduto._(
      {this.id,
      this.ref,
      this.produto,
      this.quantidade,
      this.inicialNome,
      this.selecionado,
      this.status,
      this.obs})
      : super._();

  @override
  ListaProduto rebuild(void Function(ListaProdutoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListaProdutoBuilder toBuilder() => new ListaProdutoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListaProduto &&
        id == other.id &&
        ref == other.ref &&
        produto == other.produto &&
        quantidade == other.quantidade &&
        inicialNome == other.inicialNome &&
        selecionado == other.selecionado &&
        status == other.status &&
        obs == other.obs;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), ref.hashCode),
                            produto.hashCode),
                        quantidade.hashCode),
                    inicialNome.hashCode),
                selecionado.hashCode),
            status.hashCode),
        obs.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListaProduto')
          ..add('id', id)
          ..add('ref', ref)
          ..add('produto', produto)
          ..add('quantidade', quantidade)
          ..add('inicialNome', inicialNome)
          ..add('selecionado', selecionado)
          ..add('status', status)
          ..add('obs', obs))
        .toString();
  }
}

class ListaProdutoBuilder
    implements Builder<ListaProduto, ListaProdutoBuilder> {
  _$ListaProduto _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  DocumentReference _ref;
  DocumentReference get ref => _$this._ref;
  set ref(DocumentReference ref) => _$this._ref = ref;

  DocumentReference _produto;
  DocumentReference get produto => _$this._produto;
  set produto(DocumentReference produto) => _$this._produto = produto;

  String _quantidade;
  String get quantidade => _$this._quantidade;
  set quantidade(String quantidade) => _$this._quantidade = quantidade;

  String _inicialNome;
  String get inicialNome => _$this._inicialNome;
  set inicialNome(String inicialNome) => _$this._inicialNome = inicialNome;

  bool _selecionado;
  bool get selecionado => _$this._selecionado;
  set selecionado(bool selecionado) => _$this._selecionado = selecionado;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  String _obs;
  String get obs => _$this._obs;
  set obs(String obs) => _$this._obs = obs;

  ListaProdutoBuilder();

  ListaProdutoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _ref = _$v.ref;
      _produto = _$v.produto;
      _quantidade = _$v.quantidade;
      _inicialNome = _$v.inicialNome;
      _selecionado = _$v.selecionado;
      _status = _$v.status;
      _obs = _$v.obs;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListaProduto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ListaProduto;
  }

  @override
  void update(void Function(ListaProdutoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListaProduto build() {
    final _$result = _$v ??
        new _$ListaProduto._(
            id: id,
            ref: ref,
            produto: produto,
            quantidade: quantidade,
            inicialNome: inicialNome,
            selecionado: selecionado,
            status: status,
            obs: obs);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
