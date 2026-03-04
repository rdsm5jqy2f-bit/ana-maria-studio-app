import 'dart:io';

void main() {
  const buildWebPath = 'build/web';
  const webPath = 'web';

  final buildWebDir = Directory(buildWebPath);
  if (!buildWebDir.existsSync()) {
    stderr.writeln('Directory missing: $buildWebPath. Run flutter build web first.');
    exit(1);
  }

  final filesToCopy = <String>['sitemap.xml', 'robots.txt'];

  for (final fileName in filesToCopy) {
    final source = File('$webPath/$fileName');
    if (!source.existsSync()) {
      stderr.writeln('Source file missing: ${source.path}');
      exit(1);
    }

    final destination = File('$buildWebPath/$fileName');
    source.copySync(destination.path);
    stdout.writeln('Copied ${source.path} -> ${destination.path}');
  }
}
