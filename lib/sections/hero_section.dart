import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/strings.dart';
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
      duration: const Duration(seconds: 15),
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
    final double horizontalPadding = width > 1280
        ? (width - 1280) / 2 + 24
        : 24;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(
        horizontalPadding,
        100,
        horizontalPadding,
        40,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0A3319), // Deep rich forest green
            Color(0xFF135E2E), // Classic FuelDost brand emerald
            Color(0xFF0B3A1C), // Deep shadow edge
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B7A3E).withValues(alpha: 0.22),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Illustration image cover
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                AppStrings.heroCoverImage,
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
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
                      const Color(0xFF062010).withValues(alpha: 0.9),
                      const Color(0xFF062010).withValues(alpha: 0.4),
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
                    painter: ParticleBackgroundPainter(
                      _particleController.value,
                    ),
                  );
                },
              ),
            ),
          ),

          // Subtle dot matrix grid overlay
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: CustomPaint(painter: _GridPainter()),
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
                      const Expanded(
                        flex: 5,
                        child: SizedBox(),
                      ), // Keeps right side of background clear
                    ],
                  )
                : Column(
                    children: [
                      _buildLeftContent(context),
                      const SizedBox(
                        height: 240,
                      ), // Space to see the background illustration on mobile
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
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // App Logo Icon Brand Header
        Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLogo(
                  height: 48,
                  fontSize: 22,
                  useWhiteBackground: true,
                ),
                const SizedBox(width: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF97316).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFF97316).withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    'v1.0 LIVE',
                    style: GoogleFonts.dmSans(
                      color: const Color(0xFFFFA05C),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

        const SizedBox(height: 28),

        // Main Headline
        Text(
              'Know Your Fuel Cost Before You Leave Home.',
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              style: GoogleFonts.sora(
                fontSize: isMobile ? 32 : 50,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.15,
                letterSpacing: -1.0,
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

        const SizedBox(height: 20),

        // Subtitle
        Text(
              'Accurate trip fuel calculations, visual route planning, and vehicle expense tracking for commuters, cab drivers, and road-trippers across India.',
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              style: GoogleFonts.dmSans(
                fontSize: isMobile ? 16 : 18,
                color: Colors.white.withValues(alpha: 0.85),
                height: 1.6,
              ),
            )
            .animate()
            .fadeIn(delay: 350.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),

        const SizedBox(height: 36),

        // CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const PlayStoreButton()
                .animate()
                .fadeIn(delay: 500.ms, duration: 600.ms)
                .scale(
                  begin: const Offset(0.9, 0.9),
                  curve: Curves.easeOutBack,
                ),
            OutlinedButton(
                  onPressed: widget.onLearnMoreTap,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'See Features',
                        style: GoogleFonts.dmSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_downward_rounded, size: 16),
                    ],
                  ),
                )
                .animate()
                .fadeIn(delay: 600.ms, duration: 600.ms)
                .slideX(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          ],
        ),

        const SizedBox(height: 32),

        // Trust Badges
        Wrap(
          spacing: 24,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildTrustBadge(Icons.star_rounded, 'Verified Accurate'),
            _buildTrustBadge(Icons.wifi_off_rounded, 'Works Offline'),
            _buildTrustBadge(Icons.lock_outline_rounded, 'Privacy First'),
          ],
        ).animate().fadeIn(delay: 750.ms, duration: 600.ms),
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
