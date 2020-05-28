import 'dart:io';



import 'package:cdma31/data/file_repository.dart';
import 'package:cdma31/data/user_repository.dart';
import 'package:cdma31/redux/login/auth_actions.dart';
import 'package:cdma31/redux/user/user_actions.dart';
import 'package:cdma31/util/image_processor.dart';
import 'package:cdma31/util/logger.dart';
import 'package:path_provider/path_provider.dart';
import "package:redux/redux.dart";
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../app_actions.dart';
import '../app_state.dart';
import '../stream_subscriptions.dart';


List<Middleware<AppState>> createUserMiddleware(
    FileRepository fileRepository,
    ImageProcessor imageProcessor,
    UserRepository userRepository
) {
  return [
    TypedMiddleware<AppState, OnAuthenticated>(_listenToUser(userRepository)),
    TypedMiddleware<AppState, UpdateUserAction>(_updateUser(userRepository)),
    TypedMiddleware<AppState, ChangeAvatarAction>(_changeAvatar(
      fileRepository,
      imageProcessor,
      userRepository,
    ))
  ];
}

// Receives updates for the logged in user.
void Function(
  Store<AppState> store,
  OnAuthenticated action,
  NextDispatcher next,
) _listenToUser(
  UserRepository userRepository,
) {
  return (store, action, next) {
    next(action);
    try {

      //Ajusta o Token
      store.dispatch(UpdateUserTokenAction(store.state.fcmToken));
      userUpdateSubscription?.cancel();
      userUpdateSubscription =
          userRepository.getUserStream(action.user.uid).listen((user) async{

            if(user.image != null && user.image !="loader") {

              String name = "";

              name = path.basename(user.image);
              if (name.indexOf("?") != -1) {
                name = name.substring(0, name.indexOf("?") );
              }
              //Salva as fotos Locais
              final directory = await getApplicationDocumentsDirectory();
              final dir = directory.path;
              final pathDir = '$dir/$name.jpg';
              File file = File(pathDir);

              if(!file.existsSync()){
                await _downloadFile(user.image, pathDir);
              }

              user =  user.rebuild((u) => u..imageLocal = pathDir);

            }


        store.dispatch(OnUserUpdateAction(user));

      });
    } catch (e) {
      Logger.e("Failed to listen user", e: e, s: StackTrace.current);
    }
  };
}



Future<File> _downloadFile(String url, String nome) async {

  var req = await http.Client().get(Uri.parse(url));
  var file = File('$nome');
  await file.create(recursive: true);
  return file.writeAsBytes(req.bodyBytes);
}

void Function(
  Store<AppState> store,
  UpdateUserAction action,
  NextDispatcher next,
) _updateUser(
  UserRepository userRepository,
) {
  return (store, action, next) async {
    next(action);
    if (store.state.user.uid != action.user.uid) {
      action.completer
          .completeError(Exception("You can't update other users!"));
      return;
    }
    try {
      await userRepository.updateUser(action.user);
      store.dispatch(OnUserUpdateAction(action.user));
      action.completer.complete(action.user);
    } catch (error) {
      Logger.e("Failed to update user", e: error, s: StackTrace.current);
      action.completer.completeError(error);
    }
  };
}


void Function(
    Store<AppState> store,
    ChangeAvatarAction action,
    NextDispatcher next,
    ) _changeAvatar(
    FileRepository repository,
    ImageProcessor imageProcessor,
    UserRepository userRepository,
    ) {
  return (store, action, next) async {
    next(action);
    // TODO: proper error handling when the Avatar upload screens are
    //  implemented
    if (store.state.user.uid != action.user.uid) {
      Logger.w("Cannot change other user's pictures");
      return;
    }
    try {


      //Colocar uma imagem provisoria
      final userLoader = action.user.rebuild((u) => u..image = "loader");
      await userRepository.updateUser(userLoader);
      store.dispatch(OnUserUpdateAction(userLoader));



      final file = await imageProcessor.cropAndResizeAvatar(action.file);
      final url = await repository.uploadFile(file, action.user.uid);
//      file.rename("photo_profile.jpg");
      final user = action.user.rebuild((u) => u..image = url);
      await userRepository.updateUser(user);
      store.dispatch(OnUserUpdateAction(user));
    } catch (error) {
      Logger.e(error.toString(), s: StackTrace.current);
    }
  };
}
