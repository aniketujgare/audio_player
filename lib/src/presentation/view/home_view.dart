import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../blocs/audio_player_bloc/audioplayer_bloc.dart';
import '../widgets/music_info_tile.dart';

class HomeView extends StatelessWidget {
  final OnAudioQuery audioQuery;
  const HomeView({super.key, required this.audioQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Music"),
          elevation: 2,
        ),
        body: BlocConsumer<AudioplayerBloc, AudioplayerState>(
          listener: (context, state) {
            if (state is PermissionErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please grant the permission')));
            }
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error Loading Songs')));
            }
          },
          builder: (context, state) {
            if (state is PermissionErrorState) {
              return AlertDialog(
                title: const Text('Please grant the permisson'),
                actions: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<AudioplayerBloc>()
                            .add(AskPermissionEvent());
                      },
                      icon: const Text('Give Permission'))
                ],
              );
            }
            if (state is MusicFilesLoadedState) {
              var songsList = state.songList;
              return ListView.builder(
                itemCount: songsList.length,
                itemBuilder: (context, index) {
                  return MusicInfoTile(
                      songsList: songsList,
                      audioQuery: audioQuery,
                      index: index);
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
