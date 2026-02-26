import 'package:flutter/material.dart';
import '../../core/app_config.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import 'service_detail_page.dart';
import '../../core/section_card.dart';

class HairTherapyPage extends StatelessWidget {
  const HairTherapyPage({super.key});

  void _open(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ServiceDetailPage(
          detail: ServiceDetail(
            title: 'Hair therapy',
            fromPrice: '£35',
            body:
                'Intensive repair and hydration treatment designed to restore strength, elasticity and shine.\n\n'
                'We choose the correct protocol based on your hair type and history: colour services, heat styling, dryness or breakage. '
                'This is the “reset button” that makes hair feel expensive again.\n\n'
                'Recommended as an add-on to colour services, or as a standalone visit for recovery and maintenance.',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      title: 'Hair therapy',
      backgroundAsset: AppAssets.bgHairTherapy,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  'Condition is the luxury.',
                  fontSize: 14.5,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                SizedBox(height: 10),
                RainbowParagraph(
                  'Healthy hair holds colour better, reflects light more beautifully and styles faster. '
                  'Treatments are chosen professionally, not randomly.\n\n'
                  'Open the details and book on WhatsApp.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GoldWordButton(
            icon: Icons.auto_awesome,
            label: 'Professional hair therapy (starting from £35)',
            onTap: () => _open(context),
          ),
        ],
      ),
    );
  }
}