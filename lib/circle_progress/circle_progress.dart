import 'package:flutter/material.dart';
import 'dart:math';

class CircleProgress extends StatefulWidget {
  final Color color;

  const CircleProgress({super.key, required this.color});

  @override
  State<CircleProgress> createState() => _CircleProgressState();
}

class _CircleProgressState extends State<CircleProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> indicatorAnimation;
  double value = 0;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    indicatorAnimation =
        Tween<double>(begin: 0, end: 100).animate(animationController)
          ..addListener(() {
            setState(() {
              value = indicatorAnimation.value;
            });
          });

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomPaint(
          foregroundPainter: SpinnerPainter(
              value: indicatorAnimation.value, color: widget.color),
          child: Center(
            child: Text(
              '${value.floor().toString()}%',
              style: TextStyle(
                  color: widget.color,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          )),
    );
  }
}


class SpinnerPainter extends CustomPainter {
  double value;
  Color color;
  
  SpinnerPainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final outlinePaint = Paint()
      ..color = color.withOpacity(0.1)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    Rect rect = Rect.fromCircle(center: center, radius: size.height / 2);
    canvas.drawArc(rect, pi * 1.5, 2 * pi * (value / 100), false, linePaint);
    canvas.drawCircle(center, size.width / 2, outlinePaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)  => false;

  
}
