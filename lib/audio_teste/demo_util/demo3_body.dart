/*
 * Copyright 2018, 2019, 2020 Dooboolab.
 *
 * This file is part of Flutter-Sound.
 *
 * Flutter-Sound is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License version 3 (LGPL-V3), as published by
 * the Free Software Foundation.
 *
 * Flutter-Sound is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Flutter-Sound.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:io';

import 'package:cdma31/application.dart';
import 'package:cdma31/redux/app_state.dart';
import 'package:cdma31/util/app_localization.dart';
import 'package:cdma31/util/player_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_sound/src/util/temp_file.dart';

import 'demo_active_codec.dart';
import 'demo_asset_player.dart';
import 'demo_drop_downs.dart';
import 'recorder_state.dart';
import 'remote_player.dart';
//import 'package:flutter_incall_manager/flutter_incall_manager.dart';
import 'package:flutter_sound/src/util/recorded_audio.dart';
import 'package:flutter_sound/src/ui/sound_recorder_ui.dart';
import 'package:uuid/uuid.dart';

///
class MainBody extends StatefulWidget {
  ///
  const MainBody({
    Key key,
  }) : super(key: key);

  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  bool initialized = false;

  String recordingFile;
  Track track;
//  IncallManager incallManager = new IncallManager();

  @override
  void initState() {
    super.initState();
    tempFile(suffix: '.aac').then((path) {
      recordingFile = path;
      track = Track(trackPath: recordingFile);
      track.trackAuthor = 'Brett';
      setState(() {});
    });
  }

  Future<bool> init() async {
    if (!initialized) {
      initializeDateFormatting();
      await UtilRecorder().init();
      ActiveCodec().recorderModule = UtilRecorder().recorderModule;
      ActiveCodec().setCodec(withUI: false, codec: Codec.aacADTS);

      initialized = true;
    }
    return initialized;
  }

  void dispose() {
    if (recordingFile != null) {
      File(recordingFile).delete();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: false,
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            return Container(
              width: 0,
              height: 0,
              color: Colors.white,
            );
          } else {
//            final dropdowns = Dropdowns(
//                onCodecChanged: (codec) =>
//                    ActiveCodec().setCodec(withUI: false, codec: codec));

            return ListView(
              children: <Widget>[
                _buildRecorder(track),
//                dropdowns,
                buildPlayBars(),
              ],
            );
          }
        });
  }

  Widget buildPlayBars() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(StoreProvider.of<AppState>(context).state.user.uid)
          .collection("audios")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              shrinkWrap: true,
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlayerWidget(
                    url: document.data["path"].toString(),
                    local: true,
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }

  bool enviadoAudio = false;

  OnStop teste(RecordedAudio a) {
    //Aqui exibe um Pop Up com o audio gravade e a opção de gravar
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                content: enviadoAudio
                    ? Container(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              right: -40.0,
                              top: -40.0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: CircleAvatar(
                                  child: Icon(Icons.close),
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SoundPlayerUI.fromTrack(
                                      track,
                                      showTitle: true,
                                      audioFocus: true
                                          ? AudioFocus.requestFocusAndDuckOthers
                                          : AudioFocus
                                              .requestFocusAndDuckOthers,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    child:
                                        Text(AppLocalizations.of(context).save),
                                    onPressed: () async {
                                      setState(() {
                                        enviadoAudio = true;
                                      });

                                      await _uploadFile(a, context);

                                      setState(() {
                                        enviadoAudio = false;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ));
          });
        });
  }

  Widget _buildRecorder(Track track) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RecorderPlaybackController(
        child: Column(
          children: [
            SoundRecorderUI(
              track,
              onStopped: teste,
            ),
//            Left("Recording Playback"),
//            SoundPlayerUI.fromTrack(
//              track,
//              showTitle: true,
//              audioFocus: true
//                  ? AudioFocus.requestFocusAndDuckOthers
//                  : AudioFocus.requestFocusAndDuckOthers,
//            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _uploadFile(RecordedAudio a, BuildContext context) async {
  final String uuid = Uuid().v1();
  final StorageReference ref = FirebaseStorage.instance
      .ref()
      .child('audios')
      .child(StoreProvider.of<AppState>(context).state.user.uid)
      .child('foo$uuid.aac');
  StorageUploadTask uploadTask = ref.putFile(
    File(a.track.trackPath),
  );

  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
  dynamic downloadUrl1 = await storageTaskSnapshot.ref.getDownloadURL();

  String pathRef = await storageTaskSnapshot.ref.getPath();
  Firestore.instance.collection('/users/${StoreProvider.of<AppState>(context).state.user.uid}/audios').add({
    'nome': '$uuid.aac',
    "path": downloadUrl1,
    "ref": pathRef,
    "duracao": a.duration.toString(),
    "status": "ATIVO"
  });
}

///
class Left extends StatelessWidget {
  ///
  final String label;

  ///
  Left(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 4, left: 8),
      child: Container(
          alignment: Alignment.centerLeft,
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}
