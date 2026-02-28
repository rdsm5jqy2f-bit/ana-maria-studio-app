import 'package:flutter/material.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../core/app_config.dart';
import '../../core/section_card.dart';

class ServiceDetail {
  final String title;
  final String fromPrice;
  final String body;
  final String? backgroundAsset;

  const ServiceDetail({
    required this.title,
    required this.fromPrice,
    required this.body,
    this.backgroundAsset,
  });
}

class ServiceDetailPage extends StatelessWidget {
  final ServiceDetail detail;

  const ServiceDetailPage({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: detail.backgroundAsset ?? AppAssets.bgServiceDetail,
      title: detail.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GoldPillLabel(
            'Starting from ${detail.fromPrice}',
          ),
          const SizedBox(height: 10),
          SectionCard(
            child: RainbowParagraph(detail.body),
          ),
          const SizedBox(height: 14),
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
