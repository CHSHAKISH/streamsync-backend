// lib/features/home/bloc/video_state.dart
import 'package:frontend/core/models/video.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_state.freezed.dart'; // Will be generated

@freezed
sealed class VideoState with _$VideoState {
  const factory VideoState.initial() = _Initial;
  const factory VideoState.loading() = _Loading;
  const factory VideoState.loaded({required List<Video> videos}) = _Loaded;
  const factory VideoState.error({required String message}) = _Error;
}