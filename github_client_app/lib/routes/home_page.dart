import 'package:provider/provider.dart';

import '../index.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  static const _loadingTag = "##loading##";
  var _items = <Repo>[Repo()..name = _loadingTag];
  bool hasMore = true;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
      body: _buildBody(),
      drawer: const MyDrawer(),
    );
  }

  Widget _buildBody() {
    var userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return Center(
        child: ElevatedButton(
          child: Text(GmLocalizations.of(context).login),
          onPressed: () => Navigator.of(context).pushNamed("login"),
        ),
      );
    } else {
      return ListView.separated(
          itemBuilder: (context, index) {
            if (_items[index].name == _loadingTag) {
              if (hasMore) {
                _retrieveData();
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "没有更多了",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
            }
            return RepoItem(_items[index]);
          },
          separatorBuilder: (context, index) => const Divider(
                height: 0,
              ),
          itemCount: _items.length);
    }
  }

  void _retrieveData() async {
    var data = await Git(context)
        .getRepos(queryParameters: {'page': page, 'page_size': 20});
    hasMore = data.isNotEmpty && data.length % 20 == 0;
    setState(() {
      _items.insertAll(_items.length - 1, data);
      page++;
    });
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(child: _buildMenus()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
      builder: (context, value, child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipOval(
                    child: value.isLogin
                        ? gmAvatar(value.user!.avatar_url, width: 80)
                        : Image.asset(
                            "imgs/avatar-default.png",
                            width: 80,
                          ),
                  ),
                ),
                Text(
                  value.isLogin
                      ? value.user!.login
                      : GmLocalizations.of(context).login,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
          ),
          onTap: () {
            if (!value.isLogin) {
              Navigator.of(context).pushNamed("login");
            }
          },
        );
      },
    );
  }

  Widget _buildMenus() {
    return Consumer<UserModel>(
      builder: (context, value, child) {
        var gm = GmLocalizations.of(context);
        return ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(gm.theme),
              onTap: () => Navigator.pushNamed(context, "themes"),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(gm.language),
              onTap: () => Navigator.pushNamed(context, "language"),
            ),
            if (value.isLogin)
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: Text(gm.logout),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(gm.logoutTip),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(gm.logoutTip)),
                          TextButton(
                            onPressed: () {
                              value.user = null;
                              Navigator.pop(context);
                            },
                            child: Text(gm.yes),
                          )
                        ],
                      );
                    },
                  );
                },
              )
          ],
        );
      },
    );
  }
}
