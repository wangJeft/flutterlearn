import 'package:provider/provider.dart';

import '../index.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false;
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool _namedAutoFocus = true;
  final String defaultPwd =
      "";

  @override
  void initState() {
    _nameController.text = Global.profile.lastLogin ?? "";
    _pwdController.text = defaultPwd;
    if (_nameController.text.isNotEmpty) {
      _namedAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(gm.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autofocus: _namedAutoFocus,
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: gm.userName,
                    hintText: gm.userName,
                    prefixIcon: const Icon(Icons.person)),
                validator: (value) {
                  return value == null || value.trim().isNotEmpty
                      ? null
                      : gm.userNameRequired;
                },
              ),
              TextFormField(
                controller: _pwdController,
                autofocus: !_namedAutoFocus,
                decoration: InputDecoration(
                  labelText: gm.password,
                  hintText: gm.password,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    },
                    icon:
                        Icon(pwdShow ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
                obscureText: !pwdShow,
                validator: (value) => value == null || value.trim().isNotEmpty
                    ? null
                    : gm.passwordRequired,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ElevatedButton(
                  onPressed: () {
                    _onLogin();
                  },
                  child: Text(gm.login),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      User? user;
      try {
        user =
            await Git(context).login(_nameController.text, _pwdController.text);
        if (context.mounted) {
          Provider.of<UserModel>(context, listen: false).user = user;
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          if (context.mounted) {
            showToast(GmLocalizations.of(context).userNameOrPasswordWrong);
          }
        } else {
          showToast(e.toString());
        }
      } finally {
        // 隐藏loading框
        if (context.mounted) Navigator.of(context).pop();
      }
      if (user != null) {
        //登录成功则返回
        if (context.mounted) Navigator.of(context).pop();
      }
    }
  }
}
