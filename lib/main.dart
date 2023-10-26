import 'package:flutter/material.dart';
import 'package:flutterlearn/state_manager.dart';

void main() {
  runApp(const MyApp());
  // runApp(const StateLifecycleTest());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learn',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const CounterWidget(),
      // home: const TapBoxA(),
      // home: const ParentWidget(),
      home: const ParentWidgetC(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _CardPage();
}

class StateLifecycleTest extends StatelessWidget {
  const StateLifecycleTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterWidget(),
      // home: Text("data"),
    );
  }
}

//State生命周期
class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key, this.initValue = 0});

  final int initValue;

  @override
  State<StatefulWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  @override
  void initState() {
    _counter = widget.initValue;
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('$_counter'),
          onPressed: () => setState(() {
            ++_counter;
          }),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}

class _CardPage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: _buildCard(),
        ));
  }

  Widget _buildCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  "1625 Main street",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: const Text('My City, Ca 99984'),
                leading: Icon(
                  Icons.restaurant_menu,
                  color: Colors.blue[500],
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  "(408) 555-1212",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Icon(
                  Icons.contact_phone,
                  color: Colors.blue[500],
                ),
              ),
              ListTile(
                title: const Text(
                  "costa@example.com",
                ),
                leading: Icon(
                  Icons.contact_mail,
                  color: Colors.blue[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StackPage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: _buildStack(),
        ));
  }

  Widget _buildStack() {
    return Stack(
      alignment: const Alignment(0.6, 0.6),
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("images/mc.png"),
          radius: 100,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.black45,
          ),
          child: const Text(
            "Mia b",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class _ListViewPage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: _buildList(),
        ));
  }

  Widget _buildList() {
    return ListView(
      children: [
        _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
        _tile('The Castro Theater', '85 W Portal Ave', Icons.theaters),
        _tile('Alamo Drafthouse Cinema', '85 W Portal Ave', Icons.theaters),
        _tile('United Artists Stonestown Twin', '85 W Portal Ave',
            Icons.theaters),
        _tile('Roxie Theater', '3117 16th St', Icons.theaters),
        _tile('AMC Metreon 16', '85 W Portal Ave', Icons.theaters),
        _tile('K\'s Kitchen', '85 W Portal Ave', Icons.restaurant),
        _tile('Emmy\'s Restaurant', '85 W Portal Ave', Icons.restaurant),
        _tile('Chaiya Thai Restaurant', '85 W Portal Ave', Icons.restaurant),
        _tile('La Ciccia', '85 W Portal Ave', Icons.restaurant),
      ],
    );
  }

  ListTile _tile(String title, String subtitle, IconData iconData) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      ),
      subtitle: Text(subtitle),
      leading: Icon(
        iconData,
        color: Colors.blue[500],
      ),
    );
  }
}

class _GridViewPage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: _buildGrid(),
        ));
  }

  Widget _buildGrid() => GridView.extent(
        maxCrossAxisExtent: 150,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridTileList(30),
      );

  List<Container> _buildGridTileList(int count) => List.generate(
      count,
      (index) => Container(
            child: Image.asset("images/bg_4.png"),
          ));
}

class _ContainerPage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(color: Colors.black26),
            child: Column(
              children: [_buildImageRow(1), _buildImageRow(3)],
            ),
          ),
        ));
  }

  Widget _buildDecoratedImage(int imageIndex) => Expanded(
          child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.blueGrey),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        margin: const EdgeInsets.all(4),
        child: Image.asset(
          "images/bg_4.png",
          fit: BoxFit.fill,
        ),
      ));

  Widget _buildImageRow(int imageIndex) => Row(
        children: [
          _buildDecoratedImage(imageIndex),
          _buildDecoratedImage(imageIndex + 1)
        ],
      );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Hello World"),
            Icon(
              Icons.star,
              color: Colors.red[300],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("images/weather.png", fit: BoxFit.fill),
                Image.asset("images/weather.png", fit: BoxFit.fill),
                Image.asset("images/weather.png", fit: BoxFit.fill),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Image.asset(
                  "images/weather.png",
                )),
                Expanded(
                    flex: 2,
                    child: Image.asset(
                      "images/weather.png",
                    )),
                Expanded(
                    child: Image.asset(
                  "images/weather.png",
                )),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.green[500],
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.green[500],
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.green[500],
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.black,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const Text(
                    "170 Reviews",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Roboto",
                        letterSpacing: 0.5,
                        fontSize: 20),
                  )
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
