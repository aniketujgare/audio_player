import 'package:audioplayers/audioplayers.dart';

class AudioPlayerRepository {
  final player = AudioPlayer();

  void playSong(String path) {
    player.play(DeviceFileSource(path));
  }

  void pauseSong() {
    player.pause();
  }

  Future<void> setVolume(double volume) async {
    await player.setVolume(volume);
  }

  Future<void> seekAudio(Duration position) async {
    await player.seek(position);
  }
}
