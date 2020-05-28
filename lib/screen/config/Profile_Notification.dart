import 'dart:async';
import 'dart:io';

import 'package:cdma31/redux/app_actions.dart';
import 'package:cdma31/redux/app_state.dart';
import 'package:cdma31/redux/user/user_actions.dart';
import 'package:cdma31/screen/config/user_avatar.dart';
import 'package:cdma31/screen/config/viewmodel/user_screen_viewmodel.dart';
import 'package:cdma31/util/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';


import 'modal_item.dart';

class ProfileNotification extends StatelessWidget {
  final Animation<double> containerGrowAnimation;
  final DecorationImage profileImage;
  ProfileNotification({this.containerGrowAnimation, this.profileImage});
  @override
  Widget build(BuildContext context) {
  return StoreConnector<AppState, UserScreenViewModel>(
    builder: ((context, vm) {

      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Container(
                  width: containerGrowAnimation.value * 180,
                  height: containerGrowAnimation.value * 180,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: profileImage,
                  ),
                  child: UserAvatar(
                    user: vm.user,
                    size:200,
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    width: containerGrowAnimation.value * 50,
                    height: containerGrowAnimation.value * 50,
                    child: AnimatedSwitcher(
                      child: _buildPictureIconButton(context, vm) ?? SizedBox.shrink(),
                      duration: Duration(milliseconds: 200),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );

    }),



    converter: UserScreenViewModel.fromStore(),
    distinct: true,
//    onInitialBuild: _setInitialEditState,
  );}


  Widget _buildPictureIconButton(BuildContext context,UserScreenViewModel vm) {
    return Visibility(
      visible: true,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: InkWell(
          onTap: () {
            showCupertinoModalPopup(
              context:context ,
              builder: (BuildContext context) => CupertinoActionSheet(
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    child: ModalItem(
                      iconAsset: "assets/icon_pictures.png",
                      label: AppLocalizations.of(context).gallery,
                    ),
                    onPressed: () {
                      _changeUserAvatar(ImageSource.gallery, context, vm);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: ModalItem(
                      iconAsset: "assets/icon_camera.png",
                      label: AppLocalizations.of(context).camera,
                    ),
                    onPressed: () {
                      _changeUserAvatar(ImageSource.camera, context, vm);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: ModalItem(
                      iconData: Icons.delete_outline,
                      label: AppLocalizations.of(context).delete,
                    ),
                    onPressed: () {
                      _removeUserAvatar(context, vm);
                    },
                  ),
                ],
              ),
            );
          },
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: Container(
            height: 50,
            width: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/icon_camera.png"),
            ),
          ),
        ),
      ),
    );
  }



  Future _changeUserAvatar(
      ImageSource source,
      BuildContext context,
      UserScreenViewModel vm,
      ) async {
    // NOTE: The whole avatar upload will be redone once we have the proper UI
    File imageFile = await ImagePicker.pickImage(source: source, imageQuality: 50);
    if(imageFile != null) {
      StoreProvider.of<AppState>(context).dispatch(ChangeAvatarAction(
        file: imageFile,
        user: vm.user,
      ));
    }
    //Aqui Coloca um Loader

    await Navigator.of(context).maybePop();
  }

  Future _removeUserAvatar(
      BuildContext context,
      UserScreenViewModel vm,
      ) async {
    StoreProvider.of<AppState>(context).dispatch(
        UpdateUserAction(vm.user.rebuild((u) => u..image = null), Completer()));
    await Navigator.of(context).maybePop();
  }

}
