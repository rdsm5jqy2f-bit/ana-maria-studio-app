import 'package:flutter/material.dart';
import '../../core/app_config.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import 'service_detail_page.dart';
import '../../core/section_card.dart';

class HairExtensionsPage extends StatelessWidget {
  const HairExtensionsPage({super.key});

  void _open(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ServiceDetailPage(
          detail: ServiceDetail(
            title: 'Hair extensions',
            fromPrice: '£180',
            body:
                'Professional application using premium methods: Nano Rings, Micro Rings, Tape-In and Keratin Bond systems.\n\n'
                'A consultation is required to select the safest method, correct length, colour match and maintenance plan. '
                'We prioritise comfort, discretion and a blend that looks natural under daylight and flash.\n\n'
                'If you are unsure which method fits your hair, send photos on WhatsApp and we will guide you.',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      title: 'Hair extensions',
      backgroundAsset: AppAssets.bgHairExtensions,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  'Length. Density. Seamless blend.',
                  fontSize: 14.5,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                SizedBox(height: 10),
                RainbowParagraph(
                  'Extensions are not just “more hair”. The method, tension and placement must protect your natural hair and look invisible.\n\n'
                  'Open the details and book your consultation on WhatsApp.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GoldWordButton(
            icon: Icons.extension,
            label: 'Hair extensions (starting from £180)',
            onTap: () => _open(context),
          ),
        ],
      ),
    );
  }
}