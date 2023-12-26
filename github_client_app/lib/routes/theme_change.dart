import 'package:provider/provider.dart';

import '../index.dart';

class ThemeChangeRout extends StatelessWidget {
  const ThemeChangeRout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeModel>(context).theme,
        title: Text(GmLocalizations.of(context).theme),
      ),
      body: ListView(
        children: Global.themes
            .map((e) => GestureDetector(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    child: Container(
                      color: e,
                      height: 40,
                    ),
                  ),
                  onTap: () {
                    Provider.of<ThemeModel>(context, listen: false).theme = e;
                  },
                ))
            .toList(),
      ),
    );
  }
}
