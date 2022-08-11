import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SoundpoolService {
  SoundpoolService._();
  static SoundpoolService? _instance;
  static Soundpool? _soundpool;
  static int? _soundId;
  static int? _alarmSoundStreamId;
  static Future<SoundpoolService> get instance async {
    if (_instance == null) {
      _instance = SoundpoolService._();
      await _init();
    }
    return _instance!;
  }

  static Future<void> _init() async {
    _soundpool = Soundpool.fromOptions(
        options: const SoundpoolOptions(
      androidOptions: SoundpoolOptionsAndroid.kDefault,
      iosOptions: SoundpoolOptionsIos.kDefault,
    ));
    _soundId = await _instance!._loadSound();
  }

  Future<int> _loadSound() async {
    final asset = await rootBundle.load("assets/sounds/notification.wav");
    return await _soundpool!.load(asset);
  }

  Future<void> playSound() async {
    _alarmSoundStreamId = await _soundpool!.play(_soundId!);
  }

  Future<void> stopSound() async {
    if (_alarmSoundStreamId != null) {
      await _soundpool!.stop(_alarmSoundStreamId!);
    }
  }
}
