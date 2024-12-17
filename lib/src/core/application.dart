import 'package:crush_app/src/core/i18n/l10n.dart';
import 'package:crush_app/src/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class Application extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  Application({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crush App',
      initialRoute: '/',
      navigatorKey: navigatorKey,
      routes: routes,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness:
            Brightness.light, // Ignore le thème sombre en le fixant à clair
      ),

      // darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: I18n.delegate.supportedLocales,
    );
  }
}
