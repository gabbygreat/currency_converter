import 'package:currency_converter/utils/utils.dart';

class CircleGradient extends StatelessWidget {
  const CircleGradient({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Positioned(
      left: -200,
      top: -(screenSize.height / 4),
      child: CustomPaint(
        painter: GradientPainter(
          colors: [Color(0xFFEAEAFE), Color(0x00DDF6F3)],
        ),
      ),
    );
  }
}

class GradientPainter extends CustomPainter {
  final List<Color> colors;
  GradientPainter({required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final circleSize = 751.0;
    final center = Offset(circleSize / 2, circleSize / 2);
    final radius = circleSize / 2;

    final paint = Paint()
      ..shader = RadialGradient(
        colors: colors,
        center: Alignment.center,
        radius: 1.0,
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
