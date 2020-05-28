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

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'demo_active_codec.dart';
import 'package:uuid/uuid.dart';
/// path to remote auido file.
const String exampleAudioFilePath =
    "https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_700KB.mp3";

/// path to remote auido file artwork.
final String albumArtPath =
    "https://file-examples.com/wp-content/uploads/2017/10/file_example_PNG_500kB.png";

///
class RemotePlayer extends StatelessWidget {

  final String path;

  final StorageReference ref;

  const RemotePlayer({Key key, this.path, this.ref}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SoundPlayerUI.fromLoader(
      _createRemoteTrack,
      showTitle: false,
      audioFocus: AudioFocus.requestFocusAndStopOthers,
    );
  }

  Future<Track> _createRemoteTrack(BuildContext context) async {
    Track track;
    // validate codec for example file
//    if (ActiveCodec().codec != Codec.mp3) {
//      var error = SnackBar(
//          backgroundColor: Colors.red,
//          content: Text('You must set the Codec to MP3 to '
//              'play the "Remote Example File"'));
//      Scaffold.of(context).showSnackBar(error);
//    } else {


    String pathq = await _downloadFile();
      // We have to play an example audio file loaded via a URL
      track = Track(trackPath: "https://www.bensound.com/bensound-music/bensound-summer.mp3", codec: Codec.mp3);

      track.trackTitle = "Remote mpeg playback.";
      track.trackAuthor = "By flutter_sound";
      track.albumArtUrl = albumArtPath;


      if (Platform.isIOS) {
        track.albumArtAsset = 'AppIcon';
      } else if (Platform.isAndroid) {
        track.albumArtAsset = 'AppIcon.png';
      }
//    }

    return track;
  }

  Future<String> _downloadFile() async {
    final String uuid = Uuid().v1();
    final http.Response downloadData = await http.get(this.path);
    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/tmp$uuid.aac');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    final StorageFileDownloadTask task = ref.writeToFile(tempFile);
    final int byteCount = (await task.future).totalByteCount;
//    final String tempFileContents = await tempFile.readAsString();



    final String fileContents = downloadData.body;
    final String name = await ref.getName();
    final String bucket = await ref.getBucket();
    final String path = await ref.getPath();

    //tempFile.readAsBytes();
   return tempFile.path;

//      content: Text(
//        'Success!\n Downloaded $name \n from url: $url @ bucket: $bucket\n '
//            'at path: $path \n\nFile contents: "$fileContents" \n'
//            'Wrote "$tempFileContents" to tmp.txt',
//        style: const TextStyle(color: Color.fromARGB(255, 0, 155, 0)),
//      ),

  }

}
