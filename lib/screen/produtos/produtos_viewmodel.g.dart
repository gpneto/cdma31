// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produtos_viewmodel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProdutosViewModel extends ProdutosViewModel {
  @override
  final BuiltList<Produto> produtos;
  @override
  final bool hasData;

  factory _$ProdutosViewModel(
          [void Function(ProdutosViewModelBuilder) updates]) =>
      (new ProdutosViewModelBuilder()..update(updates)).build();

  _$ProdutosViewModel._({this.produtos, this.hasData}) : super._() {
    if (produtos == null) {
      throw new BuiltValueNullFieldError('ProdutosViewModel', 'produtos');
    }
    if (hasData == null) {
      throw new BuiltValueNullFieldError('ProdutosViewModel', 'hasData');
    }
  }

  @override
  ProdutosViewModel rebuild(void Function(ProdutosViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProdutosViewModelBuilder toBuilder() =>
      new ProdutosViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProdutosViewModel &&
        produtos == other.produtos &&
        hasData == other.hasData;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, produtos.hashCode), hasData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProdutosViewModel')
          ..add('produtos', produtos)
          ..add('hasData', hasData))
        .toString();
  }
}

class ProdutosViewModelBuilder
    implements Builder<ProdutosViewModel, ProdutosViewModelBuilder> {
  _$ProdutosViewModel _$v;

  ListBuilder<Produto> _produtos;
  ListBuilder<Produto> get produtos =>
      _$this._produtos ??= new ListBuilder<Produto>();
  set produtos(ListBuilder<Produto> produtos) => _$this._produtos = produtos;

  bool _hasData;
  bool get hasData => _$this._hasData;
  set hasData(bool hasData) => _$this._hasData = hasData;

  ProdutosViewModelBuilder();

  ProdutosViewModelBuilder get _$this {
    if (_$v != null) {
      _produtos = _$v.produtos?.toBuilder();
      _hasData = _$v.hasData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProdutosViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProdutosViewModel;
  }

  @override
  void update(void Function(ProdutosViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProdutosViewModel build() {
    _$ProdutosViewModel _$result;
    try {
      _$result = _$v ??
          new _$ProdutosViewModel._(
              produtos: produtos.build(), hasData: hasData);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'produtos';
        produtos.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProdutosViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
