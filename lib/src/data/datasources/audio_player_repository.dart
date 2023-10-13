import 'package:audioplayers/audioplayers.dart';

class AudioPlayerRepository {
  final _player = AudioPlayer();
  get player => _player;

  Future<Duration?> getDuration() async {
    return await _player.getDuration();
  }

  void playSong(String path) {
    _player.play(DeviceFileSource(path));
  }

  void pauseSong() {
    _player.pause();
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  Future<void> seekAudio(Duration position) async {
    await _player.seek(position);
  }
}
