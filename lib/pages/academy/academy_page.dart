import 'package:flutter/material.dart';
import '../../core/app_config.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import '../../content/page_texts.dart';
import 'academy_level_page.dart';
import 'professional_course_page.dart';
import 'course_detail_page.dart';
import '../../core/section_card.dart';

class AcademyPage extends StatelessWidget {
  const AcademyPage({super.key});

  void _go(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgAcademyHub,
      title: 'Academy',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // INTRO
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText(
                  'Academy',
                  fontSize: 16,
                  weight: FontWeight.w900,
                  firstCapsOnly: false,
                  headingStyle: true,
                ),
                SizedBox(height: 10),
                RainbowParagraph(PageTexts.academyIntro),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // LEVELS
          GoldWordButton(
            icon: Icons.looks_one,
            label: 'Level 1 – beginners program',
            onTap: () => _go(context, const AcademyLevelPage(level: 1)),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.looks_two,
            label: 'Level 2 – advanced training',
            onTap: () => _go(context, const AcademyLevelPage(level: 2)),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.looks_3,
            label: 'Level 3 – master program',
            onTap: () => _go(context, const AcademyLevelPage(level: 3)),
          ),
          const SizedBox(height: 14),

          // PACKAGES (detail pages)
          GoldWordButton(
            icon: Icons.all_inclusive,
            label: 'Complete professional package (1 + 2 + 3)',
            onTap: () => _go(
              context,
              CourseDetailPage(
                backgroundAsset: AppAssets.bgPackage123,
                title: 'Complete professional package',
                subtitle: 'Level 1 + 2 + 3',
                duration: '1 year',
                investment: '£8,000',
                body:
                    'The full professional journey from beginner to master. Ideal for future salon owners and elite stylists.\n\n'
                    'This package is designed as a true progression: foundation, refinement and mastery. '
                    'You graduate with a clear technical standard, a repeatable method and the confidence to deliver premium salon results under pressure.',
              ),
            ),
          ),
          const SizedBox(height: 10),

          GoldWordButton(
            icon: Icons.bolt,
            label: 'Fast-track package (Level 1 + 2)',
            onTap: () => _go(
              context,
              CourseDetailPage(
                backgroundAsset: AppAssets.bgPackage12,
                title: 'Level 1 + 2 package',
                subtitle: 'Fast-track professional qualification',
                duration: '8 months',
                investment: '£5,000',
                body:
                    'A fast-track route for motivated students who want strong foundations plus advanced technique quickly.\n\n'
                    'Perfect if you want a structured plan, real salon discipline and a premium standard that looks clean in daylight, flash and real life.',
              ),
            ),
          ),

          const SizedBox(height: 14),

          // PROFESSIONAL COURSES
          GoldWordButton(
            icon: Icons.workspace_premium,
            label: 'Professional courses',
            onTap: () => _go(context, const ProfessionalCoursePage()),
          ),

          const SizedBox(height: 18),
          GoldWordButton(
            icon: Icons.chat_bubble_outline,
            label: 'Book Now',
            onTap: () => openUrl(AppLinks.whatsappBooking),
          ),
        ],
      ),
    );
  }
}