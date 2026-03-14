# Ana Maria Studio App

Flutter project for Android, iOS, and Web.

## iOS Build Setup

1. On Windows before switching to Mac, run local preflight:
	- `flutter pub get`
	- `dart run scripts/ios_preflight_check.dart`
	- `powershell -ExecutionPolicy Bypass -File scripts/firebase_apps_audit.ps1`
2. Firebase sanity check:
	- Keep iOS bundle id as `com.anamaria.studio`.
	- Keep iOS Firebase App ID as `1:403287487378:ios:923d1dbb8c0056478c874b`.
	- If you still have old `com.example.*` Firebase apps, remove them in Firebase Console to avoid uploading the wrong plist/app id.
3. Ensure `ios/Runner/GoogleService-Info.plist` exists and matches `com.anamaria.studio`.
4. If bundle id changes, update it in Xcode and regenerate `lib/firebase_options.dart` with `flutterfire configure`.
5. First run on Mac:
	- `flutter clean`
	- `flutter pub get`
	- `dart run scripts/ios_preflight_check.dart`
	- `bash scripts/fix_cocoapods_macos.sh`
	- Open `ios/Runner.xcworkspace`, set Development Team + Automatic Signing, then run `flutter run -d "iPhone 17 Pro"`.
6. If simulator build errors reappear on Mac:
	- Run: `bash scripts/fix_cocoapods_macos.sh --deep-clean`
	- If pod repo is healthy and you need speed, run: `bash scripts/fix_cocoapods_macos.sh --skip-repo-update`
	- See full recovery notes: `docs/COCOAPODS_MACOS_RECOVERY.md`
	- In Xcode: Product -> Clean Build Folder.
	- Delete DerivedData: `rm -rf ~/Library/Developer/Xcode/DerivedData/*`.
	- Restart simulator: `xcrun simctl shutdown all; xcrun simctl erase all`.
7. Release:
	- `flutter build ios --release`
	- For App Store submission, use Xcode Archive/Distribute from `ios/Runner.xcworkspace`.

## Web Deploy (Firebase Hosting)

1. Install Firebase CLI:
	- `npm install -g firebase-tools`
2. Login:
	- `firebase login`
3. Set your Firebase project id in `.firebaserc`:
	- replace `replace-with-your-firebase-project-id`
4. Build web:
	- `flutter build web --release`
5. Deploy:
	- `firebase deploy --only hosting`

## Custom Domain Setup (www redirect)

Follow these steps to configure the www subdomain redirect to the apex domain.

### Step 1: DNS Provider Configuration

In your DNS provider, add a CNAME record:

| Field        | Value                   |
|--------------|-------------------------|
| Host/Name    | www                     |
| Type         | CNAME                   |
| Target/Value | ghs.googlehosted.com    |
| TTL          | 300 (or Auto)           |

### Step 2: Firebase Hosting Configuration

1. Go to Firebase Console → Hosting → Custom domains
2. Add `www.anamariastudio.co.uk` to the same hosting site
3. Set Redirect to `https://anamariastudio.co.uk` (Permanent 301)

### Step 3: Verification

Wait for DNS propagation (5 min - 24h, usually quick), then test:

- `http://www.anamariastudio.co.uk` → should redirect to `https://anamariastudio.co.uk`
- `https://www.anamariastudio.co.uk` → should redirect to `https://anamariastudio.co.uk`

## Remote Gallery (no rebuild for new photos)

The gallery now loads images from Firebase Storage first, then falls back to local assets if remote folders are empty or unavailable.

### 1) Firebase app setup (required once)

1. Create a Firebase project.
2. Add your Android app in Firebase Console (use the same package id as the app).
3. Add your Web app in Firebase Console.
4. Generate Flutter config with FlutterFire CLI:
	- `dart pub global activate flutterfire_cli`
	- `flutterfire configure`
5. Ensure `lib/firebase_options.dart` is generated.

### 2) Storage rules (required once)

Use the rules from `storage.rules` and publish them in Firebase Console:
- Firebase Console → Storage → Rules → paste rules → Publish.

Use these Storage folders:
- `gallery/colors/`
- `gallery/hairstyles/`
- `gallery/inspiration/`

Notes:
- Keep image names sortable (for example `p001.jpg`, `p002.jpg`, `pink_001.jpg`).
- Supported formats: `.jpg`, `.jpeg`, `.png`, `.webp`.
- After app publish, adding/removing photos in these folders updates gallery content without a new Store release.

## Local Web Test

- `flutter run -d chrome`
