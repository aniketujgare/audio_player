import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/src/data/datasources/audio_player_repository.dart';

class VolumeSliderCubit extends Cubit<double> {
  final AudioPlayerRepository songRepository;
  VolumeSliderCubit({required this.songRepository}) : super(0.5);

  void updateSliderValue(double value) async {
    await songRepository.setVolume(value);
    emit(value);
  }
}
