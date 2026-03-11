# Ana Maria Studio App

Flutter project for Android, iOS, and Web.

## iOS Build Setup

1. Prerequisites on macOS: Xcode, CocoaPods (`sudo gem install cocoapods`).
2. Firebase config: in Firebase Console add the iOS app with bundle id `com.anamaria.studio`, download `GoogleService-Info.plist`, place it at `ios/Runner/GoogleService-Info.plist`, and commit it (private repository).
3. If you ever change the bundle id, update it in Xcode and regenerate `lib/firebase_options.dart` with `flutterfire configure`.
4. First run on Mac: `flutter clean`, `flutter pub get`, then `cd ios && pod install && cd ..`, open `ios/Runner.xcworkspace`, set Development Team + Automatic Signing, then run `flutter run -d <device>`.
5. Release: `flutter build ios --release` (artifacts are generated in `build/ios/ipa`). For App Store submission, use Xcode Archive/Distribute from the workspace.

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
