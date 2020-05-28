// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppState extends AppState {
  @override
  final User user;
  @override
  final String fcmToken;
  @override
  final StateLogin stateLogin;
  @override
  final BuiltList<Lista> listaCompras;
  @override
  final bool buscandoLista;
  @override
  final BuiltList<ListaProduto> listaProdutosonScrean;
  @override
  final bool buscandoListaProdutosonScrean;
  @override
  final BuiltList<Produto> produtosonScrean;
  @override
  final bool buscandoProdutosonScrean;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.user,
      this.fcmToken,
      this.stateLogin,
      this.listaCompras,
      this.buscandoLista,
      this.listaProdutosonScrean,
      this.buscandoListaProdutosonScrean,
      this.produtosonScrean,
      this.buscandoProdutosonScrean})
      : super._() {
    if (listaCompras == null) {
      throw new BuiltValueNullFieldError('AppState', 'listaCompras');
    }
    if (buscandoLista == null) {
      throw new BuiltValueNullFieldError('AppState', 'buscandoLista');
    }
    if (buscandoListaProdutosonScrean == null) {
      throw new BuiltValueNullFieldError(
          'AppState', 'buscandoListaProdutosonScrean');
    }
    if (buscandoProdutosonScrean == null) {
      throw new BuiltValueNullFieldError(
          'AppState', 'buscandoProdutosonScrean');
    }
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        user == other.user &&
        fcmToken == other.fcmToken &&
        stateLogin == other.stateLogin &&
        listaCompras == other.listaCompras &&
        buscandoLista == other.buscandoLista &&
        listaProdutosonScrean == other.listaProdutosonScrean &&
        buscandoListaProdutosonScrean == other.buscandoListaProdutosonScrean &&
        produtosonScrean == other.produtosonScrean &&
        buscandoProdutosonScrean == other.buscandoProdutosonScrean;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, user.hashCode), fcmToken.hashCode),
                                stateLogin.hashCode),
                            listaCompras.hashCode),
                        buscandoLista.hashCode),
                    listaProdutosonScrean.hashCode),
                buscandoListaProdutosonScrean.hashCode),
            produtosonScrean.hashCode),
        buscandoProdutosonScrean.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('user', user)
          ..add('fcmToken', fcmToken)
          ..add('stateLogin', stateLogin)
          ..add('listaCompras', listaCompras)
          ..add('buscandoLista', buscandoLista)
          ..add('listaProdutosonScrean', listaProdutosonScrean)
          ..add('buscandoListaProdutosonScrean', buscandoListaProdutosonScrean)
          ..add('produtosonScrean', produtosonScrean)
          ..add('buscandoProdutosonScrean', buscandoProdutosonScrean))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  String _fcmToken;
  String get fcmToken => _$this._fcmToken;
  set fcmToken(String fcmToken) => _$this._fcmToken = fcmToken;

  StateLogin _stateLogin;
  StateLogin get stateLogin => _$this._stateLogin;
  set stateLogin(StateLogin stateLogin) => _$this._stateLogin = stateLogin;

  ListBuilder<Lista> _listaCompras;
  ListBuilder<Lista> get listaCompras =>
      _$this._listaCompras ??= new ListBuilder<Lista>();
  set listaCompras(ListBuilder<Lista> listaCompras) =>
      _$this._listaCompras = listaCompras;

  bool _buscandoLista;
  bool get buscandoLista => _$this._buscandoLista;
  set buscandoLista(bool buscandoLista) =>
      _$this._buscandoLista = buscandoLista;

  ListBuilder<ListaProduto> _listaProdutosonScrean;
  ListBuilder<ListaProduto> get listaProdutosonScrean =>
      _$this._listaProdutosonScrean ??= new ListBuilder<ListaProduto>();
  set listaProdutosonScrean(ListBuilder<ListaProduto> listaProdutosonScrean) =>
      _$this._listaProdutosonScrean = listaProdutosonScrean;

  bool _buscandoListaProdutosonScrean;
  bool get buscandoListaProdutosonScrean =>
      _$this._buscandoListaProdutosonScrean;
  set buscandoListaProdutosonScrean(bool buscandoListaProdutosonScrean) =>
      _$this._buscandoListaProdutosonScrean = buscandoListaProdutosonScrean;

  ListBuilder<Produto> _produtosonScrean;
  ListBuilder<Produto> get produtosonScrean =>
      _$this._produtosonScrean ??= new ListBuilder<Produto>();
  set produtosonScrean(ListBuilder<Produto> produtosonScrean) =>
      _$this._produtosonScrean = produtosonScrean;

  bool _buscandoProdutosonScrean;
  bool get buscandoProdutosonScrean => _$this._buscandoProdutosonScrean;
  set buscandoProdutosonScrean(bool buscandoProdutosonScrean) =>
      _$this._buscandoProdutosonScrean = buscandoProdutosonScrean;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user?.toBuilder();
      _fcmToken = _$v.fcmToken;
      _stateLogin = _$v.stateLogin;
      _listaCompras = _$v.listaCompras?.toBuilder();
      _buscandoLista = _$v.buscandoLista;
      _listaProdutosonScrean = _$v.listaProdutosonScrean?.toBuilder();
      _buscandoListaProdutosonScrean = _$v.buscandoListaProdutosonScrean;
      _produtosonScrean = _$v.produtosonScrean?.toBuilder();
      _buscandoProdutosonScrean = _$v.buscandoProdutosonScrean;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              user: _user?.build(),
              fcmToken: fcmToken,
              stateLogin: stateLogin,
              listaCompras: listaCompras.build(),
              buscandoLista: buscandoLista,
              listaProdutosonScrean: _listaProdutosonScrean?.build(),
              buscandoListaProdutosonScrean: buscandoListaProdutosonScrean,
              produtosonScrean: _produtosonScrean?.build(),
              buscandoProdutosonScrean: buscandoProdutosonScrean);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();

        _$failedField = 'listaCompras';
        listaCompras.build();

        _$failedField = 'listaProdutosonScrean';
        _listaProdutosonScrean?.build();

        _$failedField = 'produtosonScrean';
        _produtosonScrean?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
