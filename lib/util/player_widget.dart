import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

enum PlayerState { stopped, playing, paused }
enum PlayingRouteState { speakers, earpiece }

List<AudioPlayer> play = [];

class PlayerWidget extends StatefulWidget {
  final String url;
  final PlayerMode mode;
  final bool local;

  PlayerWidget({Key key,
    @required this.url,
    this.mode = PlayerMode.MEDIA_PLAYER,
    this.local = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState(url, mode);
  }
}

class _PlayerWidgetState extends State<PlayerWidget> with  AutomaticKeepAliveClientMixin<PlayerWidget>{

  @override
  bool get wantKeepAlive => true;
  bool initialized = false;

  String url;
  PlayerMode mode;
  AudioCache audioCache = AudioCache();
  AudioPlayer _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  AudioPlayerState _audioPlayerState;
  Duration _duration;
  Duration _position = Duration(seconds: 0);

  PlayerState _playerState = PlayerState.stopped;
  PlayingRouteState _playingRouteState = PlayingRouteState.speakers;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _isPlaying => _playerState == PlayerState.playing;

  get _isPaused => _playerState == PlayerState.paused;

  get _durationText =>
      _duration
          ?.toString()
          ?.split('.')
          ?.first ?? '';

  get _positionText =>
      _position
          ?.toString()
          ?.split('.')
          ?.first ?? '';

  get _isPlayingThroughEarpiece =>
      _playingRouteState == PlayingRouteState.earpiece;

  _PlayerWidgetState(this.url, this.mode);

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 35,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  key: Key('play_button'),
                  onPressed: _isPlaying ? null : () => _play(),
                  iconSize: 24.0,
                  icon: Icon(Icons.play_arrow),
                  color: Colors.cyan,
                ),
                IconButton(
                  key: Key('pause_button'),
                  onPressed: _isPlaying ? () => _pause() : null,
                  iconSize: 24.0,
                  icon: Icon(Icons.pause),
                  color: Colors.cyan,
                ),
                IconButton(
                  key: Key('stop_button'),
                  onPressed: _isPlaying || _isPaused ? () => _stop() : null,
                  iconSize: 24.0,
                  icon: Icon(Icons.stop),
                  color: Colors.cyan,
                ),
                IconButton(
                  onPressed: _earpieceOrSpeakersToggle,
                  iconSize: 24.0,
                  icon: _isPlayingThroughEarpiece
                      ? Icon(Icons.volume_up)
                      : Icon(Icons.hearing),
                  color: Colors.cyan,
                ),
              ],
            ),
          ),

          FutureBuilder(
              initialData: false,
              future: init(),
              builder: (context, snapshot) {


                if (snapshot.data == false) {
                  return Container(
                   child: CircularProgressIndicator(),

                  );
                } else {
                  Duration duration = snapshot.data;
                 return  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 6.0),
                            inactiveTrackColor: Colors.blueGrey,
                          ),
                          child: Slider(
                            onChanged: (v) {
                              final Position = v * duration.inMilliseconds;
                              _audioPlayer
                                  .seek(
                                  Duration(milliseconds: Position.round()));
                            },
                            value: (_position != null &&
                                duration != null &&
                                _position.inMilliseconds > 0 &&
                                _position.inMilliseconds <
                                    duration.inMilliseconds)
                                ? _position.inMilliseconds /
                                duration.inMilliseconds
                                : 0.0,
                          )),
                      Text(
                        _position != null
                            ? '${_positionText ?? ''} / ${_durationText ?? ''}'
                            : duration != null ? _durationText : '',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  );
                }
              })

//          Text('State: $_audioPlayerState')
        ],
      ),
    );
  }

  Future<Duration> _getDuration() async {
    File audiofile = await audioCache.loadFromUrl(widget.url);
//    File audiofile = await audioCache.load(widget.url);

    await _audioPlayer.setUrl(
      audiofile.path,
    );
    int duration = await Future.delayed(
        Duration(milliseconds: 100), () => _audioPlayer.getDuration());

    return Duration(milliseconds: duration);
  }

  Future<Duration> init() async {
    if (!initialized) {

      _duration = await _getDuration();
      initialized = true;
    }
    return _duration;
  }

  void _initAudioPlayer() {
    play.add(_audioPlayer);

    if (widget.local) {
      if (Platform.isIOS) {
        if (audioCache.fixedPlayer != null) {
          audioCache.fixedPlayer.startHeadlessService();
        }
      }


//      File audiofile = await audioCache.loadFromUrl(widget.url);
//      await _audioPlayer.setUrl(
//        audiofile.path,
//      );
//      int duration  = await Future.delayed(
//          Duration(seconds: 2), () => _audioPlayer.getDuration());
//
//      _duration =  Duration(milliseconds:duration);

    }

    //Faz o Download do arquivo

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);

      // TODO implemented for iOS, waiting for android impl
      if (Theme
          .of(context)
          .platform == TargetPlatform.iOS) {
        // (Optional) listen for notification updates in the background
        _audioPlayer.startHeadlessService();

        // set at least title to see the notification bar on ios.
        _audioPlayer.setNotification(
            title: 'App Name',
            artist: 'Artist or blank',
            albumTitle: 'Name or blank',
            imageUrl: 'url or blank',
            forwardSkipInterval: const Duration(seconds: 30),
            // default is 30s
            backwardSkipInterval: const Duration(seconds: 30),
            // default is 30s
            duration: duration,
            elapsedTime: Duration(seconds: 0));
      }
    });

    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p) =>
            setState(() {
              _position = p;
            }));

    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
          _onComplete();
          setState(() {
            _position = _duration;
          });
        });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.stopped;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _audioPlayerState = state;

        if (_audioPlayerState == AudioPlayerState.PAUSED) {
          _playerState = PlayerState.paused;
        }
      });
    });

    _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() => _audioPlayerState = state);
    });

    _playingRouteState = PlayingRouteState.speakers;
  }

  Future<int> _play() async {
    play.forEach((element) {
      if (element.state == AudioPlayerState.PLAYING) {
        element.pause();
      }
    });

    final playPosition = (_position != null &&
        _duration != null &&
        _position.inMilliseconds > 0 &&
        _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;

    if (_audioPlayerState != null &&
        _audioPlayerState == AudioPlayerState.COMPLETED) {
      _audioPlayer.seek(Duration(milliseconds: 0));
    }

    final int result = widget.local
        ? await _audioPlayer.resume()
        : await _audioPlayer.play(url, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);

    // default playback rate is 1.0
    // this should be called after _audioPlayer.play() or _audioPlayer.resume()
    // this can also be called everytime the user wants to change playback rate in the UI
    _audioPlayer.setPlaybackRate(playbackRate: 1.0);
    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

  Future<int> _earpieceOrSpeakersToggle() async {
    final result = await _audioPlayer.earpieceOrSpeakersToggle();
    if (result == 1)
      setState(() =>
      _playingRouteState =
      _playingRouteState == PlayingRouteState.speakers
          ? PlayingRouteState.earpiece
          : PlayingRouteState.speakers);
    return result;
  }

  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration(seconds: 0);
      });
    }
    return result;
  }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }
}
