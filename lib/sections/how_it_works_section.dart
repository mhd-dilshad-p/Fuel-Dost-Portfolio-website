import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1024;
    final double horizontalPadding = width > 1200
        ? (width - 1200) / 2 + 32
        : 32;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              'SIMPLE & FAST',
              style: GoogleFonts.dmSans(
                color: AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'How to ',
                style: GoogleFonts.sora(
                  color: AppColors.textPrimary,
                  fontSize: width < 600 ? 36 : 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),
              Text(
                'Use',
                style: GoogleFonts.sora(
                  color: AppColors.primary,
                  fontSize: width < 600 ? 36 : 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 16),
          Text(
            'Calculate fuel cost in 3 easy steps',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              color: AppColors.textSecondary,
              fontSize: 18,
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 500.ms),
          const SizedBox(height: 80),

          // Grid layout for steps
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildStepCard(
                        context,
                        '01',
                        'Choose Start & Destination',
                        'Enter your start location and destination. FuelDost instantly maps out the path, determines the exact driving distance.',
                        AppStrings.howItWorksStep1,
                        0,
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: _buildStepCard(
                        context,
                        '02',
                        'Set Vehicle & Fuel Price',
                        'Select one of your vehicle profiles with custom city/highway mileage, and input the local fuel price in your city.',
                        AppStrings.howItWorksStep2,
                        1,
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: _buildStepCard(
                        context,
                        '03',
                        'Compare Cost & Save',
                        'Review your estimated trip cost instantly. Save the trip details directly to your secure on-device history log.',
                        AppStrings.howItWorksStep3,
                        2,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildStepCard(
                      context,
                      '01',
                      'Choose Start & Destination',
                      'Enter your start location and destination. FuelDost instantly maps out the path, determines the exact driving distance.',
                      AppStrings.howItWorksStep1,
                      0,
                    ),
                    const SizedBox(height: 40),
                    _buildStepCard(
                      context,
                      '02',
                      'Set Vehicle & Fuel Price',
                      'Select one of your vehicle profiles with custom city/highway mileage, and input the local fuel price in your city.',
                      AppStrings.howItWorksStep2,
                      1,
                    ),
                    const SizedBox(height: 40),
                    _buildStepCard(
                      context,
                      '03',
                      'Compare Cost & Save',
                      'Review your estimated trip cost instantly. Save the trip details directly to your secure on-device history log.',
                      AppStrings.howItWorksStep3,
                      2,
                    ),
                  ],
                ),

          const SizedBox(height: 120),

          // Bottom Info Bar
          _buildBottomHighlights(width, isDesktop),
        ],
      ),
    );
  }

  Widget _buildStepCard(
    BuildContext context,
    String number,
    String title,
    String desc,
    String imagePath,
    int index,
  ) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          Container(
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: (200 + (index * 100)).ms)
              .scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOut),
          const SizedBox(height: 40),
          // Step Number
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.sora(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ).animate().scale(
            delay: (300 + (index * 100)).ms,
            curve: Curves.easeOutBack,
          ),
          const SizedBox(height: 24),
          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.sora(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ).animate().fadeIn(delay: (400 + (index * 100)).ms),
          const SizedBox(height: 16),
          // Description
          Text(
            desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              color: AppColors.textSecondary,
              fontSize: 16,
              height: 1.6,
            ),
          ).animate().fadeIn(delay: (500 + (index * 100)).ms),
        ],
      ),
    );
  }

  Widget _buildBottomHighlights(double width, bool isDesktop) {
    Widget privateSecureCol = Expanded(
      flex: isDesktop ? 1 : 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '100% Private & Secure',
                  style: GoogleFonts.sora(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "All your data is stored securely on your device. We don't collect or share any personal information.",
                  style: GoogleFonts.dmSans(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget worksOfflineCol = Expanded(
      flex: isDesktop ? 1 : 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wifi_off_rounded,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Works Offline',
                  style: GoogleFonts.sora(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'No internet needed. Use anywhere, anytime! Perfect for road trips and weak network areas.',
                  style: GoogleFonts.dmSans(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 1000),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: AppColors.divider),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: isDesktop
              ? Row(
                  children: [
                    privateSecureCol,
                    Container(
                      width: 1,
                      height: 80,
                      color: AppColors.divider,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                    ),
                    worksOfflineCol,
                  ],
                )
              : Column(
                  children: [
                    privateSecureCol,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Divider(color: AppColors.divider, height: 1),
                    ),
                    worksOfflineCol,
                  ],
                ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 500.ms)
        .slideY(begin: 0.2, end: 0);
  }
}
