import 'package:flutter/material.dart';
import 'package:testshape/ui/components/eyes.clipper.dart';
import 'package:testshape/ui/components/eyes.painter.dart';

class EyeWidget extends StatelessWidget {
  const EyeWidget({
    Key? key,
    required this.eyePosition,
    required this.eyeSize,
    required this.verticalClosure,
    required this.irisAngle,
    required this.eyeAngle,
    required this.irisPosition,
  }) : super(key: key);
  final Offset eyePosition;
  final Size eyeSize;
  final double verticalClosure;
  final double eyeAngle;
  final double irisAngle;
  final Offset irisPosition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      //position de l'œil
      top: eyePosition.dy,
      left: eyePosition.dx,
      //inclinaison de l'œil
      child: Transform.rotate(
        angle: eyeAngle,
        //clip du stack pour éviter que la paupière déborde sur les côté
        child: ClipOval(
          clipper: const EyeClipper(),
          child: Stack(
            children: [
              //contour
              EyeShapeWidget(eyeSize: eyeSize),
              //iris
              IrisWidget(
                  irisPosition: irisPosition,
                  eyeSize: eyeSize,
                  irisAngle: irisAngle),
              //paupière
              PaupiereWidget(
                  verticalClosure: verticalClosure, eyeSize: eyeSize),
            ],
          ),
        ),
      ),
    );
  }
}

class PaupiereWidget extends StatelessWidget {
  const PaupiereWidget({
    Key? key,
    required this.verticalClosure,
    required this.eyeSize,
  }) : super(key: key);

  final double verticalClosure;
  final Size eyeSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      //c'est cette variable qui gère l'ouverture et la fermeture de l'œil
      height: verticalClosure,
      width: eyeSize.width / 2,
      decoration: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
    );
  }
}

class IrisWidget extends StatelessWidget {
  const IrisWidget({
    Key? key,
    required this.irisPosition,
    required this.eyeSize,
    required this.irisAngle,
  }) : super(key: key);

  final Offset irisPosition;
  final Size eyeSize;
  final double irisAngle;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: irisPosition.dy,
      left: irisPosition.dx,
      child: CustomPaint(
        size: eyeSize / 6,
        painter: EyeBackGroundPainter(
          angle: irisAngle,
          backgroundColor: Colors.deepPurple,
          borderColor: Colors.deepPurple,
        ),
      ),
    );
  }
}

class EyeShapeWidget extends StatelessWidget {
  const EyeShapeWidget({
    Key? key,
    required this.eyeSize,
  }) : super(key: key);

  final Size eyeSize;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: eyeSize,
      painter: EyeBackGroundPainter(
        backgroundColor: Colors.white,
        borderColor: Colors.deepPurple,
      ),
    );
  }
}
