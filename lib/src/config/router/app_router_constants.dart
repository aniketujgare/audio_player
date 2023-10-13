class _AppRoutModel {
  final String name;
  final String path;

  _AppRoutModel({required this.name, required this.path});
}

class AppRoutConstants {
  static final homeView = _AppRoutModel(name: 'home_view', path: '/');
  static final musicPlayerView =
      _AppRoutModel(name: 'musicplayer_view', path: '/musicplayer_view');
}
