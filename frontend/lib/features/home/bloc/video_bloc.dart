// lib/features/home/bloc/video_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/repositories/video_repository.dart';
import 'package:frontend/core/models/video.dart';
import 'video_event.dart';
import 'video_state.dart';
import 'package:injectable/injectable.dart'; // <-- 1. IMPORT THIS

// This mock data is correct, based on your 'video.dart' file
final List<Video> _mockVideos = [
  Video(
    videoId: 'aqz-KE-bpKQ', // Big Buck Bunny
    title: 'Big Buck Bunny (Test Video)',
    thumbnailUrl: 'https://i.ytimg.com/vi/aqz-KE-bpKQ/0.jpg',
    channelId: 'Test Channel 1',
    publishedAt: DateTime(2008, 4, 25),
  ),
  Video(
    videoId: 'TW6HieDBa0A', // Sintel (Another test video)
    title: 'Map My Station App',
    thumbnailUrl: 'https://i.ytimg.com/vi/_xGl-S-t_2s/0.jpg',
    channelId: 'CH Shakish',
    publishedAt: DateTime(2024, 9, 29),
  ),
  Video(
    videoId: 'N51J6WOopO4', // Elephants Dream (Test video)
    title: 'Jal Samiksha App',
    thumbnailUrl: 'https://i.ytimg.com/vi/jn-9n8gL-qI/0.jpg',
    channelId: 'CH Shakish',
    publishedAt: DateTime(2024, 9, 29),
  ),
];

@injectable
class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final IVideoRepository _videoRepository;

  VideoBloc(this._videoRepository) : super(const VideoState.initial()) {

    on<VideoEvent>((event, emit) async {
      await event.when(
        fetchLatest: () async {
          emit(const VideoState.loading());
          await Future.delayed(const Duration(seconds: 1));
          emit(VideoState.loaded(videos: _mockVideos));
        },
      );
    });
  }
}