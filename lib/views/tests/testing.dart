import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class Testing extends StatefulWidget {
  final XFile? videoPath;
  Testing({Key? key, this.videoPath}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  late final VideoPlayerController _controller;
  late Future<void> initializeVideoPlayer;
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath!.path));
    initializeVideoPlayer = _controller.initialize();
    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        int currentTime = _controller.value.position.inSeconds;
        for (var marker in markers) {
          if (marker.positionInSeconds == currentTime) {
            marker.isVisible = true;
          } else {
            marker.isVisible = false;
          }
        }
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addMarker(int positionInSeconds, Offset position) {
    setState(() {
      markers.add(Marker(
        index: markers.length + 1,
        positionInSeconds: positionInSeconds,
        position: position,
        isVisible: false,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Stack(
              children: [
                SafeArea(
                  child: GestureDetector(
                    onTapUp: (TapUpDetails details) {
                      if (_controller.value.isPlaying) {
                        Duration currentPosition = _controller.value.position;
                        int seconds = currentPosition.inSeconds;
                        _addMarker(seconds, details.globalPosition);
                      }
                    },
                    child: FutureBuilder(
                      future: initializeVideoPlayer,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: 4 / 4,
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
                for (var marker in markers)
                  if (marker.isVisible)
                    Positioned(
                      left: marker.position.dx - 14,
                      top: marker.position.dy - 14,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${marker.index}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ],
      ),
    );
  }
}

class Marker {
  final int index;
  final int positionInSeconds;
  final Offset position;
  bool isVisible;

  Marker({
    required this.index,
    required this.positionInSeconds,
    required this.position,
    required this.isVisible,
  });
}
