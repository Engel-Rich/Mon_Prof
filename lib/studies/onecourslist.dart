import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:monprof/models/videoChewieModel.dart';
import 'package:video_player/video_player.dart';

class OneCoursLessonsList extends StatefulWidget {
  final String matiere;
  final String classe;
  const OneCoursLessonsList(
      {Key? key, required this.matiere, required this.classe})
      : super(key: key);

  @override
  State<OneCoursLessonsList> createState() => _OneCoursLessonsListState();
}

class _OneCoursLessonsListState extends State<OneCoursLessonsList> {
  VideoPlayerController? _controller;
  Container videored() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30.0),
      child: _controller!.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            )
          : const SizedBox(
              child: Text('the video controler was not initialized')),
    );
  }

  final List list = <String>[];
  final String host = 'kedycours.000webhostapp.com';
  getcours() async {
    final url = Uri(
        scheme: "https",
        host: host,
        path: "/getelms/getcours.php",
        queryParameters: {
          'matiere': widget.matiere,
          "classe": widget.classe,
        });
    print(url);
    final response = await get(url);
    if (response.statusCode == 200) {
      for (var video in jsonDecode(response.body)) {
        setState(() {
          list.add(
            video['video'].toString().replaceAll('localhost', host),
          );
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getcours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.matiere,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: list.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 10.0),
                itemCount: list.length,
                itemBuilder: (context, index) => Container(
                  height: MediaQuery.of(context).size.width,
                  child: VideoChewieModel(
                    playerController:
                        VideoPlayerController.network(list[index]),
                    coursName: widget.matiere,
                    urlvideo: list[index],
                  ),
                ),
              ),
            )
          : const Center(
              child: FlutterLogo(
                size: 200,
                textColor: Colors.black,
                style: FlutterLogoStyle.stacked,
              ),
            ),
    );
  }
}
