import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../widgets/screenshot_mockup.dart';

class ScreenshotsSection extends StatefulWidget {
  const ScreenshotsSection({super.key});

  @override
  State<ScreenshotsSection> createState() => _ScreenshotsSectionState();
}

class _ScreenshotsSectionState extends State<ScreenshotsSection> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> _screenshots = [
    {
      'image': AppStrings.screenshotTripCost,
      'title': 'Accurate Cost Breakdown',
      'desc':
          'Get exact pricing details calculated for your destination instantly.',
    },
    {
      'image': AppStrings.screenshotRouteMap,
      'title': 'Visual Map Routes',
      'desc':
          'Interactive maps to visualize your trip path and distance constraints.',
    },
    {
      'image': AppStrings.screenshotExpenses,
      'title': 'Expense Tracking logs',
      'desc': 'Log your daily and monthly travel charges cleanly on-device.',
    },
    {
      'image': AppStrings.screenshotInsights,
      'title': 'Insight analytics graphs',
      'desc':
          'Analyze cost trends and see where you can optimize fuel efficiency.',
    },
    {
      'image': AppStrings.screenshotRecommendations,
      'title': 'Smart Recommendations',
      'desc':
          'AI-driven tips for vehicle selection, routing choices, and driving style.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % _screenshots.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final double horizontalPadding = width > 1200
        ? (width - 1200) / 2 + 24
        : 24;

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Column(
        children: [
          // Titles
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                Text(
                  'APP SCREENSHOTS',
                  style: GoogleFonts.dmSans(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ).animate().fadeIn(duration: 500.ms),
                const SizedBox(height: 12),
                Text(
                  'Designed for Simplicity',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sora(
                    color: AppColors.textPrimary,
                    fontSize: isMobile ? 28 : 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                ).animate().fadeIn(delay: 150.ms, duration: 500.ms),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    'Browse through the app layouts designed specifically to facilitate calculations without heavy interfaces.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
              ],
            ),
          ),
          const SizedBox(height: 60),

          // Carousel
          SizedBox(
            height: 620,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _screenshots.length,
              itemBuilder: (context, index) {
                final item = _screenshots[index];
                final double scale = index == _currentPage ? 1.0 : 0.88;
                final double opacity = index == _currentPage ? 1.0 : 0.4;

                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScreenshotMockup(
                            imagePath: item['image']!,
                            height: 480,
                            width: 240,
                          ),
                          const SizedBox(height: 24),
                          if (index == _currentPage) ...[
                            Text(
                              item['title']!,
                              style: GoogleFonts.sora(
                                color: AppColors.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ).animate().fadeIn(duration: 300.ms),
                            const SizedBox(height: 8),
                            Text(
                              item['desc']!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                              ),
                            ).animate().fadeIn(duration: 300.ms),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Dots Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_screenshots.length, (index) {
              final isSelected = index == _currentPage;
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOutCubic,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: isSelected ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
