import 'package:flutter/cupertino.dart';

class MenuItem{

  String nome;
  int index;
  Object menu;
  Widget body;
  Function beforeOpen;
  String id;

  MenuItem({this.nome,this.index, this.menu, this.body, this.beforeOpen, this.id});


}