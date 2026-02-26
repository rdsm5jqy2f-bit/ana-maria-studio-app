import 'package:flutter/material.dart';
import '../../core/app_config.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import 'service_detail_page.dart';
import '../../core/section_card.dart';

class BridalPage extends StatelessWidget {
  const BridalPage({super.key});

  void _open(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ServiceDetailPage(
          detail: ServiceDetail(
            title: 'Bridal hair & luxury styling',
            fromPrice: ': Price on consultation',
            body:
                'Bespoke bridal styling designed around your dress, venue, hair type and the energy of your day.\n\n'
                'Packages can include: trial session, planning, timeline support and wedding-day styling. '
                'We build a look that is elegant, secure and photogenic from every angle, while still feeling comfortable.\n\n'
                'Book your consultation on WhatsApp and send a photo of your dress or inspiration.',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgBridal,
      title: 'Bridal & events',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  'Elegant. Secure. Photo-perfect.',
                  fontSize: 14.5,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                SizedBox(height: 10),
                RainbowParagraph(
                  'Luxury bridal work is planning, structure and calm execution. '
                  'We create a hairstyle that holds, looks refined and suits you.\n\n'
                  'Open the details and book on WhatsApp.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GoldWordButton(
            icon: Icons.favorite_border,
            label: 'Bridal hair & luxury styling (consultation)',
            onTap: () => _open(context),
          ),
        ],
      ),
    );
  }
}