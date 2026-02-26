import 'package:flutter/material.dart';

import '../../section_page.dart';
import '../../core/app_config.dart';
import '../../core/ui_widgets.dart';
import '../../core/section_card.dart';

import '../gallery/gallery_grid_page.dart';

class SignatureTransformationPage extends StatelessWidget {
  const SignatureTransformationPage({super.key});

  void _go(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgSignatureTransformation,
      title: 'Signature transformation',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: RainbowParagraph(
              'A transformation is not “just colour”. It is a full plan: face shape, skin tone, lifestyle, hair health and the way it grows out.\n\n'
              'Leave the strategy to Ana Maria. She will assess your hair history, strength and porosity, then design the best placement, tone and finish for you.\n\n'
              'This is a premium, bespoke service. Your final price is confirmed after consultation and photo review, so the result is honest, safe and high-end.',
            ),
          ),
          const SizedBox(height: 14),

          GoldWordButton(
            icon: Icons.auto_awesome,
            label: 'Inspiration',
            onTap: () => _go(
              context,
              const GalleryGridPage(
                folder: 'inspiration',
                title: 'Inspiration',
              ),
            ),
          ),
          const SizedBox(height: 10),

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
