import 'package:flutter/foundation.dart';
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
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final double maxWidth = 1400;
    final double frameWidth = width.clamp(0.0, maxWidth);
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final totalHeight = constraints.maxHeight;
          final redHeight = totalHeight * (UiSizes.redFlex / 100);
          final blueHeight = totalHeight * (UiSizes.blueFlex / 100);
          final greenHeight = totalHeight - redHeight - blueHeight;
          return Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Center(
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
                      SizedBox(
                        height: greenHeight,
                        width: double.infinity,
                        child: const GreenLayer(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
