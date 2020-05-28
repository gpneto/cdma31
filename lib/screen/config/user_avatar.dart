import 'dart:io';


import 'package:cdma31/model/user.dart';
import "package:flutter/material.dart";




class UserAvatar extends StatelessWidget {
  const UserAvatar({
    @required this.user,
    this.size = 36.0,
  });

  // user can be null
  final User user;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (user?.image == null || user?.imageLocal == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child:Image.asset(
          "assets/avatars/avatar.png",
          height: size,
          width: size,
          fit: BoxFit.contain,
        ),
      );


    }

    if(user?.image == "loader"){
      return CircularProgressIndicator();
    }


    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Image.file(File(user.imageLocal), width:size , height: size, fit:  BoxFit.fitHeight),
    );


  }
}
