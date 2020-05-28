import 'package:cdma31/redux/app_state.dart';
import 'package:cdma31/redux/login/auth_actions.dart';
import 'package:cdma31/screen/login/styles.dart';
import 'package:cdma31/util/app_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../app_config.dart';
import 'InputFields.dart';
import 'login_screen_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final username = TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();
  final pass = TextEditingController();

  Animation buttonSqueezeanimation;
  AnimationController buttonController;

  @override
  void initState() {
    super.initState();

    buttonController = AnimationController(
        duration: new Duration(milliseconds: 5000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: 320.0,
      end: 70.0,
    ).animate(
      new CurvedAnimation(
        parent: buttonController,
        curve: new Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  @override
  dispose() {
    buttonController.dispose();
    super.dispose();
  }

  bool primeiro = true;

  @override
  Widget build(BuildContext context) {
    if (primeiro) {
      StoreProvider.of<AppState>(context)
          .dispatch(ActionStateLogin(stateLogin: StateLogin.init));
      primeiro = false;
    }
    return Container(
      decoration: new BoxDecoration(
        image: backgroundImage,
      ),
      child: Scaffold(
        key: globalKey,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
                color: const Color.fromRGBO(0, 26, 13, 0.5)),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Container(
                    width: 250.0,
                    height: 100.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      image: tick,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      height: 240,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Form(
                                    child: new Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new InputFieldArea(
                                        hint: AppLocalizations.of(context).user,
                                        obscure: false,
                                        icon: Icons.person_outline,
                                        controller: username),
                                    new InputFieldArea(
                                        hint: AppLocalizations.of(context).pass,
                                        obscure: true,
                                        icon: Icons.lock_outline,
                                        controller: pass),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          StoreConnector<AppState, LoginScreenViewModel>(
                              distinct: true,
                              converter: LoginScreenViewModel.fromStore,
                              builder: (context, vm) {
                                if (vm.stateLogin == null ||
                                    vm.stateLogin == StateLogin.init) {
                                  return AnimatedBuilder(
                                    builder:
                                        (BuildContext context, Widget child) {
                                      return Hero(
                                        tag: "heroVerde",
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10.0),
                                          child: RaisedButton(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            color: Colors.green,
                                            onPressed: () {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                              StoreProvider.of<AppState>(context)
                                                  .dispatch(LogIn(
                                                      user: username.value.text
                                                          .trim(),
                                                      pass: pass.value.text,
                                                      context: this.context,
                                                      onError: _onError));
                                              buttonController.forward();
                                            },
                                            elevation: 11,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(40.0),
                                              ),
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context).logIn,
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    animation: buttonController,
                                  );
                                } else if (vm.stateLogin ==
                                    StateLogin.logando) {
                                  return AnimatedBuilder(
                                    builder:
                                        (BuildContext context, Widget child) {
                                      return Hero(
                                        tag: "heroVerde",
                                        child: new Container(
                                          width: buttonSqueezeanimation.value,
                                          height: 60.0,
                                          alignment: FractionalOffset.center,
                                          decoration: new BoxDecoration(
                                            color: const Color.fromRGBO(
                                                63, 185, 59, 1.0),
                                            borderRadius: new BorderRadius.all(
                                              const Radius.circular(30.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(3.0, 5.0),
                                                  blurRadius: 7),
                                            ],
                                          ),
                                          child: new CircularProgressIndicator(
                                            value: null,
                                            strokeWidth: 1.0,
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                    animation: buttonController,
                                  );
                                }

                                return Container();
                              })
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    color: Colors.green,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      mostradialogo();
                    },
                    elevation: 11,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Text(AppLocalizations.of(context).sigIn,
                        style: TextStyle(color: Colors.white70)),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 90,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: WaveWidget(
                    duration: 4,
                    config: CustomConfig(
                      gradients: [
                        [Color(0xFF3D9942), Color(0xFF3D9942)],
                        [Color(0xFF00D824), Color(0xFF00D824)],
                        [Color(0xFFA1FF01), Color(0xFFA1FF01)]
                      ],
                      durations: [10440, 19440, 12800],
                      heightPercentages: [0.1, 0.4, 0.6],
                      blur: MaskFilter.blur(BlurStyle.solid, 3),
                      gradientBegin: Alignment.centerLeft,
                      gradientEnd: Alignment.centerRight,
                    ),
                    waveAmplitude: 5.0,
                    size: Size(double.infinity, 100.0),
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 5),
                    child: Text(
                      "${AppLocalizations.of(context).version}  ${AppConfig.of(context).versao}",
                      style: TextStyle(color: Colors.grey, fontSize: 9),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onError(error) async {
    globalKey.currentState.showSnackBar(new SnackBar(
        duration: Duration(seconds: 4),
        backgroundColor: Colors.red,
        content: new Text(error)));
  }

  final _formKey = GlobalKey<FormState>();

  mostradialogo() async {
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPass = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Nome',
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                            filled: true,
//                            fillColor: Colors.grey[200],
                          ),
                          controller: controllerName,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Digite o nome';
                            }
                            return null;
                          },
                          onSaved: (String value) {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'E-mail',
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                            filled: true,
//                            fillColor: Colors.grey[200],
                          ),
                          controller: controllerEmail,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Digite o seu E-mail';
                            }
                            return null;
                          },
                          onSaved: (String value) {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                            filled: true,

//                            fillColor: Colors.grey[200],
                          ),
                          controller: controllerPass,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Digite o seu Senha';
                            }
                            return null;
                          },
                          onSaved: (String value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("Salvar"),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
//
                              buttonController.forward();
                              Navigator.of(context).pop();

                              FocusScope.of(context).requestFocus(FocusNode());
                              StoreProvider.of<AppState>(context).dispatch(Sign(
                                  user: controllerName.value.text,
                                  email: controllerEmail.value.text,
                                  pass: controllerPass.value.text,
                                  context: this.context,
                                  onError: _onError));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
