import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../widgets/app_logo.dart';

class NavbarSection extends StatelessWidget implements PreferredSizeWidget {
  final Function(int) onNavItemTap;
  final bool isScrolled;

  const NavbarSection({
    super.key,
    required this.onNavItemTap,
    required this.isScrolled,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    // Responsive breakpoint: viewports under 1000px use the mobile/tablet drawer
    final bool isCompact = width < 1000;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: isScrolled ? 10.0 : 0.0,
          sigmaY: isScrolled ? 10.0 : 0.0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: preferredSize.height,
          decoration: BoxDecoration(
            color: isScrolled
                ? AppColors.background.withValues(alpha: 0.85)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isScrolled ? AppColors.divider : Colors.transparent,
                width: 1,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: width > 1280 ? (width - 1280) / 2 + 24 : 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => onNavItemTap(0),
                  child: const AppLogo(
                    height: 44,
                    fontSize: 18,
                    useWhiteBackground: false,
                  ),
                ),
              ),

              // Desktop Navigation Links & CTA
              if (!isCompact)
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNavLink('Features', () => onNavItemTap(1)),
                        _buildNavLink('How It Works', () => onNavItemTap(2)),
                        _buildNavLink('Screenshots', () => onNavItemTap(3)),
                        _buildNavLink('Reviews', () => onNavItemTap(4)),
                        const SizedBox(width: 14),
                        ElevatedButton(
                          onPressed: () async {
                            final Uri url = Uri.parse(AppStrings.playStoreUrl);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Download Free',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: AppColors.textPrimary,
                    size: 28,
                  ),
                  tooltip: 'Open navigation menu',
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(String title, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            title,
            style: GoogleFonts.dmSans(
              color: AppColors.textPrimary.withValues(alpha: 0.8),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
