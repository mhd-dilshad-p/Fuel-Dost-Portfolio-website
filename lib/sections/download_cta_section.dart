import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/app_logo.dart';
import '../widgets/playstore_button.dart';

class DownloadCtaSection extends StatelessWidget {
  const DownloadCtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;
    final double horizontalPadding = width > 1200
        ? (width - 1200) / 2 + 24
        : 24;

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 100,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.18),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              // 1. Premium Glowing Gradient Background
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF1B7A3E),
                        Color(0xFF0D4723),
                        Color(0xFF0F172A),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),

              // 2. Ambient Blur Glow (Orange Accent)
              Positioned(
                top: -100,
                left: -100,
                child:
                    Container(
                          width: 320,
                          height: 320,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(
                              0xFFF97316,
                            ).withValues(alpha: 0.2), // Soft Orange glow
                          ),
                        )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .custom(
                          duration: 4.seconds,
                          builder: (context, value, child) {
                            return ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 80 + value * 20,
                                sigmaY: 80 + value * 20,
                              ),
                              child: child,
                            );
                          },
                        ),
              ),

              // 3. Ambient Blur Glow (Light Green Accent)
              Positioned(
                bottom: -150,
                right: -100,
                child:
                    Container(
                          width: 420,
                          height: 420,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(
                              0xFF4ADE80,
                            ).withValues(alpha: 0.15), // Soft Green glow
                          ),
                        )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .custom(
                          duration: 5.seconds,
                          builder: (context, value, child) {
                            return ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 90 + value * 30,
                                sigmaY: 90 + value * 30,
                              ),
                              child: child,
                            );
                          },
                        ),
              ),

              // 4. Subtle Technical Grid Pattern Overlay
              Positioned.fill(
                child: CustomPaint(painter: GridPatternPainter()),
              ),

              // 5. Content Column
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 80,
                  horizontal: 32,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // App Icon with breathing pulse & outer glow
                      Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: const AppLogo(
                              height: 56,
                              showText: false,
                              useWhiteBackground: false,
                            ),
                          )
                          .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true),
                          )
                          .scale(
                            begin: const Offset(0.96, 0.96),
                            end: const Offset(1.04, 1.04),
                            duration: 2.seconds,
                            curve: Curves.easeInOut,
                          ),

                      const SizedBox(height: 36),

                      // Header Title
                      Text(
                        'Start Saving on Fuel Today',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sora(
                          color: Colors.white,
                          fontSize: isMobile ? 30 : 48,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.5,
                          height: 1.2,
                        ),
                      ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

                      const SizedBox(height: 18),

                      // Subtext with refined copy (corrected typo)
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 650),
                        child: Text(
                          'Calculate accurate fuel costs instantly, track your travel expenses privately, and save money on every drive. 100% offline-first, zero ads, no accounts required.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),
                      ).animate().fadeIn(delay: 350.ms, duration: 600.ms),

                      const SizedBox(height: 44),

                      // Premium Play Store Button
                      const PlayStoreButton(height: 68, width: 220)
                          .animate()
                          .fadeIn(delay: 500.ms, duration: 600.ms)
                          .scale(begin: const Offset(0.9, 0.9)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Background Grid Painter for that premium SaaS visual aesthetic
class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.035)
      ..strokeWidth = 1.0;

    const double spacing = 32.0;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
