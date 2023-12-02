import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Katalog Bunga Alia Dewanto'),
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {},
          ),
        ),
        body: FlowerListView(),
      ),
    );
  }
}

class FlowerListView extends StatefulWidget {
  @override
  _FlowerListViewState createState() => _FlowerListViewState();
}

class _FlowerListViewState extends State<FlowerListView> {
  final List<Map<String, dynamic>> bunga = [
    // Daftar bunga
    {"nama": "Matahari", "harga": "65000", "gambar": "assets/images/1.jpg"},
    {"nama": "Rose", "harga": "55000", "gambar": "assets/images/2.jpg"},
    {"nama": "Dahlia", "harga": "20000", "gambar": "assets/images/3.jpg"},
    {"nama": "Aster", "harga": "25000", "gambar": "assets/images/4.jpg"},
    {"nama": "Krisan", "harga": "35000", "gambar": "assets/images/5.jpg"},
    {"nama": "Lily", "harga": "40000", "gambar": "assets/images/6.jpg"},
    {"nama": "Anggrek", "harga": "35000", "gambar": "assets/images/7.jpg"},
    {"nama": "Jakaranda", "harga": "40000", "gambar": "assets/images/8.jpg"},
    {"nama": "Mawar", "harga": "55000", "gambar": "assets/images/9.jpg"},
    {"nama": "Melati", "harga": "50000", "gambar": "assets/images/10.jpg"},
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView.builder(
        itemCount: bunga.length,
        itemBuilder: (context, index) {
          final flower = bunga[index];
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(flower['gambar'],
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.15),
                        SizedBox(height: 8.0),
                        Image.asset(flower['gambar'],
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.15),
                        SizedBox(height: 8.0),
                        Image.asset(flower['gambar'],
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.15),
                      ],
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text(
                              flower['nama'],
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.grey),
                                Icon(Icons.star, color: Colors.grey),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              'Harga: ${flower['harga']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 0, 102, 255),
                              ),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: screenWidth * 0.3),
                      child: Image.asset(flower['gambar'],
                          height: screenHeight * 0.2),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
