import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_storage/firebase_storage.dart';

import '../../section_page.dart';
import '../../core/app_config.dart';
import '../../core/ui_widgets.dart';

class GalleryGridPage extends StatelessWidget {
  final String folder; // 'colors' / 'hairstyles' / 'inspiration'
  final String title;

  const GalleryGridPage({super.key, required this.folder, required this.title});

  String _folderPath() {
    final normalizedFolder = folder.trim().toLowerCase();
    if (normalizedFolder == 'colors') return AppAssets.galleryColorsPrefix;
    if (normalizedFolder == 'hairstyles')
      return AppAssets.galleryHairstylesPrefix;
    return AppAssets.galleryInspirationPrefix;
  }

  String _filePrefix() {
    final normalizedFolder = folder.trim().toLowerCase();
    if (normalizedFolder == 'inspiration') return 'pink_';
    return 'p';
  }

  bool _isSupportedImage(String name) {
    final file = name.toLowerCase();
    return file.endsWith('.jpg') ||
        file.endsWith('.jpeg') ||
        file.endsWith('.png') ||
        file.endsWith('.webp');
  }

  Future<List<String>> _loadRemoteImages() async {
    if (!AppConfig.enableRemoteGallery) {
      return const <String>[];
    }

    try {
      final folderRef = FirebaseStorage.instance
          .ref('${AppConfig.remoteGalleryRoot}/${folder.trim().toLowerCase()}');

      final listResult = await folderRef.listAll();
      final refs = listResult.items
          .where((item) => _isSupportedImage(item.name))
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name));

      final urls = <String>[];
      for (final item in refs) {
        urls.add(await item.getDownloadURL());
      }
      return urls;
    } catch (_) {
      return const <String>[];
    }
  }

  Future<List<String>> _loadSequentialAssets() async {
    final basePath = _folderPath();
    final prefix = _filePrefix();

    final found = <String>[];
    var missesInRow = 0;

    for (var index = 1; index <= 500; index++) {
      final number = index.toString().padLeft(3, '0');
      final assetPath = '$basePath/$prefix$number.jpg';

      try {
        await rootBundle.load(assetPath);
        found.add(assetPath);
        missesInRow = 0;
      } catch (_) {
        missesInRow++;
        if (missesInRow >= 25 && found.isNotEmpty) {
          break;
        }
      }
    }

    return found;
  }

  Future<List<String>> _loadLocalAssetsFromManifest() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap =
          jsonDecode(manifestContent) as Map<String, dynamic>;

      final basePath = _folderPath();
      final assets = manifestMap.keys
          .where((path) => path.startsWith('$basePath/'))
          .where(_isSupportedImage)
          .toList()
        ..sort();

      return assets;
    } catch (_) {
      return const <String>[];
    }
  }

  Future<List<String>> _loadAssets() async {
    final remote = await _loadRemoteImages();
    if (remote.isNotEmpty) {
      return remote;
    }

    final manifestAssets = await _loadLocalAssetsFromManifest();
    if (manifestAssets.isNotEmpty) {
      return manifestAssets;
    }

    return _loadSequentialAssets();
  }

  void _openImageViewer(BuildContext context, String imagePath) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 5.0,
                    child: imagePath.startsWith('http')
                        ? Image.network(
                            imagePath,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.image_not_supported,
                              color: Colors.white54,
                              size: 48,
                            ),
                          )
                        : Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.image_not_supported,
                              color: Colors.white54,
                              size: 48,
                            ),
                          ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SectionPage(
      backgroundAsset: (folder.trim().toLowerCase() == 'colors'
          ? AppAssets.bgGalleryGridColours
          : (folder.trim().toLowerCase() == 'hairstyles'
              ? AppAssets.bgGalleryGridHairstyles
              : AppAssets.bgGalleryGridInspiration)),
      title: title,
      child: FutureBuilder<List<String>>(
        future: _loadAssets(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ));
          }
          final items = snap.data ?? const <String>[];
          if (items.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(12),
              child: RainbowParagraph(
                'No images found. Check your asset paths and pubspec.yaml.',
              ),
            );
          }

          return SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isLandscape ? 4 : 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.72,
              ),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final imagePath = items[i];

                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Material(
                    color: Colors.black.withValues(alpha: 0.30 * 255),
                    child: InkWell(
                      onTap: () => _openImageViewer(context, imagePath),
                      child: imagePath.startsWith('http')
                          ? Image.network(
                              imagePath,
                              fit: BoxFit.contain,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.black54,
                                child: const Center(
                                  child: Icon(Icons.image_not_supported,
                                      color: Colors.white54),
                                ),
                              ),
                            )
                          : Image.asset(
                              imagePath,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.black54,
                                child: const Center(
                                  child: Icon(Icons.image_not_supported,
                                      color: Colors.white54),
                                ),
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
