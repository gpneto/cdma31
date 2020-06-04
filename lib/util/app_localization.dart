import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";

import "cupertinoLocalizationDelegate.dart";

final localizationsDelegates = <LocalizationsDelegate>[
  const AppLocalizationsDelegate(),
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  const FallbackCupertinoLocalisationsDelegate()
];

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    "en": {
      "user": "User",
      "pass": "Password",
      "log_out": "Log out",
      "log_in": "Log in",
      "sig_in": "Sig in",
      "hello_name": "Hello, {name}!",
      "shopping_list_count": "There are {total} Shopping Lists",
      "shopping_list_count_1": "There are 1 shopping lists",
      "no_shopping_list": "No Shopping List",
      "no_have_shopping_list": "You have no shopping list!",
      "searching_shopping_list": "Searching Shopping List...",
      "confirm": "Confirm",
      "confirm_delete": "Are you sure you want to delete this item?",
      "yes": "Yes",
      "no": "No",
      "description": "Description",
      "quantity_of_products": "Quantity of Products",
      "shopping": "Shopping",
      "products": "Products",
      "settings": "Settings",
      "search": "Search...",
      "search_products": "Searching Products...",
      "no_products": "No products!",
      "removed_product": "Removed Product",
      "name_of_product": "Nome of Product",
      "enter_name": "Enter name",
      "enter": "Enter",
      "save": "Save",
      "quantity": "Quantity",
      "unit_of_measurement": "Unit of measurement",
      "note": "Note",
      "contact": "Contact",
      "theme": "Theme",
      "brightness": "Brightness",
      "default": "Default",
      "attention": "Attention",
      "active": "Active",
      "login_fail": "Login falhou. Código: '{code}'",
      "one_menu": "At least 1 menu must be active",
      "order": "Order",
      "menus": "Menus",
      "android_native": "Android Native",
      "ios_native": "iOS Native",
      "version": "Version",
      "delete": "Delete",
      "camera": "Camera",
      "gallery": "Gallery",
      "new_list": "New List",
      "add": "Add",
      "select_product": "Select Product",
      "category": "Category",
      "categories": "Categories",
      "search_categories": "Searching Categories...",
      "no_categories": "No Categories!",
      "removed_category": "Removed Category",
      "name_of_category": "Nome of Category",
      "new_product": "New Product",
      "to_edit": "To Edit"


    },
    "pt": {
      "user": "Usuário",
      "pass": "Senha",
      "log_out": "Sair",
      "log_in": "Acessar",
      "sig_in": "Criar conta",
      "hello_name": "Olá, {name}!",
      "shopping_list_count": "Existem {total} Listas de Compras",
      "shopping_list_count_1": "Existe 1 Lista de Compras",
      "no_shopping_list": "Não existem Lista de Compras",
      "searching_shopping_list": "Buscando Lista de Compras...",
      "no_have_shopping_list": "Você não tem Lista de Compras!",
      "confirm": "Confirmar",
      "confirm_delete": "Você tem certeza que deseja excluir esse item?",
      "yes": "Sim",
      "no": "Não",
      "shopping": "Compras",
      "products": "Produtos",
      "settings": "Configurações",
      "quantity_of_products": "Quantidade de Produtos",
      "search": "Procurar...",
      "search_products": "Buscando Pordutos...",
      "description": "Descrição",
      "no_products": "Sem produtos!",
      "removed_product": "Produto Removido",
      "name_of_product": "Nome do Produto",
      "unit_of_measurement": "Unidade de Medida",
      "enter_name": "Digite o Nome",
      "enter": "Digete",
      "save": "Salvar",
      "quantity": "Quantidade",
      "note": "Observação",
      "contact": "Contato",
      "theme": "Tema",
      "brightness": "Brilho",
      "default": "Padrão",
      "attention": "Atenção",
      "active": "Ativo",
      "one_menu": "Pelo menos 1 menu deve estar ativo",
      "login_fail": "Login falhou. Código: '{code}'",
      "order": "Ordem",
      "menus": "Menus",
      "android_native": "Android Nativo",
      "ios_native": "iOS Nativo",
      "version": "Versão",
      "delete": "Excluir",
      "camera": "Câmera",
      "gallery": "Galeria",
      "new_list": "Nova Lista",
      "add": "Adicionar",
      "select_product": "Selecione o Produto",
      "category": "Categoria",
      "categories": "Categorias",
      "search_categories": "Buscando Categorias...",
      "no_categories": "Sem Categorias!",
      "removed_category": "Categoria Removido",
      "name_of_category": "Nome do Categoria",
      "new_product": "Novo Produto",
      "to_edit": "Editar"
    }
  };

  /// This method returns the localized value of the passed id
  /// it defaults to english if the locale is missing
  String _localizedValue(String id) =>
      _localizedValues[locale.languageCode][id] ?? _localizedValues["en"][id];

  // Auth
  String get user {
    return _localizedValue("user");
  }

  String get pass {
    return _localizedValue("pass");
  }

  String get logIn {
    return _localizedValue("log_in");
  }

  String get logOut {
    return _localizedValue("log_out");
  }

  String get sigIn {
    return _localizedValue("sig_in");
  }

  String hello(String name) {
    return _localizedValue("hello_name").replaceAll("{name}", name);
  }

  String authErrorMessage(String code) {
    switch (code) {
      case "ERROR_USER_NOT_FOUND":
        return _localizedValue("login_fail_user_not_found");
      default:
        return _localizedValue("login_fail").replaceAll("{code}", code);
    }
  }

  String shoppingListCount(int total) {
    return total > 1
        ? _localizedValue("shopping_list_count")
            .replaceAll("{total}", total.toString())
        : total == 1
            ? _localizedValue("shopping_list_count_1")
            : _localizedValue("no_shopping_list");
  }

  String get searchingShoppingList {
    return _localizedValue("searching_shopping_list");
  }

  String get noHaveShoppingList {
    return _localizedValue("no_have_shopping_list");
  }

  String get confirm {
    return _localizedValue("confirm");
  }

  String get confirDelete {
    return _localizedValue("confirm_delete");
  }

  String get yes {
    return _localizedValue("yes");
  }

  String get no {
    return _localizedValue("no");
  }

  String get description {
    return _localizedValue("description");
  }

  String get quantityOfProducts {
    return _localizedValue("quantity_of_products");
  }

  String get shopping {
    return _localizedValue("shopping");
  }

  String get products {
    return _localizedValue("products");
  }

  String get settings {
    return _localizedValue("settings");
  }

  String get search {
    return _localizedValue("search");
  }

  String get searchProducts {
    return _localizedValue("search_products");
  }

  String get noProducts {
    return _localizedValue("no_products");
  }

  String get removedProduct {
    return _localizedValue("removed_product");
  }

  String get nameOfProduct {
    return _localizedValue("name_of_product");
  }

  String get enterName {
    return _localizedValue("enter_name");
  }

  String get unitOfMeasurement {
    return _localizedValue("unit_of_measurement");
  }

  String get enter {
    return _localizedValue("enter");
  }

  String get save {
    return _localizedValue("save");
  }

  String get quantity {
    return _localizedValue("quantity");
  }

  String get note {
    return _localizedValue("note");
  }

  String get contact {
    return _localizedValue("contact");
  }

  String get theme {
    return _localizedValue("theme");
  }

  String get brightness {
    return _localizedValue("brightness");
  }

  String get defaultStr {
    return _localizedValue("default");
  }

  String get attention {
    return _localizedValue("attention");
  }

  String get oneMenu {
    return _localizedValue("one_menu");
  }

  String get active {
    return _localizedValue("active");
  }

  String get order {
    return _localizedValue("order");
  }

  String get menus {
    return _localizedValue("menus");
  }

  String get iosNative {
    return _localizedValue("ios_native");
  }

  String get androidNative {
    return _localizedValue("android_native");
  }

  String get version {
    return _localizedValue("version");
  }

  String get delete {
    return _localizedValue("delete");
  }

  String get camera {
    return _localizedValue("camera");
  }

  String get gallery {
    return _localizedValue("gallery");
  }

  String get newList {
    return _localizedValue("new_list");
  }

  String get add {
    return _localizedValue("add");
  }

  String get selectProduct {
    return _localizedValue("select_product");
  }

  String get category {
    return _localizedValue("category");
  }

  String get categories {
    return _localizedValue("categories");
  }

  String get searchCategories {
    return _localizedValue("search_categories");
  }


  String get noCategories {
    return _localizedValue("no_categories");
  }


  String get removedCategory {
    return _localizedValue("removed_category");
  }


  String get nameOfCategory {
    return _localizedValue("name_of_category");
  }


  String get newProduct {
    return _localizedValue("new_product");
  }

  String get toEdit {
    return _localizedValue("to_edit");
  }






  String platformAlertAccessBody(AccessResourceType type) {
    final typeString = type == AccessResourceType.CAMERA
        ? platformAlertAccessResourceCamera
        : platformAlertAccessResourcePhotos;
    return _localizedValue("platform_alert_access_body")
        .replaceAll("{RESOURCE}", typeString);
  }

  String get platformAlertAccessResourceCamera =>
      _localizedValue("platform_alert_access_resource_camera");

  String get platformAlertAccessResourcePhotos =>
      _localizedValue("platform_alert_access_resource_photos");
}

enum AccessResourceType { CAMERA, STORAGE }

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ["en", "pt"].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
