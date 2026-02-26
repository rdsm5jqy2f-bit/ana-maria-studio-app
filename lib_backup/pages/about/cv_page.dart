import 'package:flutter/material.dart';

import '../../core/app_config.dart';
import '../../core/section_card.dart';
import '../../core/ui_widgets.dart';
import '../../section_page.dart';

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgAbout,
      title: 'Professional CV',
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('Ana Maria', fontSize: 16, weight: FontWeight.w900, headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph('Master Hairstylist | Educator | Academy Director'),
              ],
            ),
          ),
          SizedBox(height: 14),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('Certification', fontSize: 15.5, weight: FontWeight.w900, headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph(
                  'Internationally accredited diplomas recognised worldwide, enabling professional practice across Europe and international markets.',
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('Professional education', fontSize: 15.5, weight: FontWeight.w900, headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph(
                  '1998–2000 — Vidal Sassoon Academy, France\n'
                  '• Full professional training across all five levels: Cutting, Colour, Styling, Leadership, Education\n'
                  '• Specialisation in editorial styling and avant-garde haircutting\n\n'
                  '1994–1998 — Cosmetology & Hairdressing High School, Bucharest\n'
                  '• Professional foundational training\n'
                  '• Junior hairstylist practice at Igiena State Salon',
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('Professional experience', fontSize: 15.5, weight: FontWeight.w900, headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph(
                  'Founder & Master Hairstylist — Ana Maria Hair Studio, London, UK (2012–Present)\n'
                  '• Founder of a premium London-based salon\n'
                  '• Personalised image consultancy and transformation services\n'
                  '• Stylist training and team coordination\n'
                  '• Participation in international hairstyling events and artistic collaborations\n\n'
                  'Academy Manager & Educator — Vidal Sassoon Academy, Pistoia, Italy (2002–2010)\n'
                  '• Academy management and leadership of technical teams\n'
                  '• International educator in cutting, colour and styling\n'
                  '• Development of personal collections and live demonstrations\n'
                  '• Participation in national and international competitions\n\n'
                  'Hairstylist & Assistant Educator — Vidal Sassoon, France (2000–2002)\n'
                  '• Advanced academy training environment\n'
                  '• Assistant for masterclasses and stage demonstrations\n'
                  '• Editorial and technical styling involvement\n\n'
                  'Junior Hairstylist — Igiena Salon, Bucharest (1994–1998)\n'
                  '• Early salon experience during academic training\n'
                  '• Client services including washing, cutting assistance and colouring support',
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('Achievements', fontSize: 15.5, weight: FontWeight.w900, headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph(
                  '• Participation in 148 national and international hairstyling competitions\n'
                  '• Awards in precision cutting, runway styling and complex colour correction\n'
                  '• Guest stylist for live shows and demonstrations in Italy, France and the UK\n'
                  '• Hairstyles featured in fashion editorials and beauty publications',
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('Specialisations', fontSize: 15.5, weight: FontWeight.w900, headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph(
                  '• Classic and avant-garde haircutting (bob, pixie, shag, geometric structures)\n'
                  '• Advanced colour techniques: balayage, AirTouch, complex colour correction\n'
                  '• Bridal and runway styling\n'
                  '• Professional education and leadership\n'
                  '• Salon development and entrepreneurship',
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RainbowText('Languages', fontSize: 15.5, weight: FontWeight.w900, headingStyle: true),
                SizedBox(height: 8),
                RainbowParagraph(
                  '• Romanian — Native\n'
                  '• Italian — Fluent\n'
                  '• French — Advanced\n'
                  '• English — Advanced',
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
