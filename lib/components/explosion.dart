import 'dart:async';
import 'dart:math';

import 'package:cosmic_havoc/my_game.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/particles.dart';
import 'package:flutter/widgets.dart';

enum ExplosionType { dust, smoke, fire }

class Explosion extends PositionComponent with HasGameReference<MyGame> {
  final ExplosionType explosionType;
  final double explosionSize;
  final Random _random = Random();

  Explosion({
    required super.position,
    required this.explosionSize,
    required this.explosionType,
  });

  @override
  FutureOr<void> onLoad() {
    final int num = 1 + _random.nextInt(2);
    game.audioManager.playSound('explode$num');

    _createFlash();
    _createParticles();

    add(RemoveEffect(delay: 1.0));

    return super.onLoad();
  }

  void _createFlash() {
    final CircleComponent flash = CircleComponent(
      radius: explosionSize * 0.6,
      paint: Paint()..color = const Color.fromRGBO(255, 255, 255, 1.0),
      anchor: Anchor.center,
    );

    final OpacityEffect fadeOutEffect = OpacityEffect.fadeOut(
      EffectController(duration: 0.3),
    );

    flash.add(fadeOutEffect);
    add(flash);
  }

  List<Color> _generateColors() {
    switch (explosionType) {
      case ExplosionType.dust:
        return [
          const Color(0xFF5A4632),
          const Color(0xFF6B543D),
          const Color(0xFF8A6E50),
        ];
      case ExplosionType.smoke:
        return [
          const Color(0xFF404040),
          const Color(0xFF606060),
          const Color(0xFF808080),
        ];
      case ExplosionType.fire:
        return [
          const Color(0xFFFFD700),
          const Color(0xFFFFA500),
          const Color(0xFFFFC107),
        ];
    }
  }

  void _createParticles() {
    final List<Color> colors = _generateColors();

    final ParticleSystemComponent particles = ParticleSystemComponent(
      particle: Particle.generate(
        count: 8 + _random.nextInt(5),
        generator: (index) {
          return MovingParticle(
            child: CircleParticle(
              paint: Paint()
                ..color = colors[_random.nextInt(colors.length)].withValues(
                  alpha: 0.4 + _random.nextDouble() * 0.4,
                ),
              radius: explosionSize * (0.1 + _random.nextDouble() * 0.05),
            ),
            to: Vector2(
              (_random.nextDouble() - 0.5) * explosionSize * 2,
              (_random.nextDouble() - 0.5) * explosionSize * 2,
            ),
            lifespan: 0.5 + _random.nextDouble() * 0.5,
          );
        },
      ),
    );

    add(particles);
  }
}
