import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/colors.dart';
import '../widgets/review_card.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;
    final bool isTablet = width >= 768 && width < 1024;
    final double horizontalPadding = width > 1200 ? (width - 1200) / 2 + 24 : 24;

    final reviews = [
      {
        'name': 'Rahul Sharma',
        'avatar': '',
        'rating': 5.0,
        'text': 'Honestly, this is so simple and useful. I travel daily between Noida and Gurgaon. Saving my vehicle details and getting the exact cost breakdown is incredibly accurate. 5/5 stars.',
      },
      {
        'name': 'Priya Patel',
        'avatar': '',
        'rating': 5.0,
        'text': 'Amazing utility! Love that there is no sign-up or login wall. I just open it, enter details, and see how much I will spend. Perfect for planning weekend road trips with friends.',
      },
      {
        'name': 'Amit Verma',
        'avatar': '',
        'rating': 5.0,
        'text': 'Great UI design and completely ad-free. The offline functionality is perfect when traveling through remote highways with sketchy network coverage. Saved me multiple times.',
      },
    ];

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
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
            'Trusted by Indian Commuters',
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
              'Here is what our early users have to say about calculating their fuel budget using FuelDost.',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                color: AppColors.textSecondary,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
          const SizedBox(height: 60),

          // Cards list
          if (isMobile)
            Column(
              children: reviews.map((review) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ReviewCard(
                    name: review['name'] as String,
                    avatarUrl: review['avatar'] as String,
                    rating: review['rating'] as double,
                    reviewText: review['text'] as String,
                  ),
                );
              }).toList(),
            )
          else if (isTablet)
            Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ReviewCard(
                          name: reviews[0]['name'] as String,
                          avatarUrl: reviews[0]['avatar'] as String,
                          rating: reviews[0]['rating'] as double,
                          reviewText: reviews[0]['text'] as String,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ReviewCard(
                          name: reviews[1]['name'] as String,
                          avatarUrl: reviews[1]['avatar'] as String,
                          rating: reviews[1]['rating'] as double,
                          reviewText: reviews[1]['text'] as String,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.6,
                    child: ReviewCard(
                      name: reviews[2]['name'] as String,
                      avatarUrl: reviews[2]['avatar'] as String,
                      rating: reviews[2]['rating'] as double,
                      reviewText: reviews[2]['text'] as String,
                    ),
                  ),
                ),
              ],
            )
          else
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: reviews.map((review) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ReviewCard(
                        name: review['name'] as String,
                        avatarUrl: review['avatar'] as String,
                        rating: review['rating'] as double,
                        reviewText: review['text'] as String,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
