
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../core/app_config.dart';

class RedLayer extends StatelessWidget {
  const RedLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryAsset = AppAssets.redLayer;
    final fit = BoxFit.cover;
    final alignment = Alignment.center;

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Image.asset(
            primaryAsset,
            fit: BoxFit.cover,
            alignment: alignment,
            filterQuality: FilterQuality.high,
            gaplessPlayback: true,
            errorBuilder: (_, __, ___) => Container(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
