// lib/core/models/video.dart


class Video {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final String channelId;
  final DateTime publishedAt;

  // Standard constructor
  Video({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    required this.channelId,
    required this.publishedAt,
  });

  // A manual 'fromJson' factory that does the work.
  // This removes the need for build_runner for this file.
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      videoId: json['video_id'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      channelId: json['channel_id'] as String,
      publishedAt: DateTime.parse(json['published_at'] as String),
    );
  }
}