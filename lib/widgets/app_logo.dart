import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  final double? width;
  final bool showText;
  final double fontSize;
  final bool useWhiteBackground;

  const AppLogo({
    super.key,
    this.height = 48,
    this.width,
    this.showText = true,
    this.fontSize = 20,
    this.useWhiteBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final double computedHeight = height ?? 48;
    final double iconSize = useWhiteBackground
        ? computedHeight - 20
        : computedHeight;

    Widget logoIcon = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/images/logo.png',
        height: iconSize,
        width: iconSize,
        fit: BoxFit.contain,
      ),
    );

    Widget logoText = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Fuel',
          style: GoogleFonts.sora(
            color: useWhiteBackground ? const Color(0xFF0F172A) : Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.8,
          ),
        ),
        Text(
          'Dost',
          style: GoogleFonts.sora(
            color: const Color(0xFF22C55E),
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
        ),
      ],
    );

    Widget logoContent = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logoIcon,
        if (showText) ...[const SizedBox(width: 12), logoText],
      ],
    );

    if (useWhiteBackground) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        ),
        child: logoContent,
      );
    }

    return Container(
      constraints: BoxConstraints(
        maxHeight: computedHeight,
        maxWidth: width ?? 220,
      ),
      child: logoContent,
    );
  }
}
