import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text("Basic Layout"),
backgroundColor: Colors.red,
leading: IconButton(
icon: Icon(Icons.home), // Ikon Home
onPressed: () {
// Tambahkan fungsi untuk navigasi ke halaman utama
},
),
actions: [
IconButton(
icon: Icon(Icons.search), // Ikon Search
onPressed: () {
// Tambahkan fungsi untuk pencarian
},
),
],
),
body: Container(
color: Colors.amber[100],
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: <Widget>[
Container(
color: Colors.orange[800],
height: 100,
width: 40,
child: Center(
child: Text('1', style: TextStyle(color: Colors.white))),
),
Transform.translate(
offset: Offset(0, 0),
child: Row(
children: [
Container(
color: Colors.blue,
height: 50,
width: 50,
child: Center(
child:
Text('2', style: TextStyle(color: Colors.white))),
),
Container(
color: Colors.green,
height: 50,
width: 50,
child: Center(
child:
Text('3', style: TextStyle(color: Colors.white))),
),
Container(
color: Colors.red,
height: 50,
width: 50,
child: Center(
child:
Text('4', style: TextStyle(color: Colors.white))),
),
],
),
),
Transform.translate(
offset: Offset(0, 10),
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Container(
color: Colors.purple,
height: 50,
width: 50,
child: Center(
child:
Text('5', style: TextStyle(color: Colors.white))),
),
Expanded(
child: Container(
color: Colors.yellow,
height: 50,
child: Center(
child:
Text('6', style: TextStyle(color: Colors.white))),
),
),
Container(
color: Colors.teal,
height: 50,
width: 50,
child: Center(
child:
Text('7', style: TextStyle(color: Colors.white))),
),
],
),
),
Transform.translate(
offset: Offset(0, 10),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
Container(
color: Colors.indigo,
height: 80,
width: 80,
child: Center(
child:
Text('8', style: TextStyle(color: Colors.white))),
),
Container(
color: Colors.cyan,
height: 50,
width: 50,
child: Center(
child:
Text('9', style: TextStyle(color: Colors.white))),
),
Container(
color: Colors.deepOrange,
height: 80,
width: 80,
child: Center(
child:
Text('10', style: TextStyle(color: Colors.white))),
),
],
),
),
Icon(
Icons.local_pizza, // Ubah ikon sesuai kebutuhan Anda
size: 60, // Sesuaikan ukuran ikon sesuai kebutuhan Anda
color: Color.fromARGB(255, 34, 174, 52), // Sesuaikan warna ikon sesuai kebutuhan Anda
)
],
),
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
