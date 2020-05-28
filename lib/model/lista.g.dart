// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Lista extends Lista {
  @override
  final String id;
  @override
  final DateTime data;
  @override
  final int totalItens;
  @override
  final String status;
  @override
  final DocumentReference produtosRef;
  @override
  final String descricao;

  factory _$Lista([void Function(ListaBuilder) updates]) =>
      (new ListaBuilder()..update(updates)).build();

  _$Lista._(
      {this.id,
      this.data,
      this.totalItens,
      this.status,
      this.produtosRef,
      this.descricao})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Lista', 'id');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('Lista', 'data');
    }
    if (totalItens == null) {
      throw new BuiltValueNullFieldError('Lista', 'totalItens');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('Lista', 'status');
    }
    if (produtosRef == null) {
      throw new BuiltValueNullFieldError('Lista', 'produtosRef');
    }
  }

  @override
  Lista rebuild(void Function(ListaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListaBuilder toBuilder() => new ListaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Lista &&
        id == other.id &&
        data == other.data &&
        totalItens == other.totalItens &&
        status == other.status &&
        produtosRef == other.produtosRef &&
        descricao == other.descricao;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, id.hashCode), data.hashCode),
                    totalItens.hashCode),
                status.hashCode),
            produtosRef.hashCode),
        descricao.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Lista')
          ..add('id', id)
          ..add('data', data)
          ..add('totalItens', totalItens)
          ..add('status', status)
          ..add('produtosRef', produtosRef)
          ..add('descricao', descricao))
        .toString();
  }
}

class ListaBuilder implements Builder<Lista, ListaBuilder> {
  _$Lista _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  DateTime _data;
  DateTime get data => _$this._data;
  set data(DateTime data) => _$this._data = data;

  int _totalItens;
  int get totalItens => _$this._totalItens;
  set totalItens(int totalItens) => _$this._totalItens = totalItens;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  DocumentReference _produtosRef;
  DocumentReference get produtosRef => _$this._produtosRef;
  set produtosRef(DocumentReference produtosRef) =>
      _$this._produtosRef = produtosRef;

  String _descricao;
  String get descricao => _$this._descricao;
  set descricao(String descricao) => _$this._descricao = descricao;

  ListaBuilder();

  ListaBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _data = _$v.data;
      _totalItens = _$v.totalItens;
      _status = _$v.status;
      _produtosRef = _$v.produtosRef;
      _descricao = _$v.descricao;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Lista other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Lista;
  }

  @override
  void update(void Function(ListaBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Lista build() {
    final _$result = _$v ??
        new _$Lista._(
            id: id,
            data: data,
            totalItens: totalItens,
            status: status,
            produtosRef: produtosRef,
            descricao: descricao);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
