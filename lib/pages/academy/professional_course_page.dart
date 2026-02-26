import 'package:flutter/material.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../core/app_config.dart';
import 'course_detail_page.dart';
import '../../core/section_card.dart';

class ProfessionalCoursePage extends StatelessWidget {
  const ProfessionalCoursePage({super.key});

  static const String _certification =
      'CERTIFICATION\n\nAll diplomas are internationally accredited and recognised worldwide, allowing graduates to work across Europe and internationally.';

  void _go(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgProCoursesHub,
      title: 'Professional courses',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  'Advanced training for working stylists',
                  fontSize: 15.5,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                SizedBox(height: 10),
                RainbowParagraph(
                  'Built to sharpen technique, upgrade colour and finishing, and build speed with control.\n\n'
                  'These courses are designed for stylists who want a stronger standard: consultation, precision and results that protect hair integrity.',
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          GoldWordButton(
            icon: Icons.palette_outlined,
            label: 'Colour specialisation course',
            onTap: () => _go(
              context,
              CourseDetailPage(
                backgroundAsset: AppAssets.bgCourseColour,
                title: 'Colour specialisation course',
                subtitle: 'For professional stylists',
                duration: '1 month',
                investment: '£1,500 – £3,000',
                bullets: [
                  'Complex colour correction',
                  'Balayage and AirTouch mastery',
                  'Blonde systems and toning',
                  'Modern colour formulation',
                ],
                body:
                    'Advanced colour training focused on clean correction strategy, premium blonding and modern formulas. '
                    'You will learn to diagnose hair history fast, choose safe steps, and deliver results that look expensive and grow out beautifully.',
                footerCertification: _certification,
              ),
            ),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.content_cut,
            label: 'Cutting & styling specialisation',
            onTap: () => _go(
              context,
              CourseDetailPage(
                backgroundAsset: AppAssets.bgCourseCutStyle,
                title: 'Cutting & styling specialisation',
                subtitle: 'Upgrade finishing and shape',
                duration: '1 month',
                investment: '£1,500',
                bullets: [
                  'Precision haircuts',
                  'Advanced styling techniques',
                  'Editorial and high-finish salon looks',
                ],
                body:
                    'Designed for stylists who want sharper lines, stronger shape control and a more premium finish. '
                    'We work on structure, balance, weight placement and clean blow-dry or styled outcomes.',
                footerCertification: _certification,
              ),
            ),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.speed,
            label: 'Professional upgrade course',
            onTap: () => _go(
              context,
              CourseDetailPage(
                backgroundAsset: AppAssets.bgCourseUpgrade,
                title: 'Professional upgrade course',
                subtitle: 'For experienced stylists',
                duration: '3 days',
                investment: '£500',
                bullets: [
                  'Technical precision',
                  'Client communication',
                  'Salon efficiency',
                  'Speed and confidence',
                ],
                body:
                    'Short, intensive upgrade focused on clean technique and real-salon performance. '
                    'Perfect if you want to work faster without losing control and communicate like a high-end professional.',
                footerCertification: _certification,
              ),
            ),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.extension,
            label: 'Hair extensions master course',
            onTap: () => _go(
              context,
              CourseDetailPage(
                backgroundAsset: AppAssets.bgCourseExtensions,
                title: 'Hair extensions master course',
                subtitle: 'Professional application methods',
                duration: '2 weeks',
                investment: '£1,500',
                bullets: [
                  'Nano rings',
                  'Micro rings',
                  'Tape-in',
                  'Nano keratin bonds',
                  'Micro keratin bonds',
                ],
                body:
                    'Training in professional application methods with a focus on clean placement, comfort, maintenance and natural blending. '
                    'You will learn method selection, safe removal, and client guidance for long-term results.',
                footerCertification: _certification,
              ),
            ),
          ),

          const SizedBox(height: 16),

          GoldWordButton(
            icon: Icons.chat_bubble_outline,
            label: 'Enrol / ask on WhatsApp',
            onTap: () => openUrl(AppLinks.whatsappBooking),
          ),
        ],
      ),
    );
  }
}