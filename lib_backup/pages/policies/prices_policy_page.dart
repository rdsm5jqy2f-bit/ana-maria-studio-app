import 'package:flutter/material.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../core/app_config.dart';
import '../../core/section_card.dart';

class PricesPolicyPage extends StatelessWidget {
  const PricesPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgPolicies,
      title: 'Prices & policy',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  'Luxury pricing is always personalised.',
                  fontSize: 14,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                SizedBox(height: 10),
                RainbowParagraph(
                  'Prices are shown as “starting from” because hair history, density, length and the desired result can change the timing and product plan.\n\n'
                  'A professional consultation is always included so the result is premium and the hair integrity stays protected.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  'Booking & deposit',
                  fontSize: 16,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                SizedBox(height: 10),
                RainbowParagraph(
                  '• Booking is confirmed via WhatsApp.\n'
                  '• A 10% deposit is required for hair bookings.\n'
                  '• Quote-required services are handled via WhatsApp photos for accuracy.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  'Cancellation policy',
                  fontSize: 16,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                SizedBox(height: 10),
                RainbowParagraph(
                  '• Cancel 48h+ before: deposit can be refunded.\n'
                  '• Under 48h: deposit is non-refundable.\n\n'
                  'This protects time reserved exclusively for you and keeps the diary running fairly for all clients.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          GoldWordButton(
            icon: Icons.chat_bubble_outline,
            label: 'Book on WhatsApp',
            onTap: () => openUrl(AppLinks.whatsappBooking),
          ),
        ],
      ),
    );
  }
}