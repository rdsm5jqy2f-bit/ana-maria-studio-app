# Release Checklist (Android + iOS)

## 1) Pre-Flight (Both Platforms)

- Confirm app version in `pubspec.yaml` (`version: x.y.z+build`).
- Run static checks:
  - `flutter clean`
  - `flutter pub get`
  - `flutter analyze`
- Optional sanity build for web:
  - `flutter build web --release`

## 2) Android (Google Play)

- Ensure release signing is configured in `android/key.properties`.
- Build Play artifact:
  - `flutter build appbundle --release`
- Output artifact:
  - `build/app/outputs/bundle/release/app-release.aab`
- Play Console steps:
  - Create/Edit release in `Production`.
  - Upload `app-release.aab`.
  - Complete `Data safety`, `Content rating`, `Target audience`, `Store listing`.
  - Roll out release.

## 3) iOS (App Store Connect, macOS Required)

- On Windows (before moving to Mac):
  - `flutter pub get`
  - `dart run scripts/ios_preflight_check.dart`
  - `powershell -ExecutionPolicy Bypass -File scripts/firebase_apps_audit.ps1`
- Ensure bundle id is `com.anamaria.studio` in Xcode project settings.
- In Firebase Console, register iOS app with the same bundle id.
- Download and place:
  - `ios/Runner/GoogleService-Info.plist`
- Ensure iOS Firebase App ID is `1:403287487378:ios:923d1dbb8c0056478c874b` in:
  - `ios/Runner/GoogleService-Info.plist`
  - `lib/firebase_options.dart`
  - `firebase.json`
- On macOS:
  - `flutter clean`
  - `flutter pub get`
  - `dart run scripts/ios_preflight_check.dart`
  - `bash scripts/fix_cocoapods_macos.sh`
  - Open `ios/Runner.xcworkspace`
- In Xcode:
  - Set `Team` and `Signing` for Runner target.
  - Increment build number if needed.
  - If build fails, run `bash scripts/fix_cocoapods_macos.sh --deep-clean`, then use Product -> Clean Build Folder and clear DerivedData.
  - Product -> Archive -> Distribute App -> App Store Connect.

## 4) Post-Release Verification

- Install production build from Play/App Store TestFlight.
- Verify first-open flow, gallery loading, and key navigation paths.
- Confirm Firebase Storage gallery fallback behavior on weak network.
