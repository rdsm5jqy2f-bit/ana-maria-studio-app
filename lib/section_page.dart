
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'core/app_config.dart';
import 'core/ui_widgets.dart';
import 'layers/red_layer.dart';
import 'layers/blue_layer.dart';
import 'layers/pink_layer.dart';

class SectionPage extends StatefulWidget {
  final String title;
  final Widget child;
  final String? backgroundAsset;

  const SectionPage({
    super.key,
    required this.title,
    required this.child,
    this.backgroundAsset,
  });

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  final ScrollController _pageController = ScrollController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewportHeight = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    final frameWidth = (size.width - 32).clamp(360.0, 1600.0);
    final redH = frameWidth / LayerTuning.redAspectRatio;
    final pinkMinH = math.max(viewportHeight * 0.77, frameWidth / LayerTuning.pinkAspectRatio);

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: redH, child: const RedLayer()),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: pinkMinH),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.black87],
              ),
              image: DecorationImage(
                image: AssetImage(widget.backgroundAsset ?? AppAssets.pinkFallback),
                fit: BoxFit.contain,
                alignment: Alignment.center,
                filterQuality: FilterQuality.high,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RainbowText(
                          widget.title,
                          fontSize: 18,
                          weight: FontWeight.w900,
                          firstCapsOnly: false,
                          headingStyle: true,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: GoldWordButton(
                              label: 'Back',
                              alignLeft: false,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              onTap: () => Navigator.of(context).maybePop(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  widget.child,
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Scrollbar(
        controller: _pageController,
        thumbVisibility: true,
        trackVisibility: true,
        child: SingleChildScrollView(
          controller: _pageController,
          physics: const ClampingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: frameWidth),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
