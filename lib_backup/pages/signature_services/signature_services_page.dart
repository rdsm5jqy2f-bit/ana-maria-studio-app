// lib/pages/signature_services/signature_services_page.dart
import 'package:flutter/material.dart';

import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../core/app_config.dart';
import '../../core/section_card.dart';

import 'signature_services_texts.dart';
import 'service_detail_page.dart';
import 'colour_signature_page.dart';
import 'cutting_styling_page.dart';
import 'signature_transformation_page.dart';

class SignatureServicesPage extends StatelessWidget {
  const SignatureServicesPage({super.key});

  void _go(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  void _openDetail(BuildContext context, ServiceDetail detail) {
    _go(context, ServiceDetailPage(detail: detail));
  }

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgSignatureHub,
      title: 'Signature services',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMPORTANT:
          // If RainbowParagraph does NOT have a const constructor in your project,
          // remove "const" here.
          const SectionCard(
            child: RainbowParagraph(SignatureTexts.introBody),
          ),
          const SizedBox(height: 16),

          GoldWordButton(
            icon: Icons.palette_outlined,
            label: 'Colour signature',
            onTap: () => _go(context, const ColourSignaturePage()),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.content_cut,
            label: 'Cutting & styling',
            onTap: () => _go(context, const CuttingStylingPage()),
          ),

          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.auto_fix_high,
            label: 'Signature transformation',
            onTap: () => _go(context, const SignatureTransformationPage()),
          ),

          GoldWordButton(
            icon: Icons.auto_awesome,
            label: 'Hair therapy',
            onTap: () => _openDetail(
              context,
              const ServiceDetail(
                title: SignatureTexts.therapyTitle,
                fromPrice: SignatureTexts.therapyItemFrom,
                body: SignatureTexts.therapyBody,
              ),
            ),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.extension,
            label: 'Hair extensions',
            onTap: () => _openDetail(
              context,
              const ServiceDetail(
                title: SignatureTexts.extensionsTitle,
                fromPrice: SignatureTexts.extensionsItemFrom,
                body: SignatureTexts.extensionsBody,
              ),
            ),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.favorite_border,
            label: 'Bridal & special events',
            onTap: () => _openDetail(
              context,
              const ServiceDetail(
                title: SignatureTexts.bridalTitle,
                fromPrice: SignatureTexts.bridalFrom,
                body: SignatureTexts.bridalBody,
              ),
            ),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.chat_bubble_outline,
            label: 'Consultation (service page)',
            onTap: () => _openDetail(
              context,
              const ServiceDetail(
                title: SignatureTexts.consultServiceTitle,
                fromPrice: SignatureTexts.consultServiceFrom,
                body: SignatureTexts.consultServiceBody,
              ),
            ),
          ),
          const SizedBox(height: 18),

          GoldWordButton(
            icon: Icons.chat,
            label: 'Book Now',
            onTap: () => openUrl(AppLinks.whatsappBooking),
          ),
        ],
      ),
    );
  }
}
