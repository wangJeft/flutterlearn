import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DemoLocalizations {
  DemoLocalizations(this.isZh);

  bool isZh = false;

  static DemoLocalizations of(BuildContext context) {
    return  Localizations.of<DemoLocalizations>(context, DemoLocalizations)!;
  }

  String get title {
    return isZh ? "Flutter应用" : "Flutter App";
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {

  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    print('$locale');
    return SynchronousFuture<DemoLocalizations>(
        DemoLocalizations(locale.languageCode == "zh"));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<DemoLocalizations> old) =>
      false;
}
