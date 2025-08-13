import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioManager extends Component {
  bool musicEnabled = true;
  bool soundsEnabled = true;

  final List<String> _sounds = [
    'click',
    'collect',
    'explode1',
    'explode2',
    'fire',
    'hit',
    'laser',
    'start',
  ];

  
  @override
  FutureOr<void> onLoad() async {
    FlameAudio.bgm.initialize();

    // preload the sound effect files
    await FlameAudio.audioCache
        .loadAll(_sounds.map((s) => '$s.ogg').toList());

    return super.onLoad();
  }

  void playMusic() {
    if (musicEnabled) {
      FlameAudio.bgm.play('music.ogg');
    }
  }

  void playSound(String sound) {
    if (soundsEnabled) {
      FlameAudio.play('$sound.ogg');
    }
  }

  void toggleMusic() {
    musicEnabled = !musicEnabled;
    if (musicEnabled) {
      playMusic();
    } else {
      FlameAudio.bgm.stop();
    }
  }

  void toggleSounds() {
    soundsEnabled = !soundsEnabled;
  }
}
