import 'dart:async';
import 'dart:io' show HttpClient, Platform, SecurityContext;

import 'package:cdma31/data/lista_produtos_repository.dart';
import 'package:cdma31/data/lista_repository.dart';
import 'package:cdma31/redux/app_middleware.dart';
import 'package:cdma31/redux/app_reducer.dart';
import 'package:cdma31/redux/app_state.dart';
import 'package:cdma31/redux/login/auth_actions.dart';
import 'package:cdma31/redux/login/auth_middleware.dart';
import 'package:cdma31/redux/produtos/produtos_middleware.dart';
import 'package:cdma31/redux/push/push_middleware.dart';
import 'package:cdma31/redux/user/user_middleware.dart';
import 'package:cdma31/screen/home/main_principal.dart';
import 'package:cdma31/screen/lista/add/cria_lista.dart';
import 'package:cdma31/screen/login/login_screan.dart';
import 'package:cdma31/screen/splash/splash.dart';
import 'package:cdma31/util/image_processor.dart';
import 'package:cdma31/util/prefs.dart';
import 'package:cdma31/util/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';


import 'app_config.dart';
import 'data/file_repository.dart';

import 'data/produtos_repository.dart';
import 'data/user_repository.dart';

import 'model/lista.dart';
import 'util/app_localization.dart';




String userId;
bool log_farebase;
class Application extends StatefulWidget {
  Application({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ApplicationState createState() => _ApplicationState();
}

ThemeMode themeMode = ThemeMode.system;

class _ApplicationState extends State<Application> {
  Store<AppState> store;
  static final _navigatorKey = GlobalKey<NavigatorState>();
  final userRepo = UserRepository(FirebaseAuth.instance, Firestore.instance);
  final listaRepository = ListaRepository(Firestore.instance);
  final listaProdutosRepository = ListaProdutosRepository(Firestore.instance);
  final produtosRepository = ProdutosRepository(Firestore.instance);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  StreamController<String> controllerListenIncidente;



  @override
  void initState() {

    super.initState();


    store = Store<AppState>(appReducer,
        initialState: AppState.init(),
        middleware: createStoreMiddleware(listaRepository,listaProdutosRepository)
          ..addAll(createAuthenticationMiddleware(
            userRepo,
            _navigatorKey,
          ))
          ..addAll(createProdutosMiddleware(produtosRepository))
          ..addAll(createUserMiddleware(
              FileRepository(FirebaseStorage.instance),
              ImageProcessor(),
              userRepo))
          ..addAll(
              createPushMiddleware(userRepo, _firebaseMessaging, _navigatorKey))
          ..add(LoggingMiddleware.printer()));



    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
//        store.dispatch(OnPushNotificationReceivedAction(message));
      },
      onLaunch: (Map<String, dynamic> message) async {
//        store.dispatch(OnPushNotificationOpenAction(message));
      },
      onResume: (Map<String, dynamic> message) async {
//        store.dispatch(OnPushNotificationOpenAction(message));
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
//      Logger.d("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
//      Logger.d("Push Messaging token: $token");
      _firebaseMessaging.subscribeToTopic("minhas_tarefas_mobile_all");
      _firebaseMessaging.subscribeToTopic(
          "minhas_tarefas_mobile_Version_" + AppConfig.of(context).versao.toString());
//      store.dispatch(UpdateUserTokenAction(token));
    });

    controllerListenIncidente = StreamController<String>.broadcast();
    store.dispatch(VerifyAuthenticationState());


    Prefs.singleton().addListenerForPref(Prefs.THEME_PREF, changeLi);
  }

  PrefsListener changeLi(String key, Object value) {
    setState(() {
      switch (value) {
        case "Themes.LIGHT":
          themeMode = ThemeMode.light;
          break;
        case "Themes.DARK":
          themeMode = ThemeMode.dark;
          break;
        case "Themes.SYSTEM":
          themeMode = ThemeMode.system;
          break;
      }
    });
  }



  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Stack(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        StoreProvider(
          store: store,
          child: MaterialApp(
              title: "Minhas Tarefas",
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                // Use the green theme for Material widgets.
                primarySwatch: Colors.green,
//                primaryColor: Colors.green,


                iconTheme: IconThemeData(color: Colors.white),
                textTheme: TextTheme(
//                  headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.red),
                  title: TextStyle(color: Colors.white),
                  subtitle: TextStyle(color: Colors.white),
                  body1: TextStyle(color: Colors.black87),
                ),
              ),
              darkTheme: ThemeData(
                // Use the green theme for Material widgets.
                primarySwatch: Colors.green,
//                primaryColor: Colors.green,
                brightness: Brightness.dark,
                accentColor: Colors.green,
                iconTheme: IconThemeData(color: Colors.black),
                // Define the default TextTheme. Use this to specify the default
                // text styling for headlines, titles, bodies of text, and more.
                textTheme: TextTheme(
//                  headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.red),
                  title: TextStyle(color: Colors.black87),
                  body1: TextStyle(color: Colors.black87),
                  subtitle: TextStyle(color: Colors.black87),
                ),
              ),
              localizationsDelegates: localizationsDelegates,
              supportedLocales: [
                const Locale("en", "EN"),
                const Locale("pt_BR", "PT"),
              ],
              navigatorKey: _navigatorKey,
              onGenerateRoute: (settings) {
                // If you push the PassArguments route
                if (settings.name ==  Routes.criarLista) {
                  // Cast the arguments to the correct type: ScreenArguments.
                  final Map args = settings.arguments;

                  // Then, extract the required data from the arguments and
                  // pass the data to the correct screen.
                  return MaterialPageRoute(
                    builder: (context) {
                      if(args == null){
                        return CriarLista(null, null);
                      }
                      return CriarLista(args["lista"], args["produtos"]);
                    },
                  );
                }
              },
              routes: {
                Routes.splash: (context) {
                  return SplashPage();
                },


                Routes.home: (context) {
                  return CupertinoTheme(
                    // Instead of letting Cupertino widgets auto-adapt to the Material
                    // theme (which is green), this app will use a different theme
                    // for Cupertino (which is blue by default).
                    data: themeMode == ThemeMode.dark
                        ? CupertinoThemeData(brightness: Brightness.dark)
                        : themeMode == ThemeMode.light
                            ? CupertinoThemeData(brightness: Brightness.light)
                            : CupertinoThemeData(),
                    child: Material(
                      child: AppHome(
                          controllerListenIncidente: controllerListenIncidente),
                    ),
                  );
                },
                Routes.login: (context) {
                  return LoginPage();
                },

              }),
        ),
      ],
    );
  }


}
