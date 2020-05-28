// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detalhes_compras_viewmodel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DetalhesComprasViewModel extends DetalhesComprasViewModel {
  @override
  final BuiltList<ListaProduto> listaProdutosonScrean;
  @override
  final bool hasData;

  factory _$DetalhesComprasViewModel(
          [void Function(DetalhesComprasViewModelBuilder) updates]) =>
      (new DetalhesComprasViewModelBuilder()..update(updates)).build();

  _$DetalhesComprasViewModel._({this.listaProdutosonScrean, this.hasData})
      : super._() {
    if (listaProdutosonScrean == null) {
      throw new BuiltValueNullFieldError(
          'DetalhesComprasViewModel', 'listaProdutosonScrean');
    }
    if (hasData == null) {
      throw new BuiltValueNullFieldError('DetalhesComprasViewModel', 'hasData');
    }
  }

  @override
  DetalhesComprasViewModel rebuild(
          void Function(DetalhesComprasViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DetalhesComprasViewModelBuilder toBuilder() =>
      new DetalhesComprasViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DetalhesComprasViewModel &&
        listaProdutosonScrean == other.listaProdutosonScrean &&
        hasData == other.hasData;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, listaProdutosonScrean.hashCode), hasData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DetalhesComprasViewModel')
          ..add('listaProdutosonScrean', listaProdutosonScrean)
          ..add('hasData', hasData))
        .toString();
  }
}

class DetalhesComprasViewModelBuilder
    implements
        Builder<DetalhesComprasViewModel, DetalhesComprasViewModelBuilder> {
  _$DetalhesComprasViewModel _$v;

  ListBuilder<ListaProduto> _listaProdutosonScrean;
  ListBuilder<ListaProduto> get listaProdutosonScrean =>
      _$this._listaProdutosonScrean ??= new ListBuilder<ListaProduto>();
  set listaProdutosonScrean(ListBuilder<ListaProduto> listaProdutosonScrean) =>
      _$this._listaProdutosonScrean = listaProdutosonScrean;

  bool _hasData;
  bool get hasData => _$this._hasData;
  set hasData(bool hasData) => _$this._hasData = hasData;

  DetalhesComprasViewModelBuilder();

  DetalhesComprasViewModelBuilder get _$this {
    if (_$v != null) {
      _listaProdutosonScrean = _$v.listaProdutosonScrean?.toBuilder();
      _hasData = _$v.hasData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DetalhesComprasViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DetalhesComprasViewModel;
  }

  @override
  void update(void Function(DetalhesComprasViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DetalhesComprasViewModel build() {
    _$DetalhesComprasViewModel _$result;
    try {
      _$result = _$v ??
          new _$DetalhesComprasViewModel._(
              listaProdutosonScrean: listaProdutosonScrean.build(),
              hasData: hasData);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'listaProdutosonScrean';
        listaProdutosonScrean.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DetalhesComprasViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
