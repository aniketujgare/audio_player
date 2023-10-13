import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/audio_player_bloc/audioplayer_bloc.dart';

class MusicTitle extends StatelessWidget {
  const MusicTitle({
    super.key,
    required this.musicIndex,
  });

  final int musicIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioplayerBloc, AudioplayerState>(
      builder: (context, state) {
        if (state is MusicFilesLoadedState) {
          return Text(
            state.songList[musicIndex].title,
            style:
                const TextStyle(fontSize: 22, overflow: TextOverflow.ellipsis),
          );
        }
        return const SizedBox();
      },
    );
  }
}
