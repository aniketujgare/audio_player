import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../data/datasources/audio_player_repository.dart';
import '../../data/datasources/audio_query_repository.dart';
import '../../presentation/blocs/audio_controll_cubit/audio_controll_cubit.dart';
import '../../presentation/blocs/audio_player_bloc/audioplayer_bloc.dart';
import '../../presentation/blocs/volume_slider_cubit.dart';
import '../../presentation/view/home_view.dart';
import '../../presentation/view/music_player_view.dart';
import 'app_router_constants.dart';

final musicRepository = AudioQueryRepository();
final musicBloc = AudioplayerBloc(musicRepository: musicRepository)
  ..add(InitializeAudioPlayerEvent());
final songRepository = AudioPlayerRepository();
final musicCubit = AudioControllCubit(songRepository: songRepository);
final volumeSliderCubit = VolumeSliderCubit(songRepository: songRepository);
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        name: AppRoutConstants.homeView.name,
        path: AppRoutConstants.homeView.path,
        pageBuilder: (context, state) => MaterialPage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: musicBloc,
              ),
            ],
            child: HomeView(audioQuery: musicRepository.audioquery),
          ),
        ),
      ),
      GoRoute(
          name: AppRoutConstants.musicPlayerView.name,
          path: AppRoutConstants.musicPlayerView.path,
          pageBuilder: (context, state) {
            int musicIndex = state.extra as int;
            return MaterialPage(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: musicBloc,
                  ),
                  BlocProvider.value(
                    value: musicCubit,
                  ),
                  BlocProvider.value(
                    value: volumeSliderCubit,
                  ),
                ],
                child: MusicPlayerView(musicIndex: musicIndex),
              ),
            );
          }),
    ],
  );
}
