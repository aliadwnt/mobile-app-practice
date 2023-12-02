import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(Smartphone());
}

class Smartphone extends StatelessWidget {
  const Smartphone({Key? key}) : super(key: key);

  static const String _title = 'Tugas VIII';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  MyStatefulWidgetState createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat();

  bool _currentState = false;
  bool _reverse = true;

  void toggleAnimation() {
    setState(() {
      _reverse = !_reverse;
      if (_reverse) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  void toggleRotation() {
    print(_currentState);
    setState(() {
      _currentState = !_currentState;
      if (_currentState == true) {
        controller.stop();
      } else {
        controller.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alia Dewanto"),
        backgroundColor: Color.fromARGB(255, 56, 96, 228),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: toggleAnimation,
              child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: controller.value * 2.0 * math.pi,
                    child: CircleAvatar( // Change to CircleAvatar
                      radius: 100,
                      backgroundImage: AssetImage('lib/Assets/Img/leo.jpg'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onDoubleTap: toggleRotation,
              child: ClipOval(
                child: Container(
                  width: 78.0,
                  height: 78.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 56, 96, 228),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _currentState ? Icons.play_arrow : Icons.stop_circle,
                        color: Colors.white, // Set the icon color to white
                      ),
                      Text(
                        _currentState ? 'Putar' : 'Stop',
                        style: TextStyle(color: Colors.white), // Set the text color to white
                      
                  ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
