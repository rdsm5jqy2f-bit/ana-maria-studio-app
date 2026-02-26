# Ana Maria Studio App

Flutter project for Android, iOS, and Web.

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
