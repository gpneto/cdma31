import 'package:cdma31/redux/app_state.dart';
import 'package:cdma31/redux/login/auth_actions.dart';
import 'package:cdma31/screen/login/login_screan.dart';
import 'package:cdma31/util/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';



import '../../app_config.dart';
import 'Profile_Notification.dart';



class ImageBackgroundTeste extends StatelessWidget {
  final DecorationImage backgroundImage;
  final DecorationImage profileImage;

  String nome;
//  SharedPreferences prefs;

  final Animation<double> containerGrowAnimation;
  ImageBackgroundTeste(
      {this.backgroundImage,
      this.containerGrowAnimation,
      this.profileImage,
      this.nome});

    @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;
    return (new Container(
        width: screenSize.width,
        height: 300,
       decoration: new BoxDecoration(
    gradient: new LinearGradient(
    begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Colors.grey, Colors.grey[100]],
    ),
    ),
        child: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            colors: <Color>[
              const Color.fromRGBO(110, 101, 103, 0.6),
              const Color.fromRGBO(51, 51, 63, 0.9),
            ],
            stops: [0.2, 1.0],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
          )),
          child:  Stack(
            children: <Widget>[
          Positioned(
          child: Align(
            alignment: FractionalOffset.center,
            child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text(
                          "$nome",
                          style: new TextStyle(
                              fontSize: 30.0,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                        new ProfileNotification(
                          containerGrowAnimation: containerGrowAnimation,
                          profileImage: profileImage,
                        ),
                        new OutlineButton(
                          shape: StadiumBorder(),
                          textColor: Colors.blue,
                          child: Text(AppLocalizations.of(context).logOut),
                          borderSide: BorderSide(
                              color: Colors.blue, style: BorderStyle.solid,
                              width: 1),
                          onPressed: () {


                            StoreProvider.of<AppState>(context)
                                .dispatch(LogOutAction());

                            //Faz o Logout
//                            FirebaseAuth.instance.signOut().then((valor){
//                              Navigator.of(context)
//                                  .pushReplacement(new MaterialPageRoute(builder: (context) => new LoginPage()));
//                            });

                          },
                        )
                      ],
                    ))),
              Positioned(
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(
                      "${AppLocalizations.of(context).version} ${AppConfig.of(context).versao}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
