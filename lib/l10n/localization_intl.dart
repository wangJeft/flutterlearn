import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class DemoLocalizations2 {
  static Future<DemoLocalizations2> load(Locale locale) {
    final String name =
        locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return DemoLocalizations2();
    });
  }

  static DemoLocalizations2 of(BuildContext context) {
    return Localizations.of<DemoLocalizations2>(context, DemoLocalizations2)!;
  }

  String get title {
    return Intl.message(
      'Flutter APP 2',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }

  remainingEmailsMessage(int howMany) => Intl.plural(howMany,
      zero: 'There are no emails left',
      one: 'There is $howMany email left',
      other: 'There are $howMany emails left',
      name: "remainingEmailsMessage",
      args: [howMany],
      desc: "How many emails remain after archiving.",
      examples: const {'howMany': 42, 'userName': 'Fred'});

}

class DemoLocalizationsDelegate2
    extends LocalizationsDelegate<DemoLocalizations2> {
  const DemoLocalizationsDelegate2();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations2> load(Locale locale) {
    return DemoLocalizations2.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<DemoLocalizations2> old) =>
      false;
}
