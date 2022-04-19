import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class VideoChewieModel extends StatefulWidget {
  final VideoPlayerController playerController;
  final String urlvideo;
  final String coursName;
  const VideoChewieModel({
    Key? key,
    required this.playerController,
    required this.urlvideo,
    required this.coursName,
  }) : super(key: key);

  @override
  State<VideoChewieModel> createState() => _VideoChewieModelState();
}

class _VideoChewieModelState extends State<VideoChewieModel> {
  ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.playerController,
      looping: true,
      autoInitialize: true,
      errorBuilder: (context, message) => Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 17.0, color: Colors.white),
        ),
      ),
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => () async {
              final directory = await getApplicationDocumentsDirectory();
              final file =
                  File("${directory.path}/${widget.coursName}/cours.mp4");
              final response = await Dio().get(
                widget.urlvideo,
                options: Options(
                  responseType: ResponseType.bytes,
                  followRedirects: false,
                ),
              );
              final raf = file.openSync(
                mode: FileMode.write,
              );
              raf.writeFromSync(response.data);
              await raf.close();
            },
            iconData: Icons.download,
            title: 'Télécharger',
          ),
          OptionItem(
            onTap: () => debugPrint('partager à un autre user'),
            iconData: Icons.share,
            title: 'partager a un autre élève',
          ),
        ];
      },
      optionsTranslation: OptionsTranslation(
        playbackSpeedButtonText: 'vtisse de lecture',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController!,
    );
  }

  @override
  void dispose() {
    _chewieController!.dispose();
    widget.playerController.dispose();
    super.dispose();
  }
}
