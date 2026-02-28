import 'package:flutter/material.dart';
import '../../core/app_config.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';

import 'service_detail_page.dart';
import '../../core/section_card.dart';

class CuttingStylingPage extends StatelessWidget {
  const CuttingStylingPage({super.key});

  void _open(BuildContext context, ServiceDetail detail) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ServiceDetailPage(detail: detail)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgCuttingStyling,
      title: 'Cutting & styling',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  'Shape first. Finish second.',
                  fontSize: 14.5,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                SizedBox(height: 10),
                RainbowParagraph(
                  'Cutting is structure and balance. Styling is control and polish. '
                  'We build shapes that sit beautifully, move well and are easy to maintain.\n\n'
                  'Tap a service to view details, then book on WhatsApp.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GoldWordButton(
            icon: Icons.content_cut,
            label: 'Haircut',
            onTap: () => _open(
              context,
              ServiceDetail(
                title: 'Haircut',
                fromPrice: '£30',
                backgroundAsset: AppAssets.bgHaircut,
                body:
                    'Precision cutting tailored to face shape, hair texture and lifestyle. '
                    'We focus on clean lines, balance and a shape that holds.\n\n'
                    'Includes consultation and finishing tips so your haircut behaves between visits.',
              ),
            ),
          ),
          const SizedBox(height: 10),
          GoldWordButton(
            icon: Icons.water_drop_outlined,
            label: 'Wash & blowdry',
            onTap: () => _open(
              context,
              ServiceDetail(
                title: 'Wash & blowdry',
                fromPrice: '£25',
                backgroundAsset: AppAssets.bgWashBlowdry,
                body:
                    'Luxury cleanse, scalp care and professional styling for a polished finish. '
                    'Smooth, voluminous, glossy and camera-ready.\n\n'
                    'Ideal before events, photos or whenever you want that “done properly” look.',
              ),
            ),
          ),
          const SizedBox(height: 10),
          GoldWordButton(
            icon: Icons.auto_awesome,
            label: 'Hair up / event styling',
            onTap: () => _open(
              context,
              ServiceDetail(
                title: 'Hair up / event styling',
                fromPrice: '£45',
                backgroundAsset: AppAssets.bgHairUpEventStyling,
                body:
                    'Elegant styling for weddings, events and special occasions. '
                    'We design a look that complements your outfit, face shape and the vibe of the day.\n\n'
                    'Built for comfort, longevity and beautiful photos from every angle.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
