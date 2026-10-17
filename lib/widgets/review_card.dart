import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class ReviewCard extends StatefulWidget {
  final String name;
  final String avatarUrl;
  final double rating;
  final String reviewText;
  final String userTag;
  final String date;

  const ReviewCard({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.rating,
    required this.reviewText,
    this.userTag = 'Verified Commuter',
    this.date = 'Recent',
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isLiked = false;
  int _likesCount = 12;
  late AnimationController _likeController;
  late Animation<double> _likeScaleAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize random likes count based on hash code to keep it stable but dynamic
    _likesCount = (widget.name.hashCode % 18) + 4;

    _likeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _likeScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.4), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(_likeController);
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likesCount++;
        _likeController.forward();
      } else {
        _likesCount--;
        _likeController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? (Matrix4.diagonal3Values(1.02, 1.02, 1.0)
                ..setTranslationRaw(0.0, -8.0, 0.0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: _isHovered
              ? Colors.white
              : AppColors.cardBackground.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary
                : AppColors.divider.withValues(alpha: 0.6),
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.02),
              blurRadius: _isHovered ? 28 : 16,
              offset: Offset(0, _isHovered ? 12 : 8),
            ),
            if (_isHovered)
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.03),
                blurRadius: 40,
                offset: const Offset(4, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row
                Row(
                  children: [
                    // Avatar with Gradient Ring
                    Container(
                      padding: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: _isHovered
                              ? [AppColors.primary, AppColors.accent]
                              : [AppColors.divider, AppColors.divider],
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primary.withValues(
                            alpha: 0.1,
                          ),
                          child: Text(
                            widget.name.isNotEmpty
                                ? widget.name[0].toUpperCase()
                                : 'U',
                            style: GoogleFonts.sora(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Name and Date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.name,
                                style: GoogleFonts.sora(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.5,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.verified,
                                color: AppColors.primary,
                                size: 15,
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            widget.userTag,
                            style: GoogleFonts.dmSans(
                              color: AppColors.primary.withValues(alpha: 0.8),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Playstore Badge icon
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icon/playstore_logo.png',
                            width: 12,
                            height: 12,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stack) => const Icon(
                              Icons.play_arrow_rounded,
                              color: AppColors.primary,
                              size: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Play Store',
                            style: GoogleFonts.dmSans(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Stars & Date Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < widget.rating
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: index < widget.rating
                              ? const Color(0xFFFFB300) // Golden Star
                              : Colors.grey.withValues(alpha: 0.3),
                          size: 18,
                        );
                      }),
                    ),
                    Text(
                      widget.date,
                      style: GoogleFonts.dmSans(
                        color: AppColors.textSecondary.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Review Text
                Text(
                  '"${widget.reviewText}"',
                  style: GoogleFonts.dmSans(
                    color: AppColors.textSecondary,
                    fontSize: 14.5,
                    height: 1.6,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),

            Column(
              children: [
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFF3F4F6)),
                const SizedBox(height: 12),

                // Interactive bottom row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Was this review helpful?',
                      style: GoogleFonts.dmSans(
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                        fontSize: 12,
                      ),
                    ),

                    // Helpful button
                    InkWell(
                      onTap: _handleLike,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _isLiked
                              ? AppColors.primary.withValues(alpha: 0.08)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _isLiked
                                ? AppColors.primary
                                : AppColors.divider.withValues(alpha: 0.8),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ScaleTransition(
                              scale: _likeScaleAnimation,
                              child: Icon(
                                _isLiked
                                    ? Icons.thumb_up_rounded
                                    : Icons.thumb_up_outlined,
                                color: _isLiked
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                size: 13,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Helpful ($_likesCount)',
                              style: GoogleFonts.dmSans(
                                color: _isLiked
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: _isLiked
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
