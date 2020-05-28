import 'package:cdma31/util/prefs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'menu_item.dart';

class HomeAbstract{
  final Key key;
  final BuildContext context;
  final State stateHome;

  bool primeiroAcessoLiberacoes = true;
  bool primeiroAcessoDatasCriticas = true;
  bool primeiroAcessoGetIncidentes = true;
  String incidente;

  List<MenuItem> menus = [];

  HomeAbstract(this.key, this.context, this.stateHome);

  PrefsListener changeListenerMenu(String key, Object value) {

  }
}