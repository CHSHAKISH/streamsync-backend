// lib/core/repositories/video_repository.dart
import 'package:dio/dio.dart';
import 'package:frontend/core/models/video.dart';
import 'package:injectable/injectable.dart';

// 1. The Contract (Interface)
abstract class IVideoRepository {
  Future<List<Video>> getLatestVideos();
}

// 2. The Implementation
@LazySingleton(as: IVideoRepository) // <-- Register with DI
class VideoRepositoryImpl implements IVideoRepository {
  final Dio _dio;

  VideoRepositoryImpl(this._dio);

  @override
  Future<List<Video>> getLatestVideos() async {
    try {
      final response = await _dio.get('/videos/latest');

      final List<dynamic> jsonList = response.data;
      final videos = jsonList.map((json) => Video.fromJson(json)).toList();

      return videos;
    } catch (e) {
      // For now, just re-throw. We'll handle errors in the BLoC.
      throw Exception('Failed to load videos: $e');
    }
  }
}