import 'package:flutter/material.dart';
import 'package:harvest_driver/helpers/constants.dart';

import '../shared_perfs_provider.dart';


enum Locales { ar, en }

class LangProvider {
  bool hasLocale() {
    PreferenceUtils prefs = PreferenceUtils.instance;
    String localeName = prefs.getValueWithKey(Constants.langKey, hideDebugPrint: true);
    return localeName != null && localeName != '';
  }

  Future setLocale({@required Locales locale}) async {
    PreferenceUtils prefs = PreferenceUtils.instance;
    switch (locale) {
      case Locales.ar:
        await prefs.saveValueWithKey(Constants.langKey, 'ar');
        break;
      case Locales.en:
        await prefs.saveValueWithKey(Constants.langKey, 'en');
        break;
    }
  }

  String getLocaleCode() {
    PreferenceUtils prefs = PreferenceUtils.instance;
    String localeCode = prefs.getValueWithKey(Constants.langKey);
    if (localeCode != null && localeCode != '') {
      return localeCode;
    } else {
      return 'en';
    }
  }
}
