// lib/features/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/home/bloc/video_bloc.dart';
import 'package:frontend/features/home/bloc/video_event.dart';
import 'package:frontend/features/home/bloc/video_state.dart';
import 'package:frontend/injection.dart';
import 'package:frontend/features/video_player/video_player_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => getIt<VideoBloc>()
        ..add(const VideoEvent.fetchLatest()), // Trigger the initial fetch
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Feed')),
        body: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {

            return state.when(
              initial: () => const Center(child: Text('Initializing...')),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (videos) {
                // This builds the list once the videos are loaded
                return ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];

                    return ListTile(

                      leading: Image.network(
                        video.thumbnailUrl,
                        width: 100,
                        fit: BoxFit.cover,

                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 50,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image),
                          );
                        },
                      ),

                      // Use the real title and channel from your video object
                      title: Text(video.title),
                      subtitle: Text(video.channelId),


                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerPage(

                              videoId: video.videoId,
                            ),
                          ),
                        );
                      },

                    );
                  },
                );
              },
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $message'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Allow user to retry the fetch
                        context.read<VideoBloc>().add(const VideoEvent.fetchLatest());
                      },
                      child: const Text('Retry'),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}