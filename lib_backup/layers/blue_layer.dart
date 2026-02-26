
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../core/app_config.dart';

class BlueLayer extends StatelessWidget {
  final Widget? child;
  const BlueLayer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final primaryAsset = AppAssets.blueLayer;
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
        if (child != null) child!
      ],
    );
  }
}
