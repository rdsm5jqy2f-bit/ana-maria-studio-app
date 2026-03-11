import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'core/app_config.dart';
import 'core/ui_widgets.dart';
import 'layers/red_layer.dart';

class SectionPage extends StatefulWidget {
  final String title;
  final Widget child;
  final String? backgroundAsset;
  final String? pageId;

  const SectionPage({
    super.key,
    required this.title,
    required this.child,
    this.backgroundAsset,
    this.pageId,
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
    final frameWidth = math.max(360.0, size.width);
    final redH = frameWidth / LayerTuning.redAspectRatio;
    final pinkMinH = math.max(
      viewportHeight - redH,
      frameWidth / LayerTuning.pinkAspectRatio,
    );
    final requestedAsset = widget.backgroundAsset;
    final fallbackAsset = AppAssets.pinkByTitle(widget.title);
    final resolvedBackgroundAsset =
      (requestedAsset != null && requestedAsset.trim().isNotEmpty)
        ? requestedAsset
        : fallbackAsset;
    final resolvedPageId =
        (widget.pageId != null && widget.pageId!.trim().isNotEmpty)
            ? AppAssets.slugFromTitle(widget.pageId!)
            : AppAssets.slugFromTitle(widget.title);

    Widget content = Column(
      key: ValueKey<String>('pink-page-$resolvedPageId'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: redH, child: const RedLayer()),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: pinkMinH),
          child: Container(
            decoration: const BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.black87],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Transform.translate(
                    offset: LayerTuning.pinkOffset,
                    child: Transform.scale(
                      scale: LayerTuning.pinkScale,
                      child: Image.asset(
                        resolvedBackgroundAsset,
                        fit: BoxFit.cover,
                        alignment: LayerTuning.pinkAlignment,
                        filterQuality: FilterQuality.high,
                        gaplessPlayback: true,
                        errorBuilder: (_, __, ___) =>
                            Container(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
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
              ],
            ),
          ),
        ),
      ],
    );

    return ColoredBox(
      color: Colors.black,
      child: Scrollbar(
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
