#!/usr/bin/env bash

set -euo pipefail

DEEP_CLEAN="false"
SKIP_REPO_UPDATE="false"

for arg in "$@"; do
  case "$arg" in
    --deep-clean)
      DEEP_CLEAN="true"
      ;;
    --skip-repo-update)
      SKIP_REPO_UPDATE="true"
      ;;
    *)
      echo "Unknown argument: $arg"
      echo "Usage: bash scripts/fix_cocoapods_macos.sh [--deep-clean] [--skip-repo-update]"
      exit 1
      ;;
  esac
done

log() {
  echo "[pods-fix] $1"
}

abort() {
  echo "[pods-fix][error] $1" >&2
  exit 1
}

if [[ "$(uname -s)" != "Darwin" ]]; then
  abort "This script must be run on macOS."
fi

if [[ ! -f "pubspec.yaml" ]]; then
  abort "Run this script from the Flutter project root (pubspec.yaml not found)."
fi

if [[ ! -d "ios" ]]; then
  abort "ios directory not found in current project."
fi

if ! command -v xcode-select >/dev/null 2>&1; then
  abort "xcode-select not found. Install Xcode + command line tools first."
fi

if ! xcode-select -p >/dev/null 2>&1; then
  abort "Xcode command line tools are not configured. Run: xcode-select --install"
fi

if ! command -v flutter >/dev/null 2>&1; then
  abort "flutter command not found. Add Flutter to PATH first."
fi

ensure_pod() {
  if command -v pod >/dev/null 2>&1; then
    log "CocoaPods found: $(pod --version)"
    return
  fi

  log "CocoaPods not found. Trying Homebrew install first."
  if command -v brew >/dev/null 2>&1; then
    brew install cocoapods || brew upgrade cocoapods || true
  fi

  if ! command -v pod >/dev/null 2>&1; then
    log "Homebrew path did not provide pod. Trying Ruby gem install."
    if command -v gem >/dev/null 2>&1; then
      sudo gem install cocoapods -N
    else
      abort "Neither brew nor gem is available to install CocoaPods."
    fi
  fi

  command -v pod >/dev/null 2>&1 || abort "CocoaPods installation failed."
  log "CocoaPods installed: $(pod --version)"
}

ensure_pod

log "Running Flutter cleanup and dependency sync."
flutter clean
flutter pub get
flutter precache --ios

log "Entering ios directory."
pushd ios >/dev/null

log "Removing Pods and Podfile.lock."
rm -rf Pods Podfile.lock

if [[ "$DEEP_CLEAN" == "true" ]]; then
  log "Deep clean enabled: clearing pod integration and caches."
  pod deintegrate || true
  rm -rf "$HOME/Library/Caches/CocoaPods"
  rm -rf "$HOME/.cocoapods/repos"
  rm -rf "$HOME/Library/Developer/Xcode/DerivedData"
fi

if [[ "$SKIP_REPO_UPDATE" == "true" ]]; then
  log "Skipping pod repo update (--skip-repo-update)."
else
  log "Updating CocoaPods specs repo."
  pod repo update
fi

log "Installing pods."
pod install --verbose

popd >/dev/null

log "CocoaPods repair completed. Open ios/Runner.xcworkspace in Xcode and run the app."