import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'index.dart';

void main() {
  Global.init().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeModel()),
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (context, themeModel, localeModel, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(primarySwatch: themeModel.theme),
            onGenerateTitle: (context) {
              return GmLocalizations.of(context).title;
            },
            locale: localeModel.getLocale(),
            supportedLocales: const [Locale('en', 'US'), Locale('zh', 'CN')],
            localizationsDelegates: [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GmLocalizationsDelegate()
            ],
            localeResolutionCallback: (_locale, supportedLocales) {
              if (localeModel.getLocale() != null) {
                return localeModel.getLocale();
              } else {
                Locale? locale;
                if (supportedLocales.contains(_locale)) {
                  locale = _locale;
                } else {
                  locale = const Locale('en', 'US');
                }
                return locale;
              }
            },
            home: const HomeRoute(),
            routes: <String, WidgetBuilder>{
              "login": (context) => const LoginRoute(),
              "themes": (context) => const ThemeChangeRout(),
              "language": (context) => const LanguageRoute(),
            },
          );
        },
      ),
    );
  }
}
