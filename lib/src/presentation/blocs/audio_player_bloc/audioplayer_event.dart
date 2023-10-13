part of 'audioplayer_bloc.dart';

@immutable
sealed class AudioplayerEvent {}

class InitializeAudioPlayerEvent extends AudioplayerEvent {}

class LoadMusicFilesEvent extends AudioplayerEvent {}

class PermissionErrorEvent extends AudioplayerEvent {}

class AskPermissionEvent extends AudioplayerEvent {}

class ErrorEvent extends AudioplayerEvent {}
