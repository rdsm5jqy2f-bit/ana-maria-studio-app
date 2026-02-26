import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../core/app_config.dart';

class PinkLayer extends StatelessWidget {
  final String? backgroundAsset;
  final Widget? child;

  const PinkLayer({
    super.key,
    this.backgroundAsset,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (backgroundAsset != null)
          Positioned.fill(
            child: Image.asset(
              backgroundAsset!,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              gaplessPlayback: true,
              errorBuilder: (_, __, ___) => Container(color: Colors.black),
            ),
          )
        else
          Positioned.fill(child: Container(color: Colors.pink.shade100)),
        if (child != null)
          child!
        else
          const Center(
              child: Text('PINK TEST',
                  style: TextStyle(fontSize: 32, color: Colors.black))),
      ],
    );
  }
}
