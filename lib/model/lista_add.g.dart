// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista_add.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListaAdd extends ListaAdd {
  @override
  final DocumentReference ref;
  @override
  final String descricao;
  @override
  final BuiltList<ListaProduto> produtosSelecionados;

  factory _$ListaAdd([void Function(ListaAddBuilder) updates]) =>
      (new ListaAddBuilder()..update(updates)).build();

  _$ListaAdd._({this.ref, this.descricao, this.produtosSelecionados})
      : super._() {
    if (descricao == null) {
      throw new BuiltValueNullFieldError('ListaAdd', 'descricao');
    }
  }

  @override
  ListaAdd rebuild(void Function(ListaAddBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListaAddBuilder toBuilder() => new ListaAddBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListaAdd &&
        ref == other.ref &&
        descricao == other.descricao &&
        produtosSelecionados == other.produtosSelecionados;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, ref.hashCode), descricao.hashCode),
        produtosSelecionados.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListaAdd')
          ..add('ref', ref)
          ..add('descricao', descricao)
          ..add('produtosSelecionados', produtosSelecionados))
        .toString();
  }
}

class ListaAddBuilder implements Builder<ListaAdd, ListaAddBuilder> {
  _$ListaAdd _$v;

  DocumentReference _ref;
  DocumentReference get ref => _$this._ref;
  set ref(DocumentReference ref) => _$this._ref = ref;

  String _descricao;
  String get descricao => _$this._descricao;
  set descricao(String descricao) => _$this._descricao = descricao;

  ListBuilder<ListaProduto> _produtosSelecionados;
  ListBuilder<ListaProduto> get produtosSelecionados =>
      _$this._produtosSelecionados ??= new ListBuilder<ListaProduto>();
  set produtosSelecionados(ListBuilder<ListaProduto> produtosSelecionados) =>
      _$this._produtosSelecionados = produtosSelecionados;

  ListaAddBuilder();

  ListaAddBuilder get _$this {
    if (_$v != null) {
      _ref = _$v.ref;
      _descricao = _$v.descricao;
      _produtosSelecionados = _$v.produtosSelecionados?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListaAdd other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ListaAdd;
  }

  @override
  void update(void Function(ListaAddBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListaAdd build() {
    _$ListaAdd _$result;
    try {
      _$result = _$v ??
          new _$ListaAdd._(
              ref: ref,
              descricao: descricao,
              produtosSelecionados: _produtosSelecionados?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'produtosSelecionados';
        _produtosSelecionados?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ListaAdd', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
