import 'package:flutter/material.dart';
import 'package:testshape/ui/components/eyes.widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //oeil ouvert ou fermé
  bool closed = false;
  //variable pour la fermeture de la paupière
  double verticalClosure = 0;
  //durée de l'animation
  int animationDuration = 300;
  //taille du stack de l'œil

  final Size eyeSize = const Size(300, 300);
  late final AnimationController _aController;
  late final Animation<double> _eyeAnimation;

//animate avec le floatingactionbutton
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
    //controller
    _aController = AnimationController(
        vsync: this, duration: Duration(milliseconds: animationDuration));

    //animation de la paupière (on peut jouer avec la curve)
    _eyeAnimation = Tween<double>(begin: 0, end: eyeSize.height).animate(
      CurvedAnimation(
        parent: _aController,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    )..addListener(() {
        //change la valeur de verticalClosure à chaque tick de l'animation
        setState(() {
          verticalClosure = _eyeAnimation.value;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _aController.dispose();
    super.dispose();
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
            //œil droit
            EyeWidget(
              //taille
              eyeSize: eyeSize,
              //fermeture de la paupière
              verticalClosure: verticalClosure,
              //position
              eyePosition: Offset(eyeSize.width / 2, 0),
              //inclinaison de l'iris
              irisAngle: 12.60,
              //inclinaison de l'oeil
              eyeAngle: 12.60,
              //position de l'iris dans l'œil
              irisPosition: const Offset(50, 20),
            ),
            //oeil gauche
            EyeWidget(
              eyeSize: eyeSize,
              verticalClosure: verticalClosure,
              eyePosition: const Offset(20, -5),
              irisAngle: 12.45,
              eyeAngle: 12.45,
              irisPosition: const Offset(70, 25),
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
