# Google Play Production Release Package

Prepared on: 2026-03-11

## 1) Release Metadata (Use in Play Console)

- App name: Ana Maria Studio
- Package name (applicationId): com.anamaria.studio
- Version name: 1.0.1
- Version code: 2
- Artifact type: Android App Bundle (.aab)
- Artifact path: C:\Users\acead\dev\flutter_projects\ana_maria_app\build\app\outputs\bundle\release\app-release.aab
- Artifact size: 56556811 bytes (53.94 MB)
- Last build timestamp: 2026-03-11 19:24:19
- Git branch: main
- Release commits:
  - e395c62dcc7168bbd7b0ab07ca16156ed4664d8e
  - 00560a7

Suggested release name in Play Console:
- 1.0.1 (2) - Production

## 2) Copy-Paste "What's new" (en-GB / en-US)

Improved page rendering and visual consistency across service screens. Fixed gallery asset loading behavior for a smoother experience. Updated Android and iOS release configuration and metadata for a cleaner production rollout.

Length: 227 characters (safe for Play Console limit).

## 3) Store Listing Texts (English)

### Short description
Hair salon services, gallery, consultation and academy in one app.

Length: 66 characters.

### Full description
Ana Maria Studio brings premium hair services, expert consultation, and academy-level standards into one clear and elegant mobile experience.

Inside the app you can:
- Explore signature services and specialist treatments.
- View consultation options before advanced transformations.
- Browse gallery categories for colours, hairstyles and inspiration.
- Access academy pathways and professional course information.
- Add Reiki as an optional wellness complement to your visit.
- Contact the studio quickly via WhatsApp and phone.
- Open location details and maps for easy arrival.

This app is designed for clients who want clarity, quality and confidence before booking, and for professionals who value technique, hair integrity and long-term results.

Ana Maria Studio & Academy
541 High Road, Leytonstone, London E11 4PB

## 4) Console Completion Checklist (Production)

1. Go to Release > Production > Create new release.
2. Upload app-release.aab.
3. Set release name: 1.0.1 (2) - Production.
4. Paste "What's new" text.
5. Save and run pre-launch checks.
6. Resolve policy warnings (if any).
7. Review and roll out to Production.

## 5) Required Sections You Must Confirm Before Publish

- App content:
  - Privacy policy URL
  - App access (if restricted content exists)
  - Ads declaration
  - Target audience and content
  - News app declaration (if applicable)
- Data safety:
  - Confirm exactly what data is collected/shared by the live app and connected services.
  - Firebase Storage is used for gallery content delivery; complete declarations accordingly.
- Content rating:
  - Complete questionnaire and ensure rating matches app content.

## 6) Safe Rollout Strategy

- Recommended first rollout: 20%
- Monitor crashes/ANRs/reviews for 2-4 hours.
- If stable, increase to 50%.
- If still stable, complete to 100%.

## 7) Immediate Post-Release QA

- Install from Play (internal tester account or production account if available).
- Validate:
  - Home navigation
  - Signature services pages
  - Gallery loading (internet required for remote gallery feed)
  - Contact/WhatsApp links
  - Location maps open correctly
