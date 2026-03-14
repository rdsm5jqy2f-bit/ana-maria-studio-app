# CocoaPods Recovery on macOS

Use this when iOS build fails on MacBook with pod-related errors.

## Recommended first command

From project root:

```bash
bash scripts/fix_cocoapods_macos.sh
```

If the issue persists:

```bash
bash scripts/fix_cocoapods_macos.sh --deep-clean
```

## Typical error patterns and fixes

### 1) `pod install` fails with repo/spec errors

Symptoms:
- Unable to find a specification
- CDN / Specs repo is out of date

Fix:

```bash
bash scripts/fix_cocoapods_macos.sh
```

If still failing:

```bash
bash scripts/fix_cocoapods_macos.sh --deep-clean
```

### 2) Ruby ffi / architecture issues on Apple Silicon

Symptoms:
- `LoadError` related to ffi
- `incompatible architecture` when running pod

Fix:

```bash
sudo gem uninstall ffi -aIx || true
sudo gem install ffi -N
bash scripts/fix_cocoapods_macos.sh --deep-clean
```

If your shell is forced to x86_64 unexpectedly, open a native arm64 terminal and retry.

### 3) Xcode build uses stale cache after pods are fixed

Symptoms:
- Pod install succeeds but Xcode still fails on old references

Fix:

```bash
rm -rf ~/Library/Developer/Xcode/DerivedData/*
xcrun simctl shutdown all
xcrun simctl erase all
```

Then reopen:
- `ios/Runner.xcworkspace`

### 4) Flutter toolchain mismatch

Run:

```bash
flutter doctor -v
flutter clean
flutter pub get
bash scripts/fix_cocoapods_macos.sh --skip-repo-update
```

## Final check before run

```bash
dart run scripts/ios_preflight_check.dart
```

Then run from Xcode workspace or:

```bash
flutter run -d "iPhone 17 Pro"
```
