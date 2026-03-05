import 'package:flutter/material.dart';

import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../core/app_config.dart';
import '../../core/section_card.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgContact,
      title: 'Contact',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child:
                RainbowParagraph('''For fast, accurate quotes we use WhatsApp.
Send clear photos in natural light (front + back) and a short note about your hair history and goal.
We reply as quickly as possible with guidance, timing and a “starting from” estimate.

Prefer to speak? Call the studio and we can advise the best next step.'''),
          ),
          const SizedBox(height: 14),
          GoldWordButton(
            icon: Icons.chat_bubble_outline,
            label: 'Book Now',
            onTap: () => openUrl(AppLinks.whatsappBooking),
          ),
          const SizedBox(height: 8),
          GoldWordButton(
            icon: Icons.photo_camera_outlined,
            label: 'Quick quote (send photos)',
            onTap: () => openUrl(AppLinks.whatsappQuote),
          ),
          const SizedBox(height: 8),
          GoldWordButton(
            icon: Icons.call_outlined,
            label: 'Call',
            onTap: () => openUrl(AppLinks.phoneCall),
          ),
          const SizedBox(height: 14),
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('Google reviews',
                    fontSize: 15.5,
                    weight: FontWeight.w900,
                    headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph(
                  'If you enjoyed your visit, a recent Google review helps more local clients discover Ana Maria Studio & Academy as a trusted Hair Salon in Leytonstone London E11.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GoldWordButton(
            icon: Icons.star_outline,
            label: 'Leave a Google review',
            onTap: () => openUrl(AppLinks.googleReview),
          ),
          const SizedBox(height: 14),
          const RainbowText('Social',
              fontSize: 15.5, weight: FontWeight.w900, headingStyle: true),
          const SizedBox(height: 10),
          GoldWordButton(
            icon: Icons.facebook,
            label: 'Facebook',
            onTap: () => openUrl(AppLinks.facebook),
          ),
          const SizedBox(height: 8),
          GoldWordButton(
            icon: Icons.camera_alt_outlined,
            label: 'Instagram',
            onTap: () => openUrl(AppLinks.instagram),
          ),
          const SizedBox(height: 8),
          GoldWordButton(
            icon: Icons.play_circle_outline,
            label: 'TikTok',
            onTap: () => openUrl(AppLinks.tiktok),
          ),
        ],
      ),
    );
  }
}
