import 'package:flutter/material.dart';
import 'package:testshape/eyes.dart';

void main() {
  runApp(const EyeApp());
}

class EyeApp extends StatelessWidget {
  const EyeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eye Animation',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Eye animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool closed = false;
  double verticalClosure = 0;
  int animationDuration = 300;
  final Size eyeSize = const Size(300, 300);
  late final AnimationController _aController;
  late final Animation<double> _eyeAnimation;

  void _animate() {
    if (!closed) {
      _aController.forward();
      setState(() {
        closed = true;
      });
      return;
    }
    _aController.reverse();
    setState(() {
      closed = false;
    });
  }

  @override
  void initState() {
    _aController = AnimationController(
        vsync: this, duration: Duration(milliseconds: animationDuration));
    _eyeAnimation = Tween<double>(begin: 0, end: eyeSize.height).animate(
      CurvedAnimation(
        parent: _aController,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    )..addListener(() {
        setState(() {
          verticalClosure = _eyeAnimation.value;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: eyeSize.width / 2,
              child: Transform.rotate(
                angle: 12.60,
                child: ClipOval(
                  clipper: const EyeClipper(),
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: eyeSize,
                        painter: EyeBackGroundPainter(
                          backgroundColor: Colors.white,
                          borderColor: Colors.deepPurple,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 50,
                        child: CustomPaint(
                          size: eyeSize / 6,
                          painter: EyeBackGroundPainter(
                            angle: 12.60,
                            backgroundColor: Colors.deepPurple,
                            borderColor: Colors.deepPurple,
                          ),
                        ),
                      ),
                      Container(
                        height: verticalClosure,
                        width: eyeSize.width / 2,
                        decoration: const BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 0,
              child: Transform.rotate(
                angle: 12.50,
                child: ClipOval(
                  clipper: const EyeClipper(),
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: eyeSize,
                        painter: EyeBackGroundPainter(
                          backgroundColor: Colors.white,
                          borderColor: Colors.deepPurple,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 70,
                        child: CustomPaint(
                          size: eyeSize / 6,
                          painter: EyeBackGroundPainter(
                            angle: 12.45,
                            backgroundColor: Colors.deepPurple,
                            borderColor: Colors.deepPurple,
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          height: verticalClosure,
                          width: eyeSize.width / 2,
                          decoration: const BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animate,
        tooltip: 'Animate',
        child: closed
            ? const Icon(Icons.arrow_upward)
            : const Icon(Icons.arrow_downward),
      ),
    );
  }
}
