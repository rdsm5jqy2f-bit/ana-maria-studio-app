import 'package:flutter/material.dart';

import '../../core/app_config.dart';
import '../../core/ui_widgets.dart';
import '../../core/section_card.dart';
import '../../section_page.dart';
import 'cv_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgAbout,
      title: 'About',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: RainbowParagraph('''There are careers chosen by logic, and there are callings that begin before memory.

Ana Maria’s journey into hairdressing started at the age of five. What began as childhood instinct became discipline, precision and a lifelong commitment to excellence.

She entered professional training with top results, started working in a salon at a very young age, and built her foundation through real service work, consistency and technical repetition.

Her dedication led to advanced international education at Vidal Sassoon, where she completed intensive training with outstanding results and continued her development in academy environments across Europe.

By 21, she was already teaching. Shortly after, she advanced to leadership and academy management, training teams, mentoring students, and representing professional education through live work, competitions and technical showcases.'''),
          ),
          const SizedBox(height: 14),
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('Career highlights', fontSize: 15.5, weight: FontWeight.w900, headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph(
                  '• International education in precision cutting, colour and styling\n'
                  '• Academy educator, supervisor and manager roles\n'
                  '• 148 national and international hairstyling competitions\n'
                  '• Advanced specialisation in balayage, AirTouch and colour correction\n'
                  '• Founder of Ana Maria Hair Studio in London\n'
                  '• Ongoing development of Ana Maria Studio & Academy',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('Philosophy', fontSize: 15.5, weight: FontWeight.w900, headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph(
                  'For Ana Maria, hair is architecture: shape, colour harmony and movement designed for the real person, not for a generic trend.\n\n'
                  'Each transformation starts with diagnosis of face structure, skin tone, density, porosity, history and lifestyle, then a tailored strategy is built with hair integrity first.\n\n'
                  '“For me, hairstyling is not only a profession. It is discipline, structure and the power to realign how a woman sees herself.”',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GoldWordButton(
            label: 'CV',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CvPage()),
            ),
          ),
        ],
      ),
    );
  }
}
