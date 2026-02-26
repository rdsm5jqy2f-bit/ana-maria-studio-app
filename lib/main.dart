import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/app_config.dart';
import 'firebase_options.dart';
import 'home_page.dart';
// import 'pink_test_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (_) {
    // Firebase is optional for now; app continues with local gallery assets.
  }

  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  runApp(const AnaMariaApp());
}

class AnaMariaApp extends StatelessWidget {
  const AnaMariaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ana Maria Hair Studio & Academy',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: const Color(0xFFC9A227),
          displayColor: const Color(0xFFC9A227),
        ),
      ),
      home: HomePage(),
    );
  }
}
