// backend/src/video/video.controller.ts
import { Controller, Get } from '@nestjs/common';

@Controller('videos')
export class VideosController {
  // This endpoint is now at /api/videos/latest
  @Get('latest')
  getLatestVideos() {
    // --- THIS IS THE NEW, CORRECT DATA ---
    // It matches the 'Video' model in your Flutter app
    return [
      {
        video_id: 'N51J6WOopO4', // "Get started with Flutter"
        title: 'Jal Samiksha Flutter App',
        thumbnail_url: 'https://i.ytimg.com/vi/W-_b-g8o_cM/0.jpg',
        channel_id: 'Ch Shakish',
        published_at: '2024-09-29T15:00:00Z', // Use ISO string
      },
      {
        video_id: 'TW6HieDBa0A', // "Flutter in Focus"
        title: 'Map My Station Flutter App',
        thumbnail_url: 'https://i.ytimg.com/vi/r-g-u8eypS4/0.jpg',
        channel_id: 'Ch Shakish',
        published_at: '2025-09-29T15:00:00Z',
      },
      {
        video_id: 'hUGtN4Kf1lM', // "Flutter Engage Keynote"
        title: 'Gen AI Access Code Remdemption',
        thumbnail_url: 'https://i.ytimg.com/vi/I-8-c1nIuA/0.jpg',
        channel_id: 'Flutter',
        published_at: '2024-05-04T15:00:00Z',
      },
    ];
    // --- END OF NEW DATA ---
  }
}