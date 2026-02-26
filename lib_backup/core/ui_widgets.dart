import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UiSizes {
  // Home layout: Red 23%, Blue 21%, Green = 56%
  static const double redPct = 0.23;
  static const double bluePct = 0.21;
  static const int redFlex = 23;
  static const int blueFlex = 21;
  static const int greenFlex = 56;
  static const int pinkFlex = 77;

  static const double pagePadH = 16;
  static const double pagePadV = 14;

  // Buttons
  static const double btnRadius = 22;
  static const double btnBorder = 1.6;
  static const double btnIcon = 18;
  static const double btnFont = 15.5;
  static const double btnGap = 8;
  static const double btnRowPadH = 10;
  static const double btnRowPadV = 8;
}

class UiColors {
  static const Color gold = Color(0xFFC9A227);
  static const Color black = Colors.black;
}

class UiScale {
  static double factor(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final shortest = size.shortestSide;

    final byShortest = (shortest / 390).clamp(0.82, 1.12).toDouble();
    final byWidthWeb = (size.width / 1366).clamp(0.80, 1.18).toDouble();

    if (!kIsWeb) return byShortest;
    return (byShortest * 0.45) + (byWidthWeb * 0.55);
  }

  static double dim(BuildContext context, double value) {
    return value * factor(context);
  }
}

/// Open external URL
Future<void> openUrl(String url) async {
  final t = url.trim();
  if (t.isEmpty) return;
  final uri = Uri.parse(t);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

String titleCaseFirstOnly(String s) {
  final t = s.trim();
  if (t.isEmpty) return t;
  return t[0].toUpperCase() + t.substring(1).toLowerCase();
}

/// Luxury “rainbow” (red/gold/green) repeated densely
const LinearGradient kLuxuryRainbow = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  tileMode: TileMode.repeated,
  colors: [
    Color(0xFFB0112B), // deep red
    Color(0xFFC9A227), // gold
    Color(0xFF0E6E3A), // deep green
    Color(0xFFB0112B),
    Color(0xFFC9A227),
    Color(0xFF0E6E3A),
  ],
  stops: [0.00, 0.18, 0.34, 0.50, 0.68, 1.00],
);

class RainbowText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight weight;
  final bool firstCapsOnly;
  final bool allCaps;
  final double letterSpacing;
  final bool headingStyle;

  const RainbowText(
    this.text, {
    super.key,
    this.fontSize = UiSizes.btnFont,
    this.weight = FontWeight.w800,
    this.firstCapsOnly = true,
    this.allCaps = false,
    this.letterSpacing = 0.35,
    this.headingStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    final uiScale = UiScale.factor(context);
    String display = text;
    if (allCaps) display = text.toUpperCase();
    if (firstCapsOnly && !allCaps) display = titleCaseFirstOnly(text);

    final textWidget = ShaderMask(
      shaderCallback: (rect) => kLuxuryRainbow.createShader(rect),
      blendMode: BlendMode.srcIn,
      child: Text(
        display,
        style: TextStyle(
          fontSize: fontSize * uiScale,
          fontWeight: weight,
          fontStyle: FontStyle.italic,
          letterSpacing:
              (headingStyle ? letterSpacing + 0.22 : letterSpacing) * uiScale,
          height: 1.05,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.55),
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
            if (headingStyle)
              Shadow(
                color: Colors.black.withValues(alpha: 0.28),
                blurRadius: 8,
                offset: const Offset(0, 1.5),
              ),
          ],
        ),
      ),
    );

    if (!headingStyle) {
      return textWidget;
    }

    return Transform(
      alignment: Alignment.centerLeft,
      transform: Matrix4.identity()..setEntry(0, 1, -0.07),
      child: textWidget,
    );
  }
}

/// Gold outline ONLY around content (not full width)
class GoldWordButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback onTap;
  final bool alignLeft;
  final EdgeInsets? padding;

  const GoldWordButton({
    super.key,
    this.icon,
    required this.label,
    required this.onTap,
    this.alignLeft = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final uiScale = UiScale.factor(context);
    final radius = UiSizes.btnRadius * uiScale;
    final border = UiSizes.btnBorder * uiScale;
    final iconSize = UiSizes.btnIcon * uiScale;
    final gap = UiSizes.btnGap * uiScale;
    final defaultPadding = EdgeInsets.symmetric(
      horizontal: UiSizes.btnRowPadH * uiScale,
      vertical: UiSizes.btnRowPadV * uiScale,
    );

    final button = IntrinsicWidth(
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8 * uiScale, sigmaY: 8 * uiScale),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(radius),
              child: Container(
                padding: padding ?? defaultPadding,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(color: UiColors.gold, width: border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: iconSize, color: UiColors.gold),
                      SizedBox(width: gap),
                    ],
                    RainbowText(label),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (!alignLeft) {
      return button;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: button,
    );
  }
}

class GoldPillLabel extends StatelessWidget {
  final String label;
  final EdgeInsets? padding;

  const GoldPillLabel(
    this.label, {
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final uiScale = UiScale.factor(context);
    final radius = UiSizes.btnRadius * uiScale;
    final border = UiSizes.btnBorder * uiScale;
    final defaultPadding = EdgeInsets.symmetric(
      horizontal: UiSizes.btnRowPadH * uiScale,
      vertical: UiSizes.btnRowPadV * uiScale,
    );

    return IntrinsicWidth(
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8 * uiScale, sigmaY: 8 * uiScale),
            child: Container(
              padding: padding ?? defaultPadding,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: UiColors.gold, width: border),
              ),
              child: RainbowText(label, firstCapsOnly: false),
            ),
          ),
        ),
      ),
    );
  }
}

class FollowColumn extends StatelessWidget {
  final VoidCallback onFacebook;
  final VoidCallback onInstagram;
  final VoidCallback onTiktok;

  const FollowColumn({
    super.key,
    required this.onFacebook,
    required this.onInstagram,
    required this.onTiktok,
  });

  @override
  Widget build(BuildContext context) {
    final uiScale = UiScale.factor(context);

    Widget social(IconData icon, VoidCallback cb) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: cb,
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: EdgeInsets.all(4 * uiScale),
            child: Icon(icon, size: 22 * uiScale, color: UiColors.gold),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const RainbowText(
          'FOLLOW',
          allCaps: true,
          firstCapsOnly: false,
          fontSize: 13.5,
          weight: FontWeight.w900,
          letterSpacing: 2.0,
        ),
        SizedBox(height: 10 * uiScale),
        social(Icons.facebook, onFacebook),
        SizedBox(height: 10 * uiScale),
        social(Icons.camera_alt_outlined, onInstagram),
        SizedBox(height: 10 * uiScale),
        social(Icons.play_circle_outline, onTiktok),
      ],
    );
  }
}

class RainbowParagraph extends StatelessWidget {
  final String text;
  final double fontSize;
  final double height;
  final FontWeight weight;

  const RainbowParagraph(
    this.text, {
    super.key,
    this.fontSize = 14.5,
    this.height = 1.35,
    this.weight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return RainbowText(
      text,
      fontSize: fontSize,
      weight: weight,
      firstCapsOnly: false,
      allCaps: false,
      letterSpacing: 0.1,
    );
  }
}

class LuxurySeam extends StatelessWidget {
  final bool vertical;

  const LuxurySeam({
    super.key,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    final uiScale = UiScale.factor(context);
    final border = (1.0 * uiScale).clamp(0.8, 1.6);

    final gradient = vertical
        ? const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x10000000),
              Color(0x44D4AF37),
              Color(0x10D4AF37),
              Color(0x22000000),
            ],
            stops: [0.0, 0.22, 0.75, 1.0],
          )
        : const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0x12000000),
              Color(0x44D4AF37),
              Color(0x10D4AF37),
              Color(0x22000000),
            ],
            stops: [0.0, 0.22, 0.75, 1.0],
          );

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        border: Border(
          top: BorderSide(
              color: const Color(0x55D4AF37), width: vertical ? 0 : border),
          bottom: BorderSide(
              color: const Color(0x33000000), width: vertical ? 0 : border),
          left: BorderSide(
              color: const Color(0x55D4AF37), width: vertical ? border : 0),
          right: BorderSide(
              color: const Color(0x33000000), width: vertical ? border : 0),
        ),
      ),
    );
  }
}
