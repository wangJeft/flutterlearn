import 'package:provider/provider.dart';

import '../index.dart';

class LanguageRoute extends StatelessWidget {
  const LanguageRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localeModel = Provider.of<LocaleModel>(context);
    var gm = GmLocalizations.of(context);
    Widget buildLanguageItem(String lan, value) {
      return ListTile(
        title: Text(
          lan,
          style: TextStyle(color: localeModel.locale == value ? color : null),
        ),
        trailing: localeModel.locale == value
            ? Icon(
                Icons.done,
                color: color,
              )
            : null,
        onTap: () {
          localeModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeModel>(context).theme,
        title: Text(gm.language),
      ),
      body: ListView(
        children: [
          buildLanguageItem("中文简体", "zh_CN"),
          buildLanguageItem("English", "en_US"),
          buildLanguageItem(gm.auto, null),
        ],
      ),
    );
  }
}
