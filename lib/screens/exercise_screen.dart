import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'exercisehub_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';

class ExerciseScreen extends StatefulWidget {
  final Exercises exercises;
  final int seconds;

  ExerciseScreen({this.exercises, this.seconds});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  bool _isCompleted = false;
  int _elapsedSeconds = 0;
  Timer timer;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == widget.seconds) {
        t.cancel();
        setState(() {
          _isCompleted = true;
        });
        playAudio();
      }

      setState(() {
        _elapsedSeconds = t.tick;
      });
    });
    super.initState();
  }

  void playAudio() {
    audioCache.play("cheering.wav");
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: widget.exercises.gif,
                placeholder: (context, url) => Image(
                  image: AssetImage("assets/placeholder.jpg"),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            _isCompleted != true
                ? SafeArea(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Text("$_elapsedSeconds / ${widget.seconds} S"),
                    ),
                  )
                : Container(),
            SafeArea(
                child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }))
          ],
        ),
      ),
    );
  }
}
