import 'package:flutter/material.dart';
import '../../core/app_config.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../core/section_card.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      title: 'Prices & policy',
      backgroundAsset: AppAssets.bgInfo,
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RainbowText(
                'Pricing philosophy',
                fontSize: 14.5,
                weight: FontWeight.w900,
                firstCapsOnly: false,
                headingStyle: true,
              ),
              SizedBox(height: 10),
              RainbowParagraph(
                'Prices are listed as “starting from” because hair length, density, condition and colour history affect the time and product required. '
                'We always recommend the safest plan for your hair and your goal.\n\n'
                'For fast, accurate quotes we use WhatsApp: send clear photos in natural light (front + back) and your hair history.',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RainbowText(
                'Deposits & cancellations',
                fontSize: 14.5,
                weight: FontWeight.w900,
                firstCapsOnly: false,
                headingStyle: true,
              ),
              SizedBox(height: 10),
              RainbowParagraph(
                '• A 10% deposit may be required to secure certain bookings.\n'
                '• Rescheduling or cancellation: refund available when notice is given at least 48 hours before the appointment.\n'
                '• Under 48 hours: deposit is non-refundable due to reserved time.\n\n'
                'We keep this policy to protect appointment time and ensure fair availability for all clients.',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RainbowText(
                'Opening hours',
                fontSize: 14.5,
                weight: FontWeight.w900,
                firstCapsOnly: false,
                headingStyle: true,
              ),
              SizedBox(height: 10),
              RainbowParagraph(
                'Mon–Sat: 09:00–18:00\n'
                'Sun: 10:00–14:00\n\n'
                'If you need a specific time window, message us on WhatsApp and we will do our best to help.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}