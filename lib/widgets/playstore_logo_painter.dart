import 'package:flutter/material.dart';

class PlayStoreLogo extends StatelessWidget {
  final double size;

  const PlayStoreLogo({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: PlayStorePainter());
  }
}

class PlayStorePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Draw Google Play icon paths
    // Point A (left tip): (0, h*0.05)
    // Point B (right tip): (w, h*0.5)
    // Point C (left bottom): (0, h*0.95)
    // Intersection points to divide the triangle:
    // Left Blue block: Polygon (0, h*0.05) -> (w*0.5, h*0.5) -> (0, h*0.95)
    // Top Red block: Polygon (0, h*0.05) -> (w, h*0.5) -> (w*0.5, h*0.5)
    // Bottom Green block: Polygon (0, h*0.95) -> (w*0.5, h*0.5) -> (w, h*0.5)
    // Right Yellow block: Polygon (w*0.5, h*0.5) -> (w*0.8, h*0.35) -> (w, h*0.5) -> (w*0.8, h*0.65) - wait,
    // Google play actually is:
    // Triangular shape.
    // Left blue side: Path from top-left, bottom-left, to center-right.
    // Red side: Top-left to top-right to center.
    // Green side: Bottom-left to bottom-right to center.
    // Yellow side: Right-most triangle.

    // Let's paint them accurately:
    final Paint paint = Paint()..style = PaintingStyle.fill;

    // 1. Blue Polygon
    final Path bluePath = Path();
    bluePath.moveTo(w * 0.08, h * 0.08);
    bluePath.lineTo(w * 0.52, h * 0.5);
    bluePath.lineTo(w * 0.08, h * 0.92);
    bluePath.close();
    paint.color = const Color(0xFF00C3FF);
    canvas.drawPath(bluePath, paint);

    // 2. Red Polygon
    final Path redPath = Path();
    redPath.moveTo(w * 0.08, h * 0.08);
    redPath.lineTo(w * 0.82, h * 0.5);
    redPath.lineTo(w * 0.52, h * 0.5);
    redPath.close();
    paint.color = const Color(0xFFFF334B);
    canvas.drawPath(redPath, paint);

    // 3. Green Polygon
    final Path greenPath = Path();
    greenPath.moveTo(w * 0.08, h * 0.92);
    greenPath.lineTo(w * 0.52, h * 0.5);
    greenPath.lineTo(w * 0.82, h * 0.5);
    greenPath.close();
    paint.color = const Color(0xFF00E676);
    canvas.drawPath(greenPath, paint);

    // 4. Yellow Polygon (pointing left from right tip)
    final Path yellowPath = Path();
    yellowPath.moveTo(w * 0.52, h * 0.5);
    yellowPath.lineTo(w * 0.82, h * 0.5);
    yellowPath.lineTo(w * 0.92, h * 0.5); // Rightmost tip
    // Actually the right yellow triangle overlaps:
    // Let's map it accurately:
    // Left blue: x=0.08,y=0.08 to x=0.52,y=0.5 to x=0.08,y=0.92
    // Top red: x=0.08,y=0.08 to x=0.78,y=0.36 to x=0.52,y=0.5
    // Bottom green: x=0.08,y=0.92 to x=0.52,y=0.5 to x=0.78,y=0.64
    // Right yellow: x=0.52,y=0.5 to x=0.78,y=0.36 to x=0.92,y=0.5 to x=0.78,y=0.64
    final Path yellowPathCorrect = Path();
    yellowPathCorrect.moveTo(w * 0.52, h * 0.5);
    yellowPathCorrect.lineTo(w * 0.78, h * 0.36);
    yellowPathCorrect.lineTo(w * 0.92, h * 0.5);
    yellowPathCorrect.lineTo(w * 0.78, h * 0.64);
    yellowPathCorrect.close();
    paint.color = const Color(0xFFFFD600);
    canvas.drawPath(yellowPathCorrect, paint);

    // Redraw overlapping parts cleanly:
    final Path redPathCorrect = Path();
    redPathCorrect.moveTo(w * 0.08, h * 0.08);
    redPathCorrect.lineTo(w * 0.78, h * 0.36);
    redPathCorrect.lineTo(w * 0.52, h * 0.5);
    redPathCorrect.close();
    paint.color = const Color(0xFFFF334B);
    canvas.drawPath(redPathCorrect, paint);

    final Path greenPathCorrect = Path();
    greenPathCorrect.moveTo(w * 0.08, h * 0.92);
    greenPathCorrect.lineTo(w * 0.52, h * 0.5);
    greenPathCorrect.lineTo(w * 0.78, h * 0.64);
    greenPathCorrect.close();
    paint.color = const Color(0xFF00E676);
    canvas.drawPath(greenPathCorrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
