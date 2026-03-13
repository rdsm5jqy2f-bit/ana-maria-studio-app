import 'package:flutter/material.dart';

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
    final requestedAsset = backgroundAsset;
    final fallbackAsset = AppAssets.pinkFallback;
    final hasCustomAsset =
        requestedAsset != null && requestedAsset.trim().isNotEmpty && requestedAsset != fallbackAsset;

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
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                fallbackAsset,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                filterQuality: FilterQuality.high,
                gaplessPlayback: true,
                errorBuilder: (_, __, ___) => Container(color: Colors.black),
              ),
              if (hasCustomAsset)
                Image.asset(
                  requestedAsset,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  filterQuality: FilterQuality.high,
                  gaplessPlayback: true,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
            ],
          ),
        ),
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
