import 'package:flutter/material.dart';
import '../../core/app_config.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';

import 'service_detail_page.dart';
import '../../core/section_card.dart';

class ColourSignaturePage extends StatelessWidget {
  const ColourSignaturePage({super.key});

  void _open(BuildContext context, ServiceDetail detail) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ServiceDetailPage(detail: detail)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgColourSignature,
      title: 'Colour signature',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  'Light, dimension and control.',
                  fontSize: 14.5,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                SizedBox(height: 10),
                RainbowParagraph(
                  'Colour work is planned, not guessed. We map the light, protect the hair and create blends that grow out beautifully.\n\n'
                  'Tap a service to see details, then book directly on WhatsApp.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          GoldWordButton(
            icon: Icons.brush_outlined,
            label: 'Balayage',
            onTap: () => _open(
              context,
              const ServiceDetail(
                title: 'Balayage',
                fromPrice: '£180',
                body:
                    'A hand-painted highlighting technique designed to create soft, seamless dimension and natural light reflection. '
                    'Placement is fully personalised to your haircut, face shape and lifestyle, so the result looks expensive and effortless.\n\n'
                    'Expect luminous brightness with elegant grow-out and a finish that stays refined between visits.',
              ),
            ),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.air,
            label: 'AirTouch',
            onTap: () => _open(
              context,
              const ServiceDetail(
                title: 'AirTouch',
                fromPrice: '£180',
                body:
                    'A premium air-separation technique delivering ultra-soft blends and long-lasting brightness without harsh lines. '
                    'Ideal if you want a modern blonde with minimal regrowth visibility.\n\n'
                    'We tailor toning and treatment to keep the hair glossy, strong and wearable.',
              ),
            ),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.tune,
            label: 'Colour correction',
            onTap: () => _open(
              context,
              const ServiceDetail(
                title: 'Colour correction',
                fromPrice: '£180',
                body:
                    'A complex professional service designed to fix uneven tones, banding, unwanted warmth, patchy lightening or previous colour errors. '
                    'This is advanced work: we analyse, neutralise and rebuild tone while protecting hair integrity.\n\n'
                    'A photo consultation is required to plan the safest route to your goal.',
              ),
            ),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.color_lens_outlined,
            label: 'Full colour / roots',
            onTap: () => _open(
              context,
              const ServiceDetail(
                title: 'Full colour / roots',
                fromPrice: '£80',
                body:
                    'Professional colour application tailored to your hair history, scalp sensitivity and desired result. '
                    'We focus on clean saturation, balanced tone and long-lasting shine.\n\n'
                    'Perfect for refresh, grey coverage and rich, even colour that looks premium up close.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}