import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../widgets/review_card.dart';

class ReviewsSection extends StatefulWidget {
  const ReviewsSection({super.key});

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  String _selectedTag = 'All';
  bool _animateProgress = false;

  final List<String> _tags = [
    'All',
    'Accuracy 🎯',
    'Offline 📶',
    'UI/UX 🎨',
    'Commuters 🚗',
  ];

  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Rahul Sharma',
      'avatar': '',
      'rating': 5.0,
      'text': 'Honestly, this is so simple and useful. I travel daily between Noida and Gurgaon. Saving my vehicle details and getting the exact cost breakdown is incredibly accurate. 5/5 stars.',
      'tag': 'Verified Commuter',
      'date': '2 days ago',
      'categories': ['All', 'Accuracy 🎯', 'Commuters 🚗'],
    },
    {
      'name': 'Priya Patel',
      'avatar': '',
      'rating': 5.0,
      'text': 'Amazing utility! Love that there is no sign-up or login wall. I just open it, enter details, and see how much I will spend. Perfect for planning weekend road trips with friends.',
      'tag': 'Verified Commuter',
      'date': '1 week ago',
      'categories': ['All', 'UI/UX 🎨'],
    },
    {
      'name': 'Amit Verma',
      'avatar': '',
      'rating': 5.0,
      'text': 'Great UI design and completely ad-free. The offline functionality is perfect when traveling through remote highways with sketchy network coverage. Saved me multiple times.',
      'tag': 'Verified Commuter',
      'date': '3 days ago',
      'categories': ['All', 'Offline 📶', 'UI/UX 🎨'],
    },
    {
      'name': 'Rajesh Kumar',
      'avatar': '',
      'rating': 5.0,
      'text': 'As a cab driver, I need to know the exact fuel costs before quoting rates to clients. This app saves me hours of manual calculations. The mileage customization is spot on!',
      'tag': 'Verified Fleet Owner',
      'date': '2 weeks ago',
      'categories': ['All', 'Accuracy 🎯', 'Commuters 🚗'],
    },
    {
      'name': 'Sneha Reddy',
      'avatar': '',
      'rating': 5.0,
      'text': 'Super lightweight app! It doesn\'t take space, loads in a second, and works perfectly without any internet. Best app for Indian roads.',
      'tag': 'Verified Commuter',
      'date': '5 days ago',
      'categories': ['All', 'Offline 📶', 'UI/UX 🎨'],
    },
    {
      'name': 'Vikram Singh',
      'avatar': '',
      'rating': 4.8,
      'text': 'The app works flawlessly offline. Very clean UI and extremely helpful support. Adding custom fuel prices is a neat touch!',
      'tag': 'Verified Commuter',
      'date': '1 month ago',
      'categories': ['All', 'Offline 📶', 'Accuracy 🎯'],
    },
  ];

  @override
  void initState() {
    super.initState();
    // Trigger progress bar animation shortly after section initialization
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _animateProgress = true;
        });
      }
    });
  }

  Future<void> _launchPlayStore() async {
    final Uri url = Uri.parse(AppStrings.playStoreUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;
    final bool isTablet = width >= 768 && width < 1050;
    final double horizontalPadding = width > 1200 ? (width - 1200) / 2 + 24 : 24;

    // Filter reviews
    final filteredReviews = _reviews.where((review) {
      final List<String> categories = List<String>.from(review['categories']);
      return categories.contains(_selectedTag);
    }).toList();

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Title
          Text(
            'USER STORIES & REVIEWS',
            style: GoogleFonts.dmSans(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 12),
          Text(
            'Loved by Millions of Commuters',
            textAlign: TextAlign.center,
            style: GoogleFonts.sora(
              color: AppColors.textPrimary,
              fontSize: width < 600 ? 28 : 40,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 150.ms, duration: 500.ms),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Here is a breakdown of our Google Play Store ratings and reviews from everyday Indian drivers and commuters.',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                color: AppColors.textSecondary,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
          const SizedBox(height: 60),

          // Main Responsive Layout
          if (isMobile || isTablet)
            Column(
              children: [
                _buildRatingSummaryCard(isMobile: isMobile),
                const SizedBox(height: 48),
                _buildFilterChips(),
                const SizedBox(height: 32),
                _buildReviewsGrid(filteredReviews, isMobile: true),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Rating Summary
                SizedBox(
                  width: 360,
                  child: _buildRatingSummaryCard(isMobile: false),
                ),
                const SizedBox(width: 48),
                // Right Column: Filter chips + Reviews Grid
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFilterChips(),
                      const SizedBox(height: 32),
                      _buildReviewsGrid(filteredReviews, isMobile: false),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRatingSummaryCard({required bool isMobile}) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Google Play',
            style: GoogleFonts.sora(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          
          // Big Rating Display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '4.8',
                style: GoogleFonts.sora(
                  color: AppColors.textPrimary,
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2,
                ),
              ),
              Text(
                '/5',
                style: GoogleFonts.sora(
                  color: AppColors.textSecondary.withValues(alpha: 0.5),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          // Stars Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              if (index < 4) {
                return const Icon(Icons.star_rounded, color: Color(0xFFFFB300), size: 28);
              } else {
                return const Icon(Icons.star_half_rounded, color: Color(0xFFFFB300), size: 28);
              }
            }),
          ),
          const SizedBox(height: 8),
          Text(
            'Based on 154 reviews',
            style: GoogleFonts.dmSans(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 32),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 24),

          // Rating Breakdown Bars
          _buildBreakdownRow(5, 0.88, '135'),
          const SizedBox(height: 10),
          _buildBreakdownRow(4, 0.09, '14'),
          const SizedBox(height: 10),
          _buildBreakdownRow(3, 0.02, '3'),
          const SizedBox(height: 10),
          _buildBreakdownRow(2, 0.01, '2'),
          const SizedBox(height: 10),
          _buildBreakdownRow(1, 0.00, '0'),
          
          const SizedBox(height: 32),
          
          // Call to Action
          ElevatedButton.icon(
            onPressed: _launchPlayStore,
            icon: Image.asset(
              'assets/icon/playstore_logo.png',
              width: 16,
              height: 16,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stack) => const Icon(
                Icons.star_outline_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
            label: Text(
              'Write a Review',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .shimmer(delay: 3.seconds, duration: 1.5.seconds, color: Colors.white24),
        ],
      ),
    ).animate().scale(duration: 400.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildBreakdownRow(int stars, double percentage, String count) {
    return Row(
      children: [
        SizedBox(
          width: 32,
          child: Text(
            '$stars ★',
            style: GoogleFonts.dmSans(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOutCubic,
                    width: _animateProgress ? constraints.maxWidth * percentage : 0,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 28,
          child: Text(
            count,
            textAlign: TextAlign.end,
            style: GoogleFonts.dmSans(
              color: AppColors.textSecondary.withValues(alpha: 0.6),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _tags.map((tag) {
        final isSelected = _selectedTag == tag;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedTag = tag;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppColors.primary 
                    : AppColors.cardBackground,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected 
                      ? AppColors.primary 
                      : AppColors.divider.withValues(alpha: 0.8),
                  width: 1,
                ),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Text(
                tag,
                style: GoogleFonts.dmSans(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildReviewsGrid(List<Map<String, dynamic>> filteredReviews, {required bool isMobile}) {
    if (filteredReviews.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            'No reviews found for this tag.',
            style: GoogleFonts.dmSans(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    if (isMobile) {
      return Column(
        children: filteredReviews.map((review) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ReviewCard(
              name: review['name'] as String,
              avatarUrl: review['avatar'] as String,
              rating: review['rating'] as double,
              reviewText: review['text'] as String,
              userTag: review['tag'] as String,
              date: review['date'] as String,
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0);
        }).toList(),
      );
    }

    // Two-column layout for desktop
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        mainAxisExtent: 260, // Fixed height for review cards to align perfectly
      ),
      itemCount: filteredReviews.length,
      itemBuilder: (context, index) {
        final review = filteredReviews[index];
        return ReviewCard(
          name: review['name'] as String,
          avatarUrl: review['avatar'] as String,
          rating: review['rating'] as double,
          reviewText: review['text'] as String,
          userTag: review['tag'] as String,
          date: review['date'] as String,
        ).animate(key: ValueKey(review['name']))
         .fadeIn(duration: 400.ms, delay: (index * 50).ms)
         .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
      },
    );
  }
}
