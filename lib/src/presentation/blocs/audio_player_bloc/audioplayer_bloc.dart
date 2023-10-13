import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/src/data/datasources/audio_query_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'audioplayer_event.dart';
part 'audioplayer_state.dart';

class AudioplayerBloc extends Bloc<AudioplayerEvent, AudioplayerState> {
  List<SongModel>? musicFiles;
  final AudioQueryRepository musicRepository;
  AudioplayerBloc({required this.musicRepository})
      : super(AudioplayerInitial()) {
    on<InitializeAudioPlayerEvent>((event, emit) async {
      musicRepository.initializeLogs();
      bool permission = await musicRepository.accesPermissons();
      if (permission) {
        // load files and show on ui
        add(LoadMusicFilesEvent());
      } else {
        emit(PermissionErrorState(error: 'Please grant the permisson'));
      }
    });
    on<LoadMusicFilesEvent>((event, emit) async {
      try {
        musicFiles ??= await musicRepository.loadAllMusicFiles();
        emit(MusicFilesLoadedState(songList: musicFiles!));
      } catch (e) {
        emit(ErrorState(error: 'Fail to load music'));
      }
    });
    on<AskPermissionEvent>((event, emit) async {
      bool permisson = await musicRepository.reaccesPermissons();
      if (permisson) {
        add(LoadMusicFilesEvent());
      } else {
        emit(PermissionErrorState(error: 'Please grant the permisson'));
      }
    });
  }
}
