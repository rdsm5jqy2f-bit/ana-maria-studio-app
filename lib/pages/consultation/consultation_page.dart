import 'package:flutter/material.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../core/app_config.dart';
import '../../core/section_card.dart';

class ConsultationPage extends StatelessWidget {
  const ConsultationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgFastConsult,
      title: 'Consultation',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: RainbowParagraph('For a fast quote:\n'
              'Send photos on WhatsApp (before), the service you want, and your expected result. '
              'We reply with a clear plan and a quote as soon as possible.\n\n'
              'For deeper transformations and colour correction, we recommend a full consultation booking.'),
          ),
          const SizedBox(height: 14),
          GoldWordButton(
            icon: Icons.chat_bubble_outline,
            label: 'Book Now',
            onTap: () => openUrl(AppLinks.whatsappBooking),
          ),
          const SizedBox(height: 8),
          GoldWordButton(
            icon: Icons.spa_outlined,
            label: 'Add Reiki to booking',
            onTap: () => openUrl(AppLinks.whatsappReikiAddOn),
          ),
        ],
      ),
    );
  }
}
