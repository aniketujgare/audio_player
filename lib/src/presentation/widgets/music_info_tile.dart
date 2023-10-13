import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../config/router/app_router_constants.dart';

class MusicInfoTile extends StatelessWidget {
  const MusicInfoTile({
    super.key,
    required this.songsList,
    required this.audioQuery,
    required this.index,
  });

  final List<SongModel> songsList;
  final OnAudioQuery audioQuery;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(songsList[index].title),
      subtitle: Text(
        songsList[index].artist ?? "No Artist",
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_rounded),
          onPressed: () {
            context.pushNamed(AppRoutConstants.musicPlayerView.name,
                extra: index);
          }),
      leading: QueryArtworkWidget(
        controller: audioQuery,
        id: songsList[index].id,
        type: ArtworkType.AUDIO,
      ),
    );
  }
}
