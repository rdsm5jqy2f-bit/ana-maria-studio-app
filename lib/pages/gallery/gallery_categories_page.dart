import 'package:flutter/material.dart';
import '../../core/app_config.dart';
import '../../section_page.dart';
import '../../core/ui_widgets.dart';
import 'gallery_grid_page.dart';

class GalleryCategoriesPage extends StatelessWidget {
  const GalleryCategoriesPage({super.key});

  void _go(BuildContext context, String folder, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GalleryGridPage(folder: folder, title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionPage(
      backgroundAsset: AppAssets.bgGalleryCategories,
      title: 'Gallery',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GoldWordButton(
            icon: Icons.palette_outlined,
            label: 'Colors',
            onTap: () => _go(context, 'colors', 'Colors'),
          ),
          const SizedBox(height: 8),
          GoldWordButton(
            icon: Icons.content_cut,
            label: 'Hairstyles',
            onTap: () => _go(context, 'hairstyles', 'Hairstyles'),
          ),
        ],
      ),
    );
  }
}
