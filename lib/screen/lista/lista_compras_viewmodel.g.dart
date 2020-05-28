// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista_compras_viewmodel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListaComprasViewModel extends ListaComprasViewModel {
  @override
  final BuiltList<Lista> listaCompras;
  @override
  final bool hasData;

  factory _$ListaComprasViewModel(
          [void Function(ListaComprasViewModelBuilder) updates]) =>
      (new ListaComprasViewModelBuilder()..update(updates)).build();

  _$ListaComprasViewModel._({this.listaCompras, this.hasData}) : super._() {
    if (listaCompras == null) {
      throw new BuiltValueNullFieldError(
          'ListaComprasViewModel', 'listaCompras');
    }
    if (hasData == null) {
      throw new BuiltValueNullFieldError('ListaComprasViewModel', 'hasData');
    }
  }

  @override
  ListaComprasViewModel rebuild(
          void Function(ListaComprasViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListaComprasViewModelBuilder toBuilder() =>
      new ListaComprasViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListaComprasViewModel &&
        listaCompras == other.listaCompras &&
        hasData == other.hasData;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, listaCompras.hashCode), hasData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListaComprasViewModel')
          ..add('listaCompras', listaCompras)
          ..add('hasData', hasData))
        .toString();
  }
}

class ListaComprasViewModelBuilder
    implements Builder<ListaComprasViewModel, ListaComprasViewModelBuilder> {
  _$ListaComprasViewModel _$v;

  ListBuilder<Lista> _listaCompras;
  ListBuilder<Lista> get listaCompras =>
      _$this._listaCompras ??= new ListBuilder<Lista>();
  set listaCompras(ListBuilder<Lista> listaCompras) =>
      _$this._listaCompras = listaCompras;

  bool _hasData;
  bool get hasData => _$this._hasData;
  set hasData(bool hasData) => _$this._hasData = hasData;

  ListaComprasViewModelBuilder();

  ListaComprasViewModelBuilder get _$this {
    if (_$v != null) {
      _listaCompras = _$v.listaCompras?.toBuilder();
      _hasData = _$v.hasData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListaComprasViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ListaComprasViewModel;
  }

  @override
  void update(void Function(ListaComprasViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListaComprasViewModel build() {
    _$ListaComprasViewModel _$result;
    try {
      _$result = _$v ??
          new _$ListaComprasViewModel._(
              listaCompras: listaCompras.build(), hasData: hasData);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'listaCompras';
        listaCompras.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ListaComprasViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
