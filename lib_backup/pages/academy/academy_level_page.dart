import 'package:flutter/material.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../core/app_config.dart';
import '../../core/section_card.dart';

class AcademyLevelPage extends StatelessWidget {
  final int level;
  const AcademyLevelPage({super.key, required this.level});

  static const String _certification =
      'CERTIFICATION\n\nAll diplomas are internationally accredited and recognised worldwide, allowing graduates to work across Europe and internationally.';

  @override
  Widget build(BuildContext context) {
    final data = _data(level);

    return SectionPage(
      backgroundAsset: (level==1?AppAssets.bgLevel1:level==2?AppAssets.bgLevel2:AppAssets.bgLevel3),
      title: data.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  data.subtitle,
                  fontSize: 15.5,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                const SizedBox(height: 10),
                RainbowParagraph('Duration: ${data.duration}'),
                RainbowParagraph('Investment: ${data.investment}'),
                const SizedBox(height: 12),
                RainbowParagraph(data.body),
              ],
            ),
          ),
          const SizedBox(height: 14),

          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RainbowParagraph('You will build strong foundations in:'),
                const SizedBox(height: 8),
                ...data.bullets.map((b) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: RainbowParagraph('• $b'),
                    )),
              ],
            ),
          ),

          const SizedBox(height: 16),

          GoldWordButton(
            icon: Icons.chat_bubble_outline,
            label: 'Enrol / ask on WhatsApp',
            onTap: () => openUrl(AppLinks.whatsappBooking),
          ),

          const SizedBox(height: 16),

          const SectionCard(
            child: RainbowParagraph(_certification),
          ),
        ],
      ),
    );
  }

  _AcademyData _data(int lvl) {
    switch (lvl) {
      case 1:
        return const _AcademyData(
          title: 'Level 1',
          subtitle: 'Beginners program',
          duration: '6–8 months',
          investment: '£5,000',
          body:
              'Designed for students with no previous experience.\n\n'
              'This level is built to create discipline, clean sectioning and professional habits. '
              'You will learn how to consult correctly, execute safely and build results that look premium, not improvised.',
          bullets: [
            'Hair structure and professional consultation',
            'Core cutting techniques',
            'Colour fundamentals and product knowledge',
            'Styling and blow-dry techniques',
            'Client communication and salon professionalism',
          ],
        );
      case 2:
        return const _AcademyData(
          title: 'Level 2',
          subtitle: 'Advanced training',
          duration: '3–4 months',
          investment: '£3,500',
          body:
              'Created for stylists with basic knowledge who want to refine and elevate their work.\n\n'
              'We focus on control, speed with precision, and modern finishing. '
              'You learn to repeat results consistently and confidently, with a high-end standard.',
          bullets: [
            'Advanced colouring systems',
            'Balayage, AirTouch and modern techniques',
            'Precision cutting refinement',
            'Professional styling and finish',
          ],
        );
      default:
        return const _AcademyData(
          title: 'Level 3',
          subtitle: 'Master program',
          duration: '3–4 months',
          investment: '£4,000',
          body:
              'For advanced stylists aiming to reach elite professional standards.\n\n'
              'This is where you learn the “why”: decision-making, correction strategy and luxury transformation planning. '
              'We also shape professional identity, branding and client retention mindset.',
          bullets: [
            'High-level colour correction',
            'Luxury hair transformations',
            'Advanced salon methodology',
            'Branding, client retention and business mindset',
          ],
        );
    }
  }
}

class _AcademyData {
  final String title;
  final String subtitle;
  final String duration;
  final String investment;
  final String body;
  final List<String> bullets;

  const _AcademyData({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.investment,
    required this.body,
    required this.bullets,
  });
}