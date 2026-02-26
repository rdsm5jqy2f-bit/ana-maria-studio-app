import 'package:flutter/material.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../core/app_config.dart';
import '../../core/section_card.dart';

class ConsultationServicePage extends StatelessWidget {
  const ConsultationServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgConsultService,
      title: 'Consultation',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  'Consultation first. Always.',
                  fontSize: 14.5,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                SizedBox(height: 10),
                RainbowParagraph(
                  'All services include a personalised consultation assessing:\n'
                  '• Hair condition\n'
                  '• Colour history\n'
                  '• Desired result\n'
                  '• Maintenance plan\n\n'
                  'This ensures safe, professional and premium results.\n\n'
                  'Important note:\n'
                  'Prices may vary depending on hair length, thickness, condition and colour history. '
                  'A full consultation is required for an accurate quote.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GoldWordButton(
            icon: Icons.chat_bubble_outline,
            label: 'Book / get a quote on WhatsApp',
            onTap: () => openUrl('https://wa.me/447427216249'),

          ),
        ],
      ),
    );
  }
}