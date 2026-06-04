import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/strings.dart';
import '../widgets/screenshot_mockup.dart';
import '../widgets/interactive_3d_phone.dart';
import '../widgets/playstore_button.dart';
import '../widgets/app_logo.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onLearnMoreTap;

  const HeroSection({super.key, required this.onLearnMoreTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1024;
    final double sidePadding = width > 1200 ? 60 : 24;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 120,
        bottom: 40,
        left: sidePadding,
        right: sidePadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B7A3E).withValues(alpha: 0.25),
            blurRadius: 60,
            offset: const Offset(0, 30),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          // Background Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                AppStrings.heroCoverImage,
                fit: BoxFit.cover,
                alignment: isDesktop ? Alignment.centerRight : Alignment.center,
              ),
            ),
          ),

          // Gradient overlay for text readability
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF062010).withOpacity(0.9),
                      const Color(0xFF062010).withOpacity(0.4),
                      Colors.transparent,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ),

          // Animated Particle Background
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: AnimatedBuilder(
                animation: _particleController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ParticleBackgroundPainter(_particleController.value),
                  );
                },
              ),
            ),
          ),

          // Grid overlay (subtle)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: CustomPaint(
                painter: _GridPainter(),
              ),
            ),
          ),

          // Main content
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isDesktop ? 90.0 : 60.0,
              horizontal: isDesktop ? 56.0 : 28.0,
            ),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 5, child: _buildLeftContent(context)),
                      const SizedBox(width: 48),
                      const Expanded(flex: 5, child: SizedBox()), // Keeps right side of background clear
                    ],
                  )
                : Column(
                    children: [
                      _buildLeftContent(context),
                      const SizedBox(height: 240), // Space to see the background illustration on mobile
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftContent(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // App Logo
        const AppLogo(
          useWhiteBackground: false,
          height: 60,
          fontSize: 28,
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad),
        const SizedBox(height: 28),

        // Main headline
        Text(
          'Know Your Fuel Cost\nBefore You Leave Home',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.sora(
            fontSize: isMobile ? 38 : 64,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.12,
            letterSpacing: -1.5,
          ),
        )
            .animate()
            .fadeIn(delay: 150.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad),
        const SizedBox(height: 20),

        // Subtext
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            "India's smartest fuel cost calculator. Plan routes, set custom vehicle mileage, track expenses offline, and optimize your trips — no internet needed.",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.dmSans(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.65,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad),
        const SizedBox(height: 40),

        // CTA — Google Play badge image + Learn More
        Wrap(
          spacing: 20,
          runSpacing: 16,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // Premium Play Store badge
            const PlayStoreButton(
              height: 68,
              width: 220,
            )
                .animate()
                .fadeIn(delay: 450.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad),

            // Learn More outline button
            OutlinedButton(
              onPressed: widget.onLearnMoreTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.5), width: 2.0),
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: Text(
                'See Features ↓',
                style: GoogleFonts.dmSans(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 550.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad),
          ],
        ),

        const SizedBox(height: 48),

        // Trust badges row
        Wrap(
          spacing: 24,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildTrustBadge(Icons.star_rounded, '4.8★ Rating'),
            _buildTrustBadge(Icons.signal_wifi_off_rounded, 'Works Offline'),
            _buildTrustBadge(Icons.lock_outline_rounded, 'No Account'),
          ],
        )
            .animate()
            .fadeIn(delay: 650.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildTrustBadge(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF4ADE80), size: 18),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.dmSans(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFallbackPlayButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('GET IT ON',
                  style: GoogleFonts.dmSans(
                      color: Colors.white60,
                      fontSize: 11,
                      letterSpacing: 1.0)),
              Text('Google Play',
                  style: GoogleFonts.sora(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightContent(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double size = min(constraints.maxWidth, 520);
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Interactive3DPhone(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  AppStrings.heroAppImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    )
        .animate()
        .fadeIn(duration: 900.ms)
        .scale(
            begin: const Offset(0.9, 0.9),
            curve: Curves.easeOutBack,
            duration: 1000.ms);
  }
}

// Subtle dot-grid painter
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..style = PaintingStyle.fill;

    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ParticleBackgroundPainter extends CustomPainter {
  final double animationValue;

  ParticleBackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.045)
      ..style = PaintingStyle.fill;

    final random = Random(42);

    for (int i = 0; i < 35; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double radius = random.nextDouble() * 2.5 + 0.5;
      double speed = random.nextDouble() * 25 + 8;

      y = (y - animationValue * speed) % size.height;
      if (y < 0) y += size.height;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticleBackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
