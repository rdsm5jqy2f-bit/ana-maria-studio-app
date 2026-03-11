import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppConfig {
  static const String appName = 'Ana Maria Studio & Academy';
  static bool get enableRemoteGallery => !kIsWeb;
  static const String remoteGalleryRoot = 'gallery';
}

class AppAssets {
  // Branding (lowercase paths)
  static const String redLayer = 'assets/images/branding/redlayer.png';
  static const String blueLayer = 'assets/images/branding/bluelayer.png';
  // Green section background (photo layer). Adjust scale/position via LayerTuning.
  static const String greenLayerBg = 'assets/images/branding/greenlayer.png';
  static const String pinkFallback = 'assets/images/branding/pinklayer.png';

  // Gallery prefixes
  static const String galleryColorsPrefix = 'assets/images/gallery/colors';
  static const String galleryHairstylesPrefix =
      'assets/images/gallery/hairstyles';
  static const String galleryInspirationPrefix =
      'assets/images/gallery/inspiration';

  // Pink background helper (expects files like assets/images/background/pink_001.jpg)
  static String pink(int n) {
    final s = n.toString().padLeft(3, '0');
    return 'assets/images/background/pink/pink_$s.jpg';
  }

  // Pink page backgrounds (uses assets/images/background/pink/)
  static String pinkPage(int n) {
    final s = n.toString().padLeft(3, '0');
    return 'assets/images/background/pink_pages/pink_$s.jpg';
  }

  // Dedicated named backgrounds for page mapping
  static String pinkNamed(String name) =>
      'assets/images/background/pink_named/$name';

  // === Page backgrounds (change numbers anytime) ===
  static final String bgAcademyHub = pinkNamed('academy_hub.jpg');
  static final String bgLevel1 = pinkNamed('level_1.jpg');
  static final String bgLevel2 = pinkNamed('level2.jpg');
  static final String bgLevel3 = pinkNamed('level_3.jpg');
  static final String bgPackage12 = pinkNamed('package_12.jpg');
  static final String bgPackage123 = pinkNamed('package_123.jpg');
  static final String bgProCoursesHub = pinkNamed('pro_courses_hub.jpg');
  static final String bgCourseColour = pinkNamed('course_color.jpg');
  static final String bgCourseCutStyle = pinkNamed('course_cut_style.jpg');
  static final String bgCourseExtensions = pinkNamed('course_extensions.jpg');
  static final String bgCourseUpgrade = pinkNamed('course_upgrade.jpg');
  static final String bgCertification = pinkNamed('certification.jpg');

  static final String bgSignatureHub = pinkNamed('signature_hub.jpg');
  static final String bgColourSignature = pinkNamed('color_signature.jpg');
  static final String bgCuttingStyling = pinkNamed('cutting_styling.jpg');
  static final String bgBridal = pinkNamed('bridal.jpg');
  static final String bgConsultService = pinkNamed('consult_service.jpg');
  static final String bgServiceDetail = pinkNamed('service_detail.jpg');
  static final String bgBalayage = pinkNamed('balayage.jpg');
  static final String bgAirtouch = pinkNamed('airtouch.jpg');
  static final String bgColourCorrection = pinkNamed('colour_correction.jpg');
  static final String bgFullColourRoots = pinkNamed('full_colour_roots.jpg');
  static final String bgHaircut = pinkNamed('haircut.jpg');
  static final String bgWashBlowdry = pinkNamed('wash_blowdry.jpg');
  static final String bgHairUpEventStyling =
      pinkNamed('hair_up_event_styling.jpg');
  static final String bgSignatureTransformation =
      pinkNamed('signature_transformation.jpg');
    static final String bgHairTherapy = pinkNamed('hair_therapy.jpg');
    static final String bgHairExtensions = pinkNamed('hair_extensions.jpg');

  static final String bgFastConsult = pinkNamed('fast_consult.jpg');
  static final String bgReiki = pinkNamed('reiki.jpg');

  static final String bgGalleryCategories = pinkNamed('gallery_categories.jpg');
  static final String bgGalleryGridColours =
      pinkNamed('gallery_grid_colours.jpg');
  static final String bgGalleryGridHairstyles =
      pinkNamed('gallery_grid_hairstyles.jpg');
  static final String bgGalleryGridInspiration =
      pinkNamed('gallery_grid_inspiration.jpg');

  static final String bgContact = pinkNamed('contact.jpg');
  static final String bgAbout = pinkNamed('about.jpg');
  static final String bgInfo = pinkNamed('info.jpg');
  static final String bgLocation = pinkNamed('location.jpg');
  static final String bgPolicies = pinkNamed('policies.jpg');

  static String slugFromTitle(String title) {
    final lower = title.trim().toLowerCase();
    final normalized = lower
        .replaceAll('&', ' and ')
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    return normalized.isEmpty ? 'pink_page' : normalized;
  }

  static String pinkByTitle(String title) {
    final key = slugFromTitle(title);
    const mapped = <String, String>{
      'academy': 'academy_hub.jpg',
      'signature_services': 'signature_hub.jpg',
      'consultation': 'fast_consult.jpg',
      'reiki': 'reiki.jpg',
      'gallery': 'gallery_categories.jpg',
      'location': 'location.jpg',
      'contact': 'contact.jpg',
      'about': 'about.jpg',
      'prices_and_policy': 'policies.jpg',
      'info': 'info.jpg',
      'colour_signature': 'color_signature.jpg',
      'balayage': 'balayage.jpg',
      'airtouch': 'airtouch.jpg',
      'colour_correction': 'colour_correction.jpg',
      'full_colour_roots': 'full_colour_roots.jpg',
      'haircut': 'haircut.jpg',
      'wash_blowdry': 'wash_blowdry.jpg',
      'hair_up_event_styling': 'hair_up_event_styling.jpg',
      'cutting_and_styling': 'cutting_styling.jpg',
      'signature_transformation': 'signature_transformation.jpg',
      'hair_therapy': 'hair_therapy.jpg',
      'hair_extensions': 'hair_extensions.jpg',
      'bridal_and_events': 'bridal.jpg',
      'professional_courses': 'pro_courses_hub.jpg',
      'level_1': 'level_1.jpg',
      'level_2': 'level2.jpg',
      'level_3': 'level_3.jpg',
    };

    final filename = mapped[key];
    if (filename == null) {
      return pinkFallback;
    }
    return pinkNamed(filename);
  }

  // webVariant removed: always use the same asset path for all platforms
}

class AppLinks {
  static const String address =
      'Ana Maria Studio & Academy\n541 High Road\nLeytonstone\nLondon E11 4PB';
  static const String googleMapsQuery =
      'https://www.google.com/maps/search/?api=1&query=541+High+Road+Leytonstone+London+E11+4PB';
  static const String whatsappBooking = 'https://wa.me/447427216249';
  static const String whatsappQuote = 'https://wa.me/447427216249';
  static const String whatsappReikiAddOn =
      'https://wa.me/447427216249?text=I%20would%20like%20to%20add%20Reiki%20to%20my%20booking%20please.';
  static const String phoneCall = 'tel:+447404867249';
  static const String googleReview = 'https://share.google/Df13f1FfDnzpHtsvh';

  static const String facebook =
      'https://www.facebook.com/share/1NgLyMbB1W/?mibextid=wwXIfr';
  static const String instagram =
      'https://www.instagram.com/anamaria.hair_studio?igsh=MW5yYXB2MjY3ZmVmaQ%3D%3D&utm_source=qr';
  static const String tiktok =
      'https://www.tiktok.com/@anamariahairstudio?_r=1&_t=ZN-93kYvxCX5IE';

  static const String website = '';
}

class LayerTuning {
  // Quick tuning knobs for layer images (zoom + position).
  // scale: 1.0 = normal, >1 zoom in, <1 zoom out.
  // Alignment examples: Alignment.topCenter, Alignment.center, Alignment(0.0, -0.2)
  // Offset is in logical pixels (dx, dy).

  // Width / Height ratios of the source assets.
  static const double redAspectRatio = 1080 / 552;
  static const double blueAspectRatio = 1080 / 288;
  static const double greenAspectRatio = 1080 / 1560;
  static const double pinkAspectRatio = 1080 / 1150;

  static const double redScale = 1.00;
  static const Alignment redAlignment = Alignment.topCenter;
  static const Offset redOffset = Offset(0, 0);

  static const double blueScale = 1.00;
  static const Alignment blueAlignment = Alignment.topCenter;
  static const Offset blueOffset = Offset(0, 0);

  static const double greenScale = 1.00;
  static const Alignment greenAlignment = Alignment.topCenter;
  static const Offset greenOffset = Offset(0, 0);

  static const double pinkScale = 1.00;
  static const Alignment pinkAlignment = Alignment.center;
  static const Offset pinkOffset = Offset(0, 0);
}
