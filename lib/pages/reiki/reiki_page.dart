import 'package:flutter/material.dart';

import '../../core/app_config.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../core/section_card.dart';

class ReikiPage extends StatelessWidget {
  const ReikiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgReiki,
      title: 'Reiki',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: RainbowParagraph('''Reiki is a quiet kind of luxury: a gentle reset for the nervous system, designed to leave you lighter, calmer and more present.

Many clients describe:
• deeper relaxation and stress release
• a softer, clearer mind
• better sleep and recovery
• a sense of balance returning to the body

Ana Maria integrates Reiki as part of a holistic beauty philosophy. Years of close work with clients showed that emotional stress often appears in the hair and scalp before people can name it.

The approach is simple and respectful: no pressure, no performance, only presence and care. Reiki supports emotional grounding during image change and helps clients feel aligned from the inside out.

Reiki can be added to any hair appointment, or booked as a standalone session. If you are curious, we will guide you on timing, length and how it can fit naturally into your visit.'''),
          ),
          const SizedBox(height: 14),
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('How we use it', fontSize: 15.5, weight: FontWeight.w900, headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph(
                  '• before major colour corrections or transformations\n'
                  '• during periods of stress, fatigue or emotional overload\n'
                  '• as a calming add-on to support confidence and inner balance\n\n'
                  'Reiki does not replace technical expertise. It complements it, creating a full transformation experience that is both visible and deeply felt.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GoldWordButton(
            label: 'Find out on WhatsApp',
            onTap: () => openUrl(AppLinks.whatsappBooking),
          ),
        ],
      ),
    );
  }
}
