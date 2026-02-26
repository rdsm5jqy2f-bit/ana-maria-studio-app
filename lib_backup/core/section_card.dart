import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';

class SectionCard extends StatelessWidget {
  final Widget child;
  final bool showBorder;

  const SectionCard({
    super.key,
    required this.child,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final maxCardWidth = kIsWeb ? 860.0 : double.infinity;

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxCardWidth),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.40),
                borderRadius: BorderRadius.circular(18),
                border: showBorder
                    ? Border.all(
                        color: const Color(0xFFD4AF37), // gold
                        width: 1.2,
                      )
                    : null,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
