import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../core/app_config.dart';
import '../core/ui_widgets.dart';
import '../pages/signature_services/signature_services_page.dart';
import '../pages/academy/academy_page.dart';
import '../pages/consultation/consultation_page.dart';
import '../pages/reiki/reiki_page.dart';
import '../pages/gallery/gallery_categories_page.dart';
import '../pages/location/location_page.dart';
import '../pages/contact/contact_page.dart';
import '../pages/about/about_page.dart';
import '../pages/policies/prices_policy_page.dart';
import '../section_page.dart';

class GreenLayer extends StatelessWidget {
  const GreenLayer({super.key});

  void _go(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWideWeb = kIsWeb && size.width >= 980;
    final uiScale = UiScale.factor(context);
    final rowGap = 15 * uiScale;
    final topPad = (kIsWeb ? 22 : 30) * uiScale;
    final bottomPad = 10 * uiScale;
    final footerBottom = 6 * uiScale;
    final footerPadH = 18 * uiScale;
    final footerPadV = 6 * uiScale;
    final footerBorder = 1 * uiScale;
    final primaryAsset = AppAssets.greenLayerBg;
    final alignment = LayerTuning.greenAlignment;
    final maxMenuWidth = isWideWeb
      ? math.max(440.0, math.min(720.0, 520 * uiScale))
      : double.infinity;
    final minHeight = math.max(size.height * 0.66, size.width / LayerTuning.greenAspectRatio);

    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.black87],
        ),
        image: DecorationImage(
          image: AssetImage(primaryAsset),
          fit: BoxFit.contain,
          alignment: alignment,
          filterQuality: FilterQuality.high,
          onError: (_, __) {},
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(12, topPad, 12, bottomPad + footerBottom),
        child: Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxMenuWidth,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GoldWordButton(
                  icon: Icons.content_cut,
                  label: 'Signature services',
                  onTap: () {
                    _go(context, const SignatureServicesPage());
                  },
                ),
                SizedBox(height: rowGap),
                GoldWordButton(
                  icon: Icons.school,
                  label: 'Academy',
                  onTap: () {
                    _go(context, const AcademyPage());
                  },
                ),
                SizedBox(height: rowGap),
                GoldWordButton(
                  icon: Icons.flash_on,
                  label: 'Fast consultation',
                  onTap: () {
                    _go(context, const ConsultationPage());
                  },
                ),
                SizedBox(height: rowGap),
                GoldWordButton(
                  icon: Icons.spa_outlined,
                  label: 'Reiki',
                  onTap: () {
                    _go(context, const ReikiPage());
                  },
                ),
                SizedBox(height: rowGap),
                GoldWordButton(
                  icon: Icons.photo_library_outlined,
                  label: 'Gallery',
                  onTap: () {
                    _go(context, const GalleryCategoriesPage());
                  },
                ),
                SizedBox(height: rowGap),
                GoldWordButton(
                  icon: Icons.location_on_outlined,
                  label: 'Location',
                  onTap: () {
                    _go(context, const LocationPage());
                  },
                ),
                SizedBox(height: rowGap),
                GoldWordButton(
                  icon: Icons.contact_phone_outlined,
                  label: 'Contact',
                  onTap: () {
                    _go(context, const ContactPage());
                  },
                ),
                SizedBox(height: rowGap),
                GoldWordButton(
                  icon: Icons.info_outline,
                  label: 'About',
                  onTap: () {
                    _go(context, const AboutPage());
                  },
                ),
                SizedBox(height: rowGap),
                GoldWordButton(
                  icon: Icons.policy_outlined,
                  label: 'Prices & policy',
                  onTap: () {
                    _go(context, const PricesPolicyPage());
                  },
                ),
                SizedBox(height: 42 * uiScale),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
