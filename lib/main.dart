import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

void main() => runApp(MandAShow());

class MandAShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The M&A Show',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MaShowApp(),
      ),
    );
  }
}

class MaShowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: Placeholder(),
          flex: 9,
        ),
        Flexible(
          child: AudioControls(),
          flex: 2,
        ),
      ],
    );
  }
}

class AudioControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PlaybackButtons(),
      ],
    );
  }
}

class PlaybackButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        PlayBackButton(),
      ],
    );
  }
}

class PlayBackButton extends StatefulWidget {
  @override
  _PlayBackButtonState createState() => _PlayBackButtonState();
}

class _PlayBackButtonState extends State<PlayBackButton> {
  bool _isPlaying = false;
  FlutterSound _sound;
  final url =
      'https://incompetech.com/music/royalty-free/mp3-royaltyfree/Surf%20Shimmy.mp3';

  double _playPosition;

  Stream<PlayStatus> _playerSubscription;

  @override
  void initState() {
    super.initState();
    _sound = FlutterSound();
    _playPosition = 0;
  }

  void _stop() async {
    await _sound.stopPlayer();
    setState(() => _isPlaying = false);
  }

  void _play() async {
    await _sound.startPlayer(url);

    _playerSubscription = _sound.onPlayerStateChanged
      ..listen((e) {
        if (e != null) {
          print(e.currentPosition);
          setState(() => _playPosition = (e.currentPosition / e.duration));
        }
      });
    setState(() => _isPlaying = true);
  }

  void _fastForward() {}

  void _rewind() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 400,
            child: Slider(value: _playPosition, onChanged: null)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(icon: Icon(Icons.fast_rewind), onPressed: () {}),
            IconButton(
              icon: _isPlaying ? Icon(Icons.stop) : Icon(Icons.play_arrow),
              onPressed: () {
                if (_isPlaying) {
                  _stop();
                } else {
                  _play();
                }
              },
            ),
            IconButton(icon: Icon(Icons.fast_forward), onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
