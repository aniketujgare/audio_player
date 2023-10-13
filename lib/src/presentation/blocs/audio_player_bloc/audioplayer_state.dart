part of 'audioplayer_bloc.dart';

@immutable
sealed class AudioplayerState {}

final class AudioplayerInitial extends AudioplayerState {}

class LoadMusicFilesState extends AudioplayerState {}

class ErrorState extends AudioplayerState {
  final String error;

  ErrorState({required this.error});
}

class PermissionErrorState extends AudioplayerState {
  final String error;

  PermissionErrorState({required this.error});
}

class MusicFilesLoadedState extends AudioplayerState {
  final List<SongModel> songList;

  MusicFilesLoadedState({required this.songList});
}
