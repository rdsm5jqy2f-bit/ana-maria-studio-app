import 'package:flutter/material.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../core/app_config.dart';
import '../../core/section_card.dart';

class CourseDetailPage extends StatelessWidget {
  final String title;
  final String? backgroundAsset;
  final String? subtitle;
  final String? duration;
  final String? investment;
  final List<String>? bullets;
  final String body;

  // Optional: add certification at bottom (you pass it from Academy pages)
  final String? footerCertification;

  const CourseDetailPage({
    super.key,
    required this.title,
    required this.body,
    this.backgroundAsset,
    this.subtitle,
    this.duration,
    this.investment,
    this.bullets,
    this.footerCertification,
  });

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: backgroundAsset ?? AppAssets.bgCourseColour,
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((subtitle != null && subtitle!.trim().isNotEmpty) ||
              (duration != null && duration!.trim().isNotEmpty) ||
              (investment != null && investment!.trim().isNotEmpty))
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                    RainbowText(
                      subtitle!,
                      fontSize: 15.5,
                      weight: FontWeight.w900,
                      firstCapsOnly: false,
                      headingStyle: true,
                    ),
                    const SizedBox(height: 10),
                  ],
                  if (duration != null && duration!.trim().isNotEmpty)
                    RainbowParagraph('Duration: $duration'),
                  if (investment != null && investment!.trim().isNotEmpty)
                    RainbowParagraph('Investment: $investment'),
                ],
              ),
            ),

          if ((subtitle != null && subtitle!.trim().isNotEmpty) ||
              (duration != null && duration!.trim().isNotEmpty) ||
              (investment != null && investment!.trim().isNotEmpty))
            const SizedBox(height: 12),

          SectionCard(
            child: RainbowParagraph(body),
          ),

          if (bullets != null && bullets!.isNotEmpty) ...[
            const SizedBox(height: 14),
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const RainbowText(
                    'Focus areas',
                    fontSize: 14.5,
                    weight: FontWeight.w900,
                    firstCapsOnly: false,
                    headingStyle: true,
                  ),
                  const SizedBox(height: 8),
                  ...bullets!.map(
                    (b) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: RainbowParagraph('• $b'),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 16),

          GoldWordButton(
            icon: Icons.chat_bubble_outline,
            label: 'Book / ask on WhatsApp',
            onTap: () => openUrl(AppLinks.whatsappBooking),
          ),

          if (footerCertification != null && footerCertification!.trim().isNotEmpty) ...[
            const SizedBox(height: 16),
            SectionCard(
              child: RainbowParagraph(footerCertification!),
            ),
          ],
        ],
      ),
    );
  }
}