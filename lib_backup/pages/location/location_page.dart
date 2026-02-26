import 'package:flutter/material.dart';

import '../../core/app_config.dart';
import '../../core/ui_widgets.dart';
import '../../core/section_card.dart';
import '../../section_page.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgLocation,
      title: 'Location',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowParagraph(AppLinks.address),
                SizedBox(height: 14),
                RainbowParagraph('''Located in Leytonstone, just minutes from Stratford and the heart of East London, the studio is easy to reach by tube, bus and car.
Ana Maria Studio & Academy is a rare salon plus academy space in one, so every service comes with an educator’s mindset: technique, hair health and longevity come first.

If you want colour that looks expensive and still feels healthy, this is the difference: we protect the hair first, then build the result.

If you are coming from central London, Stratford, Walthamstow or beyond, we can help you plan the best timing and the right service for your goal.'''),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GoldWordButton(
            icon: Icons.map_outlined,
            label: 'Open in Google Maps',
            onTap: () => openUrl(AppLinks.googleMapsQuery),
          ),
          const SizedBox(height: 14),
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('Opening hours', fontSize: 15.5, weight: FontWeight.w900, headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph(
                  'Mon–Sat 09:00–18:00\nSun 10:00–14:00\n\nIf you need a specific time window, message us on WhatsApp and we will do our best to help.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
