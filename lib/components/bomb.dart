import 'dart:async';

import 'package:cosmic_havoc/components/asteroid.dart';
import 'package:cosmic_havoc/my_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';

class Bomb extends SpriteComponent
    with HasGameReference<MyGame>, CollisionCallbacks {
  Bomb({required super.position})
      : super(
          size: Vector2.all(1),
          anchor: Anchor.center,
          priority: -1,
        );

  @override
  FutureOr<void> onLoad() async {
    game.audioManager.playSound('fire');

    sprite = await game.loadSprite('bomb.png');

    add(CircleHitbox(isSolid: true));

    add(SequenceEffect([
      SizeEffect.to(
        Vector2.all(800),
        EffectController(
          duration: 1.0,
          curve: Curves.easeInOut,
        ),
      ),
      OpacityEffect.fadeOut(
        EffectController(duration: 0.5),
      ),
      RemoveEffect(),
    ]));

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Asteroid) {
      other.takeDamage();
    }
  }
}
