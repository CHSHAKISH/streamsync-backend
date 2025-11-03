// lib/features/home/bloc/video_event.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_event.freezed.dart'; // Will be generated

@freezed
sealed class VideoEvent with _$VideoEvent {
  const factory VideoEvent.fetchLatest() = _FetchLatest;
}