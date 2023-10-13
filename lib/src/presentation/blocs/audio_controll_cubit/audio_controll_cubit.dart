import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/src/data/datasources/audio_player_repository.dart';

part 'audio_controll_state.dart';

class AudioControllCubit extends Cubit<AudioControllState> {
  late int currentMusicId;
  bool _isPlaying = false;
  // double _currentAudioPosition = 0;
  // Duration _totalDuration = const Duration();
  final AudioPlayerRepository songRepository;
  AudioControllCubit({required this.songRepository}) : super(Initial());
  bool get isPlaying => _isPlaying;
  bool get audioPlayer => songRepository.player;
  // double get currentAudioPosition => _currentAudioPosition;
  // Duration get totalDuration => _totalDuration;
  Future<Duration?> getDuration() async {
    return await songRepository.getDuration();
  }

  void playMusic({required String path, required int musicIndex}) {
    _isPlaying = true;
    currentMusicId = musicIndex;
    songRepository.playSong(path);
    emit(Playing());
  }

  void pauseMusic() {
    _isPlaying = false;
    songRepository.pauseSong();
    emit(Paused());
  }

  void setVolume({required double volume}) async {
    await songRepository.setVolume(volume);
  }

  void playNextPrevTrack({required String path}) {
    songRepository.playSong(path);
    emit(Paused());
    emit(Playing());
  }

  void seekAudio({required Duration duration}) {
    songRepository.seekAudio(duration);
  }

  void updatePosition(Duration position) {
    emit(PositionUpdated(position));
  }
}
