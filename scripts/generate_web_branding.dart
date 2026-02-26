import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;

class _BannerSpec {
  final String source;
  final String target;
  final int targetWidth;

  const _BannerSpec({
    required this.source,
    required this.target,
    required this.targetWidth,
  });
}

int _clampInt(num v) => v.clamp(0, 255).round();

int _screen(int base, int over) {
  return 255 - (((255 - base) * (255 - over)) ~/ 255);
}

void _applyHorizontalVignette(img.Image image) {
  final centerX = (image.width - 1) / 2.0;
  final half = centerX <= 0 ? 1.0 : centerX;

  for (var y = 0; y < image.height; y++) {
    for (var x = 0; x < image.width; x++) {
      final p = image.getPixel(x, y);
      final nx = ((x - centerX).abs() / half).clamp(0.0, 1.0);
      final darken = 0.18 + (0.34 * math.pow(nx, 1.35));
      final keep = 1.0 - darken;

      image.setPixelRgba(
        x,
        y,
        _clampInt(p.r * keep),
        _clampInt(p.g * keep),
        _clampInt(p.b * keep),
        p.a,
      );
    }
  }
}

void _screenBlendWithEdgeOpacity({
  required img.Image base,
  required img.Image glow,
  required double maxOpacity,
}) {
  final centerX = (base.width - 1) / 2.0;
  final half = centerX <= 0 ? 1.0 : centerX;

  for (var y = 0; y < base.height; y++) {
    for (var x = 0; x < base.width; x++) {
      final b = base.getPixel(x, y);
      final g = glow.getPixel(x, y);

      final nx = ((x - centerX).abs() / half).clamp(0.0, 1.0);
      final edgeOpacity = (0.20 + 0.80 * math.pow(nx, 1.15)).toDouble();
      final opacity = (maxOpacity * edgeOpacity).clamp(0.0, 1.0);

      final sr = _screen(b.r.toInt(), g.r.toInt());
      final sg = _screen(b.g.toInt(), g.g.toInt());
      final sb = _screen(b.b.toInt(), g.b.toInt());

      final r = _clampInt((b.r * (1 - opacity)) + (sr * opacity));
      final gg = _clampInt((b.g * (1 - opacity)) + (sg * opacity));
      final bb = _clampInt((b.b * (1 - opacity)) + (sb * opacity));

      base.setPixelRgba(x, y, r, gg, bb, 255);
    }
  }
}

void _generateWebBanner(_BannerSpec spec) {
  final sourceFile = File(spec.source);
  if (!sourceFile.existsSync()) {
    stderr.writeln('Missing source: ${spec.source}');
    return;
  }

  final bytes = sourceFile.readAsBytesSync();
  final src = img.decodeImage(bytes);
  if (src == null) {
    stderr.writeln('Cannot decode: ${spec.source}');
    return;
  }

  final targetHeight = src.height;
  final clear = img.copyResize(
    src,
    height: targetHeight,
    interpolation: img.Interpolation.cubic,
  );

  final stretched = img.copyResize(
    src,
    width: spec.targetWidth,
    height: targetHeight,
    interpolation: img.Interpolation.cubic,
  );

  final glow = img.gaussianBlur(img.Image.from(stretched), radius: 30);

  final base = img.Image.from(stretched);
  _applyHorizontalVignette(base);

  _screenBlendWithEdgeOpacity(base: base, glow: glow, maxOpacity: 0.60);

  final clearX = ((spec.targetWidth - clear.width) / 2).round();
  img.compositeImage(base, clear, dstX: clearX, dstY: 0, blend: img.BlendMode.direct);

  final outFile = File(spec.target);
  outFile.parent.createSync(recursive: true);
  outFile.writeAsBytesSync(img.encodePng(base, level: 6));

  stdout.writeln('Generated ${spec.target} => ${base.width}x${base.height}');
}

void main() {
  const specs = <_BannerSpec>[
    _BannerSpec(
      source: 'assets/images/branding/redlayer.png',
      target: 'assets/images/branding/redlayer_web.png',
      targetWidth: 3440,
    ),
    _BannerSpec(
      source: 'assets/images/branding/bluelayer.png',
      target: 'assets/images/branding/bluelayer_web.png',
      targetWidth: 3440,
    ),
    _BannerSpec(
      source: 'assets/images/branding/greenlayer.png',
      target: 'assets/images/branding/greenlayer_web.png',
      targetWidth: 3440,
    ),
    _BannerSpec(
      source: 'assets/images/branding/pinklayer.png',
      target: 'assets/images/branding/pinklayer_web.png',
      targetWidth: 3440,
    ),
  ];

  for (final spec in specs) {
    _generateWebBanner(spec);
  }
}
