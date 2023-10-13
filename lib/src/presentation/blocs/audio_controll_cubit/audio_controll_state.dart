part of 'audio_controll_cubit.dart';

abstract class AudioControllState {}

class Playing extends AudioControllState {}

class Paused extends AudioControllState {}

class Initial extends AudioControllState {}
// enum AudioControllState { playing, paused, initial }
