// lib/features/home/bloc/video_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/repositories/video_repository.dart';
import 'package:frontend/core/models/video.dart';

import 'video_event.dart';
import 'video_state.dart';

import 'package:injectable/injectable.dart';

@injectable
class VideoBloc extends Bloc<VideoEvent, VideoState> {
  // We will now USE this repository
  final IVideoRepository _videoRepository;

  VideoBloc(this._videoRepository) : super(const VideoState.initial()) {

    on<VideoEvent>((event, emit) async {
      await event.when(
        fetchLatest: () async {
          emit(const VideoState.loading());

          // --- THIS IS THE LIVE API CALL ---
          try {
            // 1. Call the repository to get videos from the API
            final videos = await _videoRepository.getLatestVideos();

            // 2. Emit the 'loaded' state with the videos from the API
            emit(VideoState.loaded(videos: videos));

          } catch (e) {
            // 3. If it fails, emit the 'error' state
            emit(VideoState.error(message: e.toString()));
          }
        },
      );
    });
  }
}