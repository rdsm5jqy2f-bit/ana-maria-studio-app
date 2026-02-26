
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'core/app_config.dart';
import 'core/ui_widgets.dart';
import 'layers/red_layer.dart';
import 'layers/blue_layer.dart';
import 'layers/pink_layer.dart';

class SectionPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (kIsWeb) {
      final size = MediaQuery.of(context).size;
      if (size.width >= 980) {
        final frameWidth = (size.width - 96).clamp(900.0, 1180.0);
        final frameHeight = (size.height * 0.94).clamp(700.0, 1120.0);
        final redH = frameHeight * UiSizes.redPct;
        final pinkH = frameHeight * (UiSizes.pinkFlex / 100.0);

        final pageContent = Column(
          children: [
            SizedBox(height: redH, child: const RedLayer()),
            SizedBox(
              height: pinkH,
              child: PinkLayer(
                backgroundAsset: backgroundAsset,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RainbowText(
                            title,
                            fontSize: 18,
                            weight: FontWeight.w900,
                            firstCapsOnly: false,
                            headingStyle: true,
                          ),
                        ),
                        GoldWordButton(
                          label: 'Back',
                          alignLeft: false,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          onTap: () => Navigator.of(context).maybePop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ],
        );

        return Scaffold(
          backgroundColor: Colors.black,
          body: Scrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      backgroundAsset ?? AppAssets.pinkFallback,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      filterQuality: FilterQuality.high,
                      gaplessPlayback: true,
                      errorBuilder: (_, __, ___) => Container(color: Colors.black),
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                          width: frameWidth,
                          height: frameHeight,
                        ),
                        child: pageContent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    final h = MediaQuery.of(context).size.height;
    final redH = h * UiSizes.redPct;

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Scrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: redH, child: const RedLayer()),
                  SizedBox(
                    height: constraints.maxHeight - redH,
                    child: PinkLayer(
                      backgroundAsset: backgroundAsset,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RainbowText(
                                  title,
                                  fontSize: 18,
                                  weight: FontWeight.w900,
                                  firstCapsOnly: false,
                                  headingStyle: true,
                                ),
                              ),
                              GoldWordButton(
                                label: 'Back',
                                alignLeft: false,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                onTap: () => Navigator.of(context).maybePop(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Expanded(child: child),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
