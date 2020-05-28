import 'package:cdma31/redux/app_state.dart';
import 'package:cdma31/screen/config/styles.dart';
import 'package:cdma31/screen/home/main_principal.dart';
import 'package:cdma31/util/app_localization.dart';
import 'package:cdma31/util/platform_widget_native.dart';
import 'package:cdma31/util/prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



import '../../app_config.dart';
import '../base_stateless_screen.dart';
import 'home_top_view.dart';
import 'info_list_section.dart';
import 'menus_sistema.dart';



class ConfigPage extends BaseStatelessScreen {


  final State pai;

  @override
  String get title => AppLocalizations.of(pai.context).settings;

  @override
  IconData get androidIcon => FontAwesomeIcons.userCog;

  @override
  IconData get iosIcon => FontAwesomeIcons.userCog;

  ConfigPage({Key key, this.pai}) ;

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<ConfigPage> {

  @override
  bool get wantKeepAlive => true;

  final TextEditingController _nameDialogTextController =
      new TextEditingController();
  Animation<double> containerGrowAnimation;
  AnimationController _screenController;

  @override
  void initState() {
    super.initState();
    _screenController = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);

    containerGrowAnimation = new CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeIn,
    );

    containerGrowAnimation.addListener(() {
      this.setState(() {});
    });
    containerGrowAnimation.addStatusListener((AnimationStatus status) {});

    _screenController.forward();
  }

  @override
  void dispose() {
    _nameDialogTextController.dispose();

    super.dispose();
  }

  String nome = "Olá";

  void isUserRegistered(BuildContext context) async {
    nome = StoreProvider.of<AppState>(context).state.user.name.split(' ')[0];
  }

  Widget _buildAndroid(BuildContext context) {
    return Stack(
      children: [
        buildWidget(),
        SafeArea(
          top: true,

          child: Padding(
            padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).iconTheme.color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 3.0,
                      // has the effect of softening the shadow
                      spreadRadius: 2.0,
                      // has the effect of extending the shadow
                      offset: Offset(
                        .0, // horizontal, move right 10
                        5.0, // vertical, move down 10
                      ),
                    )
                  ]),

              child: Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 2),
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  heroTag: 'actionMenu',
                  onPressed: () =>
                      Scaffold.of(context).openDrawer(),
//                                    backgroundColor: Colors.transparent,
                  mini: true,
                  child: Icon(Icons.menu),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildIos(BuildContext context) {
    return buildWidget();
  }

  Widget buildWidget() {
    isUserRegistered(context);


    var temaIos = CupertinoSwitch(
      value: defaultTargetPlatformNative == TargetPlatformNative.iOS,
      onChanged: (bool value) {


//          defaultTargetPlatformNative = TargetPlatformNative.iOS;
        Prefs.singleton().setThemeNative(TargetPlatformNative.iOS.toString());
        AppHome.restartApp(context);


      },
    );

    var temaIosColumn  = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).iosNative,
              style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),
            ),
            temaIos
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );


    var temaAndroid = CupertinoSwitch(
      value: defaultTargetPlatformNative == TargetPlatformNative.android,
      onChanged: (bool value) {

//          defaultTargetPlatformNative = TargetPlatformNative.android;
        Prefs.singleton().setThemeNative(TargetPlatformNative.android.toString());
        AppHome.restartApp(context);

      },
    );

    var temaAndroidColumn  = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).androidNative,
              style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),
            ),
            temaAndroid
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );


    var temaApp = CupertinoSwitch(
      value: defaultTargetPlatformNative == TargetPlatformNative.app,
      onChanged: (bool value) {

        Prefs.singleton().setThemeNative(TargetPlatformNative.app.toString());
        AppHome.restartApp(context);

      },
    );



    var temaAppColumn  = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).defaultStr,
              style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),
            ),
            temaApp
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );


    var themeDark = CupertinoSwitch(
      value:  Prefs.singleton().getTheme() == Themes.DARK.toString() ,
      onChanged: (bool value) {
        widget.pai.setState(() {
          Prefs.singleton().setTheme(Themes.DARK.toString());
        });
      },
    );



    var themeDarkColumn  = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Dark",
              style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),
            ),
            themeDark
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );



    var themeLIGHT = CupertinoSwitch(
      value:  Prefs.singleton().getTheme() == Themes.LIGHT.toString() ,
      onChanged: (bool value) {
        widget.pai.setState(() {

          Prefs.singleton().setTheme(Themes.LIGHT.toString());
        });
      },
    );



    var themeLIGHTColumn  = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Light",
              style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),
            ),
            themeLIGHT
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );





    var themeSystem = CupertinoSwitch(
      value:  Prefs.singleton().getTheme() == Themes.SYSTEM.toString() ,
      onChanged: (bool value) {
        widget.pai.setState(() {

          Prefs.singleton().setTheme(Themes.SYSTEM.toString());
        });
      },
    );



    var themeSystemColumn  = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "System",
              style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.body2.color),
            ),
            themeSystem
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );




    return Scaffold(
      body:  Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.grey, Colors.grey[100]],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                backgroundColor: Colors.transparent,
                title:  Center(child: Text(AppLocalizations.of(context).settings)),
              ),
              new SliverList(
                delegate: new SliverChildListDelegate(
                  <Widget>[
                    new InfoListSection(
                      title: AppLocalizations.of(context).user,
//                      imagePath: 'assets/info_backgrounds/bg_1.png',
                      child: Stack(
                        children: <Widget>[
                          ImageBackgroundTeste(
                              backgroundImage: backgroundImage,
                              profileImage: avatar,
                              containerGrowAnimation: containerGrowAnimation,
                              nome: nome),

                        ],
                      ),
                    ),
                    new InfoListSection(
                      title: AppLocalizations.of(context).contact,
                      child: new StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('contacts')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return new Center(
                                child: new CircularProgressIndicator());

                          List<Widget> children =
                          snapshot.data.documents.map((document) {
                            return Column(
                              children: <Widget>[
                                new ListTile(
                                  title: new Text(document['name']),
                                  subtitle: new Text(document['title']),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          List<Widget> children = [
                                            new ListTile(
                                                title:
                                                new Text(document['info'])),
                                            new Divider(
                                              height: 1.0,
                                            )
                                          ];

                                          if (document['email'] != null) {
                                            children.add(
                                              new ListTile(
                                                title: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: new Text(
                                                      document['email'],
                                                    )),
                                                leading: new Icon(Icons.email),
                                                onTap: () {
//                                                  launch('mailto:${document['email']}');
                                                },
                                              ),
                                            );
                                            children
                                                .add(new Divider(height: 1.0));
                                          }

                                          if (document['phone'] != null) {
                                            children.add(
                                              new ListTile(
                                                title:
                                                new Text(document['phone']),
                                                leading: new Icon(Icons.phone),
                                                onTap: () {
//                                                  launch('tel:${document['phone']}');
                                                },
                                              ),
                                            );
                                            children
                                                .add(new Divider(height: 1.0));
                                          }

                                          return new AlertDialog(
                                            title: new Text(document['name']),
                                            content: new Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: children,
                                            ),
                                            actions: <Widget>[
                                              new FlatButton(
                                                  child: new Text('Close'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  })
                                            ],
                                          );
                                        });
                                  },
                                ),
                                new Divider(
                                  height: 2.0,
                                ),
                              ],
                            );
                          }).toList();

                          return new Column(
                            children: children,
                          );
                        },
                      ),
                    ),
                    InfoListSection(
                      title: AppLocalizations.of(context).theme,
                      child: Column(
                        children: <Widget>[
                          temaAppColumn,
                          temaIosColumn,
                          temaAndroidColumn

                        ],
                      ),
                    ),
                    InfoListSection(
                      title: AppLocalizations.of(context).brightness,
                      child: Column(
                        children: <Widget>[
                          themeSystemColumn,
                          themeDarkColumn,
                          themeLIGHTColumn,

                        ],
                      ),
                    ),


                    SafeArea(
                      top: false,
                      bottom: defaultTargetPlatformNative == TargetPlatformNative.android ? false : true,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: MenusSistema(contextPai: context,key: UniqueKey()),
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  @override
  Widget build(context) {
    return PlatformWidgetNative(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
      appBuilder: _buildIos,
    );
  }


}

class AddQuestionPage extends StatefulWidget {
  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  final TextEditingController textController = new TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextFormField questionField = new TextFormField(
      autofocus: true,
      maxLength: 150,
      controller: textController,
      validator: (value) {
        if (value.length < 10) {
          return 'question not long enough';
        }

        return null;
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('New Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Text(
              'How can we help?',
              style: new TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18.0,
              ),
            ),
            new Form(
              key: formKey,
              child: questionField,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          if (!loading && formKey.currentState.validate()) {
            setState(() {
              loading = true;
            });
            FirebaseAuth.instance.currentUser().then((user) {
              if (user != null) {
                Firestore.instance.collection('questions').add({
                  'question': '${textController.text}',
                  'timestamp': DateTime.now(),
                  'uid': user.uid,
                }).whenComplete(() {
                  Navigator.of(context).pop();
                });
              } else {
                setState(() {
                  loading = false;
                });
              }
            }).catchError(() {
              setState(() {
                loading = false;
              });
            });
          }
        },
        child: !loading
            ? new Icon(
                Icons.send,
                color: Colors.white,
              )
            : new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
      ),
    );
  }
}

final List<MaterialColor> letterColors = [
  Colors.cyan,
  Colors.deepOrange,
  Colors.pink,
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.lightBlue,
  Colors.purple,
  Colors.teal,
  Colors.orange,
  Colors.yellow,
  Colors.indigo,
  Colors.amber,
  Colors.lime
];
