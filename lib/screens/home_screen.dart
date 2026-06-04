import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../sections/navbar_section.dart';
import '../sections/hero_section.dart';
import '../sections/features_section.dart';
import '../sections/how_it_works_section.dart';
import '../sections/screenshots_section.dart';
import '../sections/reviews_section.dart';
import '../sections/download_cta_section.dart';
import '../sections/footer_section.dart';
import '../widgets/app_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(_onScrollPositionsChanged);
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(_onScrollPositionsChanged);
    super.dispose();
  }

  void _onScrollPositionsChanged() {
    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isNotEmpty) {
      final first = positions.first;
      // If the first visible item is index 0 and its trailing edge is mostly visible
      final isScrolled = first.index > 0 || (first.index == 0 && first.itemLeadingEdge < -0.05);
      if (isScrolled != _isScrolled) {
        setState(() {
          _isScrolled = isScrolled;
        });
      }
    }
  }

  void _scrollToIndex(int index) {
    _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 850),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final List<Widget> sections = [
      HeroSection(onLearnMoreTap: () => _scrollToIndex(1)),
      const FeaturesSection(),
      const HowItWorksSection(),
      const ScreenshotsSection(),
      const ReviewsSection(),
      const DownloadCtaSection(),
      const FooterSection(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      endDrawer: width < 768 ? _buildMobileDrawer() : null,
      body: Stack(
        children: [
          // Background Gradient Glows
          Positioned(
            top: 200,
            left: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.04),
              ),
            ),
          ),
          Positioned(
            bottom: 400,
            right: -100,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withValues(alpha: 0.02),
              ),
            ),
          ),

          // Scrollable Sections
          ScrollablePositionedList.builder(
            itemCount: sections.length,
            itemScrollController: _itemScrollController,
            itemPositionsListener: _itemPositionsListener,
            itemBuilder: (context, index) {
              return sections[index];
            },
          ),

          // Sticky Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavbarSection(
              isScrolled: _isScrolled,
              onNavItemTap: (index) {
                _scrollToIndex(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: AppColors.cardBackground,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: const AppLogo(height: 50, fontSize: 20),
            ),
            const Divider(color: Colors.white10),

            // Navigation Links
            _buildDrawerItem('Features', () {
              Navigator.pop(context);
              _scrollToIndex(1);
            }),
            _buildDrawerItem('How It Works', () {
              Navigator.pop(context);
              _scrollToIndex(2);
            }),
            _buildDrawerItem('Screenshots', () {
              Navigator.pop(context);
              _scrollToIndex(3);
            }),
            _buildDrawerItem('Reviews', () {
              Navigator.pop(context);
              _scrollToIndex(4);
            }),

            const Spacer(),
            
            // CTA Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    final Uri url = Uri.parse(AppStrings.playStoreUrl);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Download Free',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      title: Text(
        title,
        style: GoogleFonts.dmSans(
          color: Colors.white.withValues(alpha: 0.8),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
