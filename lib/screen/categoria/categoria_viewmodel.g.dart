// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria_viewmodel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CategoriaViewModel extends CategoriaViewModel {
  @override
  final BuiltList<Categoria> categoria;
  @override
  final bool hasData;

  factory _$CategoriaViewModel(
          [void Function(CategoriaViewModelBuilder) updates]) =>
      (new CategoriaViewModelBuilder()..update(updates)).build();

  _$CategoriaViewModel._({this.categoria, this.hasData}) : super._() {
    if (categoria == null) {
      throw new BuiltValueNullFieldError('CategoriaViewModel', 'categoria');
    }
    if (hasData == null) {
      throw new BuiltValueNullFieldError('CategoriaViewModel', 'hasData');
    }
  }

  @override
  CategoriaViewModel rebuild(
          void Function(CategoriaViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoriaViewModelBuilder toBuilder() =>
      new CategoriaViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CategoriaViewModel &&
        categoria == other.categoria &&
        hasData == other.hasData;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, categoria.hashCode), hasData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CategoriaViewModel')
          ..add('categoria', categoria)
          ..add('hasData', hasData))
        .toString();
  }
}

class CategoriaViewModelBuilder
    implements Builder<CategoriaViewModel, CategoriaViewModelBuilder> {
  _$CategoriaViewModel _$v;

  ListBuilder<Categoria> _categoria;
  ListBuilder<Categoria> get categoria =>
      _$this._categoria ??= new ListBuilder<Categoria>();
  set categoria(ListBuilder<Categoria> categoria) =>
      _$this._categoria = categoria;

  bool _hasData;
  bool get hasData => _$this._hasData;
  set hasData(bool hasData) => _$this._hasData = hasData;

  CategoriaViewModelBuilder();

  CategoriaViewModelBuilder get _$this {
    if (_$v != null) {
      _categoria = _$v.categoria?.toBuilder();
      _hasData = _$v.hasData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CategoriaViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CategoriaViewModel;
  }

  @override
  void update(void Function(CategoriaViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CategoriaViewModel build() {
    _$CategoriaViewModel _$result;
    try {
      _$result = _$v ??
          new _$CategoriaViewModel._(
              categoria: categoria.build(), hasData: hasData);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'categoria';
        categoria.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CategoriaViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
