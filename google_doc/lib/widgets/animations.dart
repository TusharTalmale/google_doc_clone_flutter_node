import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppAnimations {
  static List<Effect> get fadeIn => [
    FadeEffect(duration: 300.ms),
    SlideEffect(
      begin: const Offset(0, 10),
      end: Offset.zero,
      duration: 300.ms,
      curve: Curves.easeOut,
    ),
  ];

  static List<Effect> get scaleIn => [
    ScaleEffect(
      begin: const Offset(0.95, 0.95),
      end: const Offset(1, 1),
      duration: 200.ms,
      curve: Curves.easeOut,
    ),
    FadeEffect(duration: 200.ms),
  ];

  static List<Effect> get slideInRight => [
    SlideEffect(
      begin: const Offset(30, 0),
      end: Offset.zero,
      duration: 300.ms,
      curve: Curves.easeOutCubic,
    ),
    FadeEffect(duration: 300.ms),
  ];
}

extension WidgetAnimation on Widget {
  Widget animateFadeIn({int delayMs = 0}) {
    return animate(delay: delayMs.ms).addEffects(AppAnimations.fadeIn);
  }
  
  Widget animateScaleIn({int delayMs = 0}) {
    return animate(delay: delayMs.ms).addEffects(AppAnimations.scaleIn);
  }
}