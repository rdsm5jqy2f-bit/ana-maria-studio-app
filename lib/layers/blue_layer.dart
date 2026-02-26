
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../core/app_config.dart';

class BlueLayer extends StatelessWidget {
  final Widget? child;
  const BlueLayer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final primaryAsset = AppAssets.blueLayer;
    final alignment = LayerTuning.blueAlignment;
    final scale = LayerTuning.blueScale;
    final offset = LayerTuning.blueOffset;

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
        if (child != null) child!
      ],
    );
  }
}
