import 'package:on_audio_query/on_audio_query.dart';

class AudioQueryRepository {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  get audioquery => _audioQuery;

  void initializeLogs() {
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);
  }

  Future<bool> accesPermissons() async {
    return await _audioQuery.checkAndRequest(
      retryRequest: false,
    );
  }

  Future<bool> reaccesPermissons() async {
    return await _audioQuery.checkAndRequest(retryRequest: true);
  }

  Future<List<SongModel>> loadAllMusicFiles() {
    return _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }
}
