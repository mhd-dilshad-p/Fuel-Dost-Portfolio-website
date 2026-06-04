import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1024;
    final double horizontalPadding = width > 1200 ? (width - 1200) / 2 + 32 : 32;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Title
          Text(
            'PACKED WITH SMART FEATURES',
            style: GoogleFonts.dmSans(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 16),
          Text(
            'Everything You Need to Save on Fuel',
            textAlign: TextAlign.center,
            style: GoogleFonts.sora(
              color: const Color(0xFF111827),
              fontSize: width < 600 ? 32 : 48,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 150.ms, duration: 500.ms),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              'No account required, no online trackers. Instantly figure out how much a trip will cost you before you reverse out of the driveway.',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                color: const Color(0xFF4B5563),
                fontSize: 18,
                height: 1.6,
              ),
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
          const SizedBox(height: 100),

          // Feature Rows Showcase
          _buildFeatureShowcase(
            badgeText: 'CALCULATOR',
            lottiePath: 'assets/icon/calculate.json',
            title: 'Real-time Fuel Cost Calculator',
            desc: 'Calculate trip fuel costs instantly for Petrol and Diesel.',
            imagePath: AppStrings.featureRealTimeCost,
            imageLeft: true,
            isDesktop: isDesktop,
            bullets: [
              'Supports both Petrol and Diesel fuels',
              'Instantly updates as parameters change',
              'Calculates exact fuel needed in liters',
            ],
          ),
          const SizedBox(height: 120),
          _buildFeatureShowcase(
            badgeText: 'ACCURATE PRICING',
            lottiePath: 'assets/icon/fuel.json',
            title: 'Manual Fuel Price Entry',
            desc: 'Enter your local fuel price for 100% accurate results — no outdated data!',
            imagePath: AppStrings.featureManualFuelPrice,
            imageLeft: false,
            isDesktop: isDesktop,
            bullets: [
              'No outdated or cached internet data',
              'Enter custom values with single-tap speed',
              'Tailor estimates to your specific region',
            ],
          ),
          const SizedBox(height: 120),
          _buildFeatureShowcase(
            badgeText: 'PROFILE',
            lottiePath: 'assets/icon/car.json',
            title: 'Custom Vehicle Mileage',
            desc: "Set your own vehicle's mileage for precise calculations.",
            imagePath: AppStrings.featureCustomMileage,
            imageLeft: true,
            isDesktop: isDesktop,
            bullets: [
              'Supports scooters, motorcycles, cars & SUVs',
              'Saves profiles locally for rapid planning',
              'Dynamic range estimations based on fuel',
            ],
          ),
          const SizedBox(height: 120),
          _buildFeatureShowcase(
            badgeText: 'INSTANT ESTIMATES',
            lottiePath: 'assets/icon/map distance.json',
            title: 'Distance-Based Estimation',
            desc: 'Enter your trip distance and get instant cost estimates.',
            imagePath: AppStrings.featureDistanceEstimation,
            imageLeft: false,
            isDesktop: isDesktop,
            bullets: [
              'Simple single-input mileage cost calculation',
              'Instantly compare vehicle cost differences',
              'Great for standard recurring routes',
            ],
          ),
          const SizedBox(height: 120),
          _buildFeatureShowcase(
            badgeText: 'TRACKING',
            lottiePath: 'assets/icon/map history.json',
            title: 'Trip History & Tracking',
            desc: 'Save and review your past trip expenses easily.',
            imagePath: AppStrings.featureTripHistory,
            imageLeft: true,
            isDesktop: isDesktop,
            bullets: [
              'Track spending history with zero cloud backup',
              'Search, filter, and export travel logs',
              'Keep logs private under local encryption',
            ],
          ),
          const SizedBox(height: 120),
          _buildFeatureShowcase(
            badgeText: 'MADE FOR INDIA',
            lottiePath: 'assets/icon/indian flag.json',
            title: 'Works Offline - Built for India',
            desc: 'No internet needed. No login. No account. Just open and calculate!',
            imagePath: AppStrings.featureWorksOffline,
            imageLeft: false,
            isDesktop: isDesktop,
            bullets: [
              'Designed specifically for Indian roads, vehicles, and fuel pricing',
              'Works perfectly in weak or no-network areas',
              'Zero battery drain from background cloud sync',
            ],
          ),
          const SizedBox(height: 120),

          // Perfect For Callout Card
          _buildPerfectForCard(width, isDesktop),
        ],
      ),
    );
  }

  Widget _buildFeatureShowcase({
    required String badgeText,
    String? lottiePath,
    String? badgeEmoji,
    required String title,
    required String desc,
    required String imagePath,
    required bool imageLeft,
    required bool isDesktop,
    required List<String> bullets,
  }) {
    Widget textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (lottiePath != null)
          SizedBox(
            width: 200,
            height: 200,
            child: Lottie.asset(
              lottiePath,
              fit: BoxFit.contain,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0)
        else if (badgeEmoji != null)
          Text(
            badgeEmoji,
            style: const TextStyle(fontSize: 72),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 20),
        Text(
          title,
          style: GoogleFonts.sora(
            color: const Color(0xFF111827),
            fontSize: isDesktop ? 44 : 32,
            fontWeight: FontWeight.w800,
            height: 1.2,
            letterSpacing: -1,
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 16),
        Text(
          desc,
          style: GoogleFonts.dmSans(
            color: const Color(0xFF4B5563),
            fontSize: 20,
            height: 1.6,
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 32),
        ...bullets.asMap().entries.map((entry) {
          int idx = entry.key;
          String bullet = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Color(0xFF2E7D32),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    bullet,
                    style: GoogleFonts.dmSans(
                      color: const Color(0xFF374151),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: (300 + (idx * 100)).ms, duration: 600.ms).slideX(begin: 0.1, end: 0);
        }),
      ],
    );

    Widget imageContent = Container(
      constraints: BoxConstraints(
        maxHeight: isDesktop ? 600 : 450,
        maxWidth: 600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1), curve: Curves.easeOutQuart);

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: imageLeft
            ? [
                Expanded(flex: 5, child: Align(alignment: Alignment.centerRight, child: Padding(padding: const EdgeInsets.only(right: 60), child: imageContent))),
                Expanded(flex: 5, child: Padding(padding: const EdgeInsets.only(left: 40), child: textContent)),
              ]
            : [
                Expanded(flex: 5, child: Padding(padding: const EdgeInsets.only(right: 40), child: textContent)),
                Expanded(flex: 5, child: Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.only(left: 60), child: imageContent))),
              ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageContent,
          const SizedBox(height: 56),
          textContent,
        ],
      );
    }
  }

  Widget _buildPerfectForCard(double width, bool isDesktop) {
    final List<Map<String, String>> perfectForItems = [
      {
        'title': 'Daily commuters',
        'image': AppStrings.perfectForCommuters,
      },
      {
        'title': 'Cab & auto drivers',
        'image': AppStrings.perfectForCab,
      },
      {
        'title': 'Delivery agents',
        'image': AppStrings.perfectForDelivery,
      },
      {
        'title': 'Road trip planners',
        'image': AppStrings.perfectForRoadTrip,
      },
    ];

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1000),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.stars_rounded,
              color: AppColors.primary,
              size: 32,
            ),
          ).animate().scale(delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack),
          const SizedBox(height: 24),
          Text(
            'Perfect For Everyone',
            style: GoogleFonts.sora(
              color: const Color(0xFF111827),
              fontSize: isDesktop ? 36 : 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: perfectForItems.map((item) => IntrinsicWidth(child: _buildImageCheckItem(item['title']!, item['image']!))).toList(),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildImageCheckItem(String text, String imagePath) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              color: const Color(0xFF111827),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
