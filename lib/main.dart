import 'package:cosmic_havoc/my_game.dart';
import 'package:cosmic_havoc/overlays/game_over_overlay.dart';
import 'package:cosmic_havoc/overlays/title_overlay.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final MyGame game = MyGame();

  runApp(GameWidget(
    game: game,
    overlayBuilderMap: {
      'GameOver': (context, MyGame game) => GameOverOverlay(game: game),
      'Title': (context, MyGame game) => TitleOverlay(game: game),
    },
    initialActiveOverlays: const ['Title'],
  ));
}
