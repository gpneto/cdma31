import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_config.dart';
import 'application.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  var configuredApp = AppConfig(
    appTitle: "Minhas Tarefas",
    buildFlavor: "Prod",
    versao: 2,
    child: Application(),
  );
  runApp(configuredApp);
}