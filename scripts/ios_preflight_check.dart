import 'dart:convert';
import 'dart:io';

void main() {
  final report = <_CheckResult>[];

  const paths = _Paths(
    firebaseOptions: 'lib/firebase_options.dart',
    firebaseJson: 'firebase.json',
    firebaserc: '.firebaserc',
    iosGoogleServiceInfoPlist: 'ios/Runner/GoogleService-Info.plist',
    iosPodfile: 'ios/Podfile',
    iosProjectPbxproj: 'ios/Runner.xcodeproj/project.pbxproj',
  );

  final files = {
    paths.firebaseOptions: _readFile(paths.firebaseOptions),
    paths.firebaseJson: _readFile(paths.firebaseJson),
    paths.firebaserc: _readFile(paths.firebaserc),
    paths.iosGoogleServiceInfoPlist: _readFile(paths.iosGoogleServiceInfoPlist),
    paths.iosPodfile: _readFile(paths.iosPodfile),
    paths.iosProjectPbxproj: _readFile(paths.iosProjectPbxproj),
  };

  final missingFiles = files.entries.where((entry) => entry.value == null).map((entry) => entry.key).toList();
  report.add(
    _CheckResult(
      title: 'Required files exist',
      passed: missingFiles.isEmpty,
      detail: missingFiles.isEmpty
          ? 'All required files are present.'
          : 'Missing: ${missingFiles.join(', ')}',
    ),
  );

  if (missingFiles.isNotEmpty) {
    _printReport(report);
    exit(1);
  }

  final firebaseOptionsContent = files[paths.firebaseOptions]!;
  final firebaseJsonContent = files[paths.firebaseJson]!;
  final firebasercContent = files[paths.firebaserc]!;
  final googleServiceInfoPlistContent = files[paths.iosGoogleServiceInfoPlist]!;
  final podfileContent = files[paths.iosPodfile]!;
  final pbxprojContent = files[paths.iosProjectPbxproj]!;

  final plistBundleId = _extractPlistValue(googleServiceInfoPlistContent, 'BUNDLE_ID');
  final plistAppId = _extractPlistValue(googleServiceInfoPlistContent, 'GOOGLE_APP_ID');

  final iosOptionsBlock = _extractFirst(
    RegExp(r'static const FirebaseOptions ios = FirebaseOptions\(([\s\S]*?)\);', multiLine: true),
    firebaseOptionsContent,
  );
  final optionsIosBundleId = _extractFirst(RegExp(r"iosBundleId:\s*'([^']+)'"), iosOptionsBlock ?? '');
  final optionsIosAppId = _extractFirst(RegExp(r"appId:\s*'([^']+)'"), iosOptionsBlock ?? '');

  String? firebaseJsonIosAppId;
  String? firebasercDefaultProject;
  String? firebaseOptionsProjectId;

  try {
    final firebaseJson = jsonDecode(firebaseJsonContent) as Map<String, dynamic>;
    final flutter = firebaseJson['flutter'] as Map<String, dynamic>?;
    final platforms = flutter?['platforms'] as Map<String, dynamic>?;
    final dartPlatform = platforms?['dart'] as Map<String, dynamic>?;
    final firebaseOptionsPath = dartPlatform?['lib/firebase_options.dart'] as Map<String, dynamic>?;
    final configurations = firebaseOptionsPath?['configurations'] as Map<String, dynamic>?;
    firebaseJsonIosAppId = configurations?['ios'] as String?;
  } catch (_) {
    // Keep null and report below.
  }

  try {
    final firebaserc = jsonDecode(firebasercContent) as Map<String, dynamic>;
    final projects = firebaserc['projects'] as Map<String, dynamic>?;
    firebasercDefaultProject = projects?['default'] as String?;
  } catch (_) {
    // Keep null and report below.
  }

  firebaseOptionsProjectId = _extractFirst(RegExp(r"projectId:\s*'([^']+)'"), iosOptionsBlock ?? '');

  final runnerBundleIds = RegExp(r'PRODUCT_BUNDLE_IDENTIFIER = ([^;]+);')
      .allMatches(pbxprojContent)
      .map((match) => match.group(1)?.trim() ?? '')
      .where((bundleId) => bundleId.isNotEmpty && !bundleId.endsWith('.RunnerTests'))
      .toSet();

  final podfileIosPlatform = _extractFirst(RegExp(r"platform\s*:ios,\s*'([^']+)'"), podfileContent);

  final xcodeDeploymentTargets = RegExp(r'IPHONEOS_DEPLOYMENT_TARGET = ([0-9.]+);')
      .allMatches(pbxprojContent)
      .map((match) => match.group(1)?.trim() ?? '')
      .where((value) => value.isNotEmpty)
      .toSet();

  report.add(
    _CheckResult(
      title: 'Runner bundle ID is consistent',
      passed: runnerBundleIds.length == 1,
      detail: runnerBundleIds.isEmpty
          ? 'Could not detect Runner bundle IDs in project.pbxproj.'
          : 'Runner bundle IDs: ${runnerBundleIds.join(', ')}',
    ),
  );

  final bundleIdSet = <String>{
    if (plistBundleId != null) plistBundleId,
    if (optionsIosBundleId != null) optionsIosBundleId,
    ...runnerBundleIds,
  };

  report.add(
    _CheckResult(
      title: 'iOS bundle ID matches across files',
      passed: bundleIdSet.length == 1,
      detail: 'plist=$plistBundleId, firebase_options=$optionsIosBundleId, xcode=${runnerBundleIds.join(', ')}',
    ),
  );

  final appIdSet = <String>{
    if (plistAppId != null) plistAppId,
    if (optionsIosAppId != null) optionsIosAppId,
    if (firebaseJsonIosAppId != null) firebaseJsonIosAppId,
  };

  report.add(
    _CheckResult(
      title: 'Firebase iOS App ID matches across files',
      passed: appIdSet.length == 1,
      detail: 'plist=$plistAppId, firebase_options=$optionsIosAppId, firebase.json=$firebaseJsonIosAppId',
    ),
  );

  report.add(
    _CheckResult(
      title: 'Firebase project alias is configured',
      passed: (firebasercDefaultProject ?? '').isNotEmpty,
      detail: 'default project: ${firebasercDefaultProject ?? 'not found'}',
    ),
  );

  if ((firebasercDefaultProject ?? '').isNotEmpty && (firebaseOptionsProjectId ?? '').isNotEmpty) {
    report.add(
      _CheckResult(
        title: 'Firebase project ID is aligned',
        passed: firebasercDefaultProject == firebaseOptionsProjectId,
        detail: '.firebaserc=${firebasercDefaultProject!}, firebase_options(ios)=$firebaseOptionsProjectId',
      ),
    );
  }

  final minRecommendedIos = '13.0';
  final podfileTargetOk = podfileIosPlatform != null && _versionCompare(podfileIosPlatform, minRecommendedIos) >= 0;
  final xcodeTargetOk = xcodeDeploymentTargets.isNotEmpty &&
      xcodeDeploymentTargets.every((value) => _versionCompare(value, minRecommendedIos) >= 0);

  report.add(
    _CheckResult(
      title: 'iOS deployment target is modern enough',
      passed: podfileTargetOk && xcodeTargetOk,
      detail:
          'Podfile=$podfileIosPlatform, Xcode targets=${xcodeDeploymentTargets.isEmpty ? 'none found' : xcodeDeploymentTargets.join(', ')}, required >= $minRecommendedIos',
    ),
  );

  _printReport(report);

  final hasFailure = report.any((item) => !item.passed);
  if (hasFailure) {
    exit(1);
  }

  stdout.writeln('\nAll local checks passed. Next on macOS: flutter clean; flutter pub get; cd ios; pod repo update; pod install; cd ..; open ios/Runner.xcworkspace');
}

String? _readFile(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    return null;
  }
  return file.readAsStringSync();
}

String? _extractPlistValue(String plistContent, String key) {
  final pattern = RegExp('<key>$key</key>\\s*<string>([^<]+)</string>', multiLine: true);
  return _extractFirst(pattern, plistContent);
}

String? _extractFirst(RegExp pattern, String input) {
  final match = pattern.firstMatch(input);
  final value = match?.group(1)?.trim();
  if (value == null || value.isEmpty) {
    return null;
  }
  return value;
}

int _versionCompare(String a, String b) {
  final left = a.split('.').map((part) => int.tryParse(part) ?? 0).toList();
  final right = b.split('.').map((part) => int.tryParse(part) ?? 0).toList();
  final maxLen = left.length > right.length ? left.length : right.length;

  for (var i = 0; i < maxLen; i++) {
    final l = i < left.length ? left[i] : 0;
    final r = i < right.length ? right[i] : 0;
    if (l != r) {
      return l.compareTo(r);
    }
  }

  return 0;
}

void _printReport(List<_CheckResult> report) {
  stdout.writeln('iOS preflight report');
  stdout.writeln('===================');
  for (final item in report) {
    final marker = item.passed ? 'OK' : 'FAIL';
    stdout.writeln('[$marker] ${item.title}');
    stdout.writeln('       ${item.detail}');
  }
}

class _Paths {
  const _Paths({
    required this.firebaseOptions,
    required this.firebaseJson,
    required this.firebaserc,
    required this.iosGoogleServiceInfoPlist,
    required this.iosPodfile,
    required this.iosProjectPbxproj,
  });

  final String firebaseOptions;
  final String firebaseJson;
  final String firebaserc;
  final String iosGoogleServiceInfoPlist;
  final String iosPodfile;
  final String iosProjectPbxproj;
}

class _CheckResult {
  const _CheckResult({
    required this.title,
    required this.passed,
    required this.detail,
  });

  final String title;
  final bool passed;
  final String detail;
}
