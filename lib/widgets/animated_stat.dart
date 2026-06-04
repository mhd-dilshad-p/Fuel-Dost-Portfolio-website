import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedStat extends StatelessWidget {
  final double endValue;
  final String suffix;
  final String prefix;
  final String label;
  final Duration duration;

  const AnimatedStat({
    super.key,
    required this.endValue,
    this.suffix = '',
    this.prefix = '',
    required this.label,
    this.duration = const Duration(seconds: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: endValue),
          duration: duration,
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            String displayedValue;
            if (value >= 1000) {
              displayedValue = '${(value / 1000).toStringAsFixed(1)}K';
              // Remove .0 suffix if not needed
              if (displayedValue.endsWith('.0K')) {
                displayedValue = displayedValue.replaceAll('.0K', 'K');
              }
            } else {
              displayedValue = value.toInt().toString();
            }

            return Text(
              '$prefix$displayedValue$suffix',
              style: GoogleFonts.sora(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.dmSans(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
