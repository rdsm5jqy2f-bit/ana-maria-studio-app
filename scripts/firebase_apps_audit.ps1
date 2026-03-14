param(
    [string]$ExpectedIosBundleId = "com.anamaria.studio",
    [string]$ExpectedAndroidPackage = "com.anamaria.studio"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Section {
    param([string]$Title)
    Write-Host ""
    Write-Host $Title
    Write-Host ('-' * $Title.Length)
}

function Get-FirebaseJson {
    $raw = firebase apps:list --json
    if ([string]::IsNullOrWhiteSpace($raw)) {
        throw "firebase apps:list returned empty output."
    }
    return ($raw | ConvertFrom-Json)
}

try {
    $firebase = Get-FirebaseJson
} catch {
    Write-Error "Failed to read Firebase apps. Ensure Firebase CLI is installed and logged in (`firebase login`). Details: $($_.Exception.Message)"
    exit 1
}

if ($firebase.status -ne 'success') {
    Write-Error "Firebase CLI returned non-success status."
    exit 1
}

$apps = @($firebase.result)
$iosApps = @($apps | Where-Object { $_.platform -eq 'IOS' })
$androidApps = @($apps | Where-Object { $_.platform -eq 'ANDROID' })
$webApps = @($apps | Where-Object { $_.platform -eq 'WEB' })

Write-Section "Firebase App Inventory"
Write-Host "Total apps: $($apps.Count)"
Write-Host "iOS apps: $($iosApps.Count)"
Write-Host "Android apps: $($androidApps.Count)"
Write-Host "Web apps: $($webApps.Count)"

Write-Section "iOS Apps"
if ($iosApps.Count -eq 0) {
    Write-Host "No iOS apps found."
} else {
    $iosApps | Select-Object appId, namespace, displayName, state | Format-Table -AutoSize
}

Write-Section "Android Apps"
if ($androidApps.Count -eq 0) {
    Write-Host "No Android apps found."
} else {
    $androidApps | Select-Object appId, namespace, displayName, state | Format-Table -AutoSize
}

$matchedIos = @($iosApps | Where-Object { $_.namespace -eq $ExpectedIosBundleId })
$matchedAndroid = @($androidApps | Where-Object { $_.namespace -eq $ExpectedAndroidPackage })

Write-Section "Readiness Verdict"

if ($matchedIos.Count -eq 1) {
    Write-Host "OK: Exactly one iOS app matches expected bundle ID '$ExpectedIosBundleId'."
    Write-Host "    iOS App ID: $($matchedIos[0].appId)"
} elseif ($matchedIos.Count -gt 1) {
    Write-Host "WARN: Multiple iOS apps match '$ExpectedIosBundleId'. Keep only one to avoid confusion."
    $matchedIos | Select-Object appId, namespace | Format-Table -AutoSize
} else {
    Write-Host "FAIL: No iOS app matches expected bundle ID '$ExpectedIosBundleId'."
}

if ($matchedAndroid.Count -eq 1) {
    Write-Host "OK: Exactly one Android app matches expected package '$ExpectedAndroidPackage'."
    Write-Host "    Android App ID: $($matchedAndroid[0].appId)"
} elseif ($matchedAndroid.Count -gt 1) {
    Write-Host "WARN: Multiple Android apps match '$ExpectedAndroidPackage'. Keep only one if possible."
    $matchedAndroid | Select-Object appId, namespace | Format-Table -AutoSize
} else {
    Write-Host "FAIL: No Android app matches expected package '$ExpectedAndroidPackage'."
}

if ($iosApps.Count -gt 1) {
    Write-Host "WARN: Multiple iOS apps are registered in Firebase. Ensure `GoogleService-Info.plist` and `lib/firebase_options.dart` use the intended app ID."
}

if ($androidApps.Count -gt 1) {
    Write-Host "WARN: Multiple Android apps are registered in Firebase. Ensure `android/app/google-services.json` and `lib/firebase_options.dart` use the intended app ID."
}

Write-Host ""
Write-Host "Tip: If stale apps exist (for old com.example.* namespaces), remove them from Firebase Console to reduce release-time mistakes."
