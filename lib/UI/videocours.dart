import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCours extends StatefulWidget {
  const VideoCours({Key? key}) : super(key: key);

  @override
  _VideoCoursState createState() => _VideoCoursState();
}

class _VideoCoursState extends State<VideoCours> {
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    controller = VideoPlayerController.network(
        'https://www.videofolies.net/videos/mp4/2635-un-nouveau-modele-de-trottinette-special-neige');
    _initializeVideoPlayerFuture = controller.initialize();
    controller.setLooping(true);
    controller.setVolume(2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (controller.value.isInitialized) {
                            controller.play();
                          }
                        });
                      },
                      icon: const Icon(Icons.play_arrow))),
              CircleAvatar(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (controller.value.isPlaying) {
                            controller.pause();
                          }
                        });
                      },
                      icon: const Icon(Icons.pause))),
              CircleAvatar(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (controller.value.isInitialized) {
                            controller.play();
                          }
                        });
                      },
                      icon: const Icon(Icons.play_arrow))),
            ],
          ),
        ],
      ),
    );
  }
}
