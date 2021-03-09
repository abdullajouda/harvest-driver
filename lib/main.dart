import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:harvest_driver/helpers/shared_perfs_provider.dart';
import 'package:harvest_driver/splash.dart';
import 'package:provider/provider.dart';

import 'helpers/Localization/app_translations_delegate.dart';
import 'helpers/Localization/appliction.dart';
import 'helpers/Localization/lang_provider.dart';
import 'helpers/api.dart';
import 'helpers/persistent_tab_controller_provider.dart';
import 'helpers/variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;
  LangProvider _langProvider;

  void onLocaleChange(Locale locale) => setState(
      () => _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale));

  @override
  void initState() {
    application.onLocaleChanged = onLocaleChange;
    _newLocaleDelegate = AppTranslationsDelegate(
      newLocale: Locale('en', 'US'),
    );
    _langProvider = LangProvider();
    String code = _langProvider.getLocaleCode();
    _newLocaleDelegate = AppTranslationsDelegate(
      newLocale: Locale(code, code),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bool isArabic = _newLocaleDelegate.newLocale.languageCode == 'ar';
    // final _statusBarBrightness = context.watch<StatusBarBrighness>().brightness;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
        providers: [
          Provider(create: (context) => PTVController()),
          Provider(create: (context) => ApiHelper()),
        ],
        child: MaterialApp(
          supportedLocales: application.supportedLocales(),
          locale: _newLocaleDelegate.newLocale,
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            _newLocaleDelegate,
          ],
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Splash(),
        ));
  }
}
