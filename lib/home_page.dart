import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'layers/red_layer.dart';
import 'layers/blue_layer.dart';
import 'layers/green_layer.dart';
import 'core/app_config.dart';
import 'core/ui_widgets.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final double frameWidth = math.max(360.0, width);
    // Banner heights derived from intrinsic aspect ratios for full-image containment.
    final double redHeight = frameWidth / LayerTuning.redAspectRatio;
    final double blueHeight = frameWidth / LayerTuning.blueAspectRatio;
    final double greenMinHeight = math.max(height * 0.66, frameWidth / LayerTuning.greenAspectRatio);

    return ColoredBox(
      color: Colors.black,
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: SizedBox(
                    width: frameWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: redHeight,
                          width: double.infinity,
                          child: const RedLayer(),
                        ),
                        SizedBox(
                          height: blueHeight,
                          width: double.infinity,
                          child: const BlueLayer(),
                        ),
                      ],
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: greenMinHeight),
                  child: const GreenLayer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
