import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:ana_maria_studio/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('all green menu buttons open their pages', (tester) async {
    await tester.pumpWidget(const AnaMariaApp());
    await tester.pumpAndSettle();

    final checks = <({String menuLabel, String pageTitle})>[
      (menuLabel: 'Signature services', pageTitle: 'Signature services'),
      (menuLabel: 'Academy', pageTitle: 'Academy'),
      (menuLabel: 'Fast consultation', pageTitle: 'Consultation'),
      (menuLabel: 'Reiki', pageTitle: 'Reiki'),
      (menuLabel: 'Gallery', pageTitle: 'Gallery'),
      (menuLabel: 'Location', pageTitle: 'Location'),
      (menuLabel: 'Contact', pageTitle: 'Contact'),
      (menuLabel: 'About', pageTitle: 'About'),
      (menuLabel: 'Prices & policy', pageTitle: 'Prices & policy'),
    ];

    for (final check in checks) {
      final menuFinder = find.text(check.menuLabel).first;
      await tester.ensureVisible(menuFinder);
      await tester.tap(menuFinder);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text(check.pageTitle), findsWidgets,
          reason: 'Page title not found for menu: ${check.menuLabel}');

      final backFinder = find.text('Back').first;
      await tester.ensureVisible(backFinder);
      await tester.tap(backFinder);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    }
  });
}
