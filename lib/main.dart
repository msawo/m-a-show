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
      body: Center(
        child: PlayBackButton(),
      ),
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

  @override
  void initState() {
    super.initState();
    _sound = FlutterSound();
  }

  void _stop() async {
    await _sound.stopPlayer();
  }

  void _play() async {
    await _sound.startPlayer(url);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isPlaying ? Icon(Icons.stop) : Icon(Icons.play_arrow),
      onPressed: () {
        if (_isPlaying) {
          _stop();
        } else {
          _play();
        }
        setState(() {
          _isPlaying = !_isPlaying;
        });
      },
    );
  }
}
