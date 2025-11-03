import { Controller, Get } from '@nestjs/common';

@Controller('videos')
export class VideosController {
  // This creates the http://localhost:3000/videos/latest endpoint
  @Get('latest')
  getLatestVideos() {
    // This is our hardcoded data for now.
    return [
      {
        video_id: 'fake_id_1',
        title: 'Video Title 1',
        thumbnail_url: 'https://via.placeholder.com/150',
        channel_id: 'channel_1',
        published_at: new Date().toISOString(),
      },
      {
        video_id: 'fake_id_2',
        title: 'Video Title 2',
        thumbnail_url: 'https://via.placeholder.com/150',
        channel_id: 'channel_1',
        published_at: new Date().toISOString(),
      },
    ];
  }
}