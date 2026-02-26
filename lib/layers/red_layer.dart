
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../core/app_config.dart';

class RedLayer extends StatelessWidget {
  const RedLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryAsset = AppAssets.redLayer;
    final alignment = LayerTuning.redAlignment;
    final scale = LayerTuning.redScale;
    final offset = LayerTuning.redOffset;

    return Stack(
      fit: StackFit.expand,
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.black87],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Transform.translate(
            offset: offset,
            child: Transform.scale(
              scale: scale,
              child: Image.asset(
                primaryAsset,
                fit: BoxFit.contain,
                alignment: alignment,
                filterQuality: FilterQuality.high,
                gaplessPlayback: true,
                errorBuilder: (_, __, ___) => Container(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
