import 'package:cutfx_salon/screens/welcome/welcome_screen.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(
    const RestartWidget(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('ar'),
        Locale('da'),
        Locale('de'),
        Locale('el'),
        Locale('es'),
        Locale('fr'),
        Locale('hi'),
        Locale('id'),
        Locale('it'),
        Locale('ja'),
        Locale('ka'),
        Locale('ko'),
        Locale('nb'),
        Locale('nl'),
        Locale('pl'),
        Locale('pt'),
        Locale('ru'),
        Locale('th'),
        Locale('tr'),
        Locale('vi'),
        Locale('zh')
      ],
      debugShowCheckedModeBanner: false,
      locale: Locale(SharePref.selectedLanguage),
      title: 'Cutfx Salon',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorRes.white,
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            color: ColorRes.white,
          ),
          displayLarge: TextStyle(
            color: ColorRes.white,
          ),
          displayMedium: TextStyle(
            color: ColorRes.white,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(surface: ColorRes.white),
      ),
      home: const WelComeScreen(),
    );
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
