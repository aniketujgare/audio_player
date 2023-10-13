import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../blocs/audio_controll_cubit/audio_controll_cubit.dart';
import '../blocs/audio_player_bloc/audioplayer_bloc.dart';
import '../widgets/music_title.dart';
import '../widgets/music_volume_slider.dart';

// ignore: must_be_immutable
class MusicPlayerView extends StatelessWidget {
  int musicIndex;
  MusicPlayerView({super.key, required this.musicIndex});
  @override
  Widget build(BuildContext context) {
    List<SongModel> musicFiles = [];
    final audioControllerCubit = context.read<AudioControllCubit>();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AudioControllCubit, AudioControllState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: height * 0.1),
                BlocBuilder<AudioplayerBloc, AudioplayerState>(
                  builder: (context, state) {
                    if (state is MusicFilesLoadedState) {
                      musicFiles = state.songList;

                      // audioControllerCubit.playMusic(
                      //     path: state.songList[musicIndex].data,
                      //     musicIndex: musicIndex);
                      return QueryArtworkWidget(
                        artworkHeight: width * 0.8,
                        artworkWidth: width * 0.8,
                        quality: 100,
                        id: state.songList[musicIndex].id,
                        type: ArtworkType.AUDIO,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 100),
                MusicTitle(musicIndex: musicIndex),
                musicControlls(musicFiles, audioControllerCubit),
                const MusicVolumeSlider(),
                BlocBuilder<AudioControllCubit, AudioControllState>(
                  builder: (context, state) {
                    if (state is PositionUpdated) {
                      final currentPosition = state.position;
                      final totalDuration = audioControllerCubit.getDuration();

                      return Slider(
                        value: currentPosition.inMilliseconds.toDouble(),
                        min: 0,
                        max: 4,
                        onChanged: (value) {
                          final seekPosition =
                              Duration(milliseconds: value.toInt());
                          audioControllerCubit.seekAudio(
                              duration: seekPosition);
                        },
                      );
                    } else {
                      return const SizedBox(); // Hide the seek bar if not updated
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  BlocBuilder<AudioplayerBloc, AudioplayerState> musicControlls(
      List<SongModel> musicFiles, AudioControllCubit audioControllerCubit) {
    return BlocBuilder<AudioplayerBloc, AudioplayerState>(
      builder: (context, state) {
        if (state is MusicFilesLoadedState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    if (musicIndex - 1 < musicFiles.length) {
                      audioControllerCubit.playNextPrevTrack(
                          path: musicFiles[musicIndex - 1].data);
                    }
                    musicIndex -= 1;
                  },
                  icon: const Icon(Icons.arrow_back)),
              IconButton(onPressed: () async {
                if (audioControllerCubit.isPlaying) {
                  audioControllerCubit.pauseMusic();
                } else {
                  audioControllerCubit.playMusic(
                      path: state.songList[musicIndex].data,
                      musicIndex: musicIndex);
                }
              }, icon: BlocBuilder<AudioControllCubit, AudioControllState>(
                builder: (context, state) {
                  return Icon(audioControllerCubit.isPlaying
                      ? Icons.pause
                      : Icons.play_circle_fill);
                },
              )),
              IconButton(
                  onPressed: () {
                    if (musicIndex + 1 < musicFiles.length) {
                      audioControllerCubit.playNextPrevTrack(
                          path: state.songList[musicIndex + 1].data);
                    }
                    musicIndex += 1;
                  },
                  icon: const Icon(Icons.arrow_forward)),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
