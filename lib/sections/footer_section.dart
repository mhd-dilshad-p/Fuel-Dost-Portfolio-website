import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../widgets/app_logo.dart';
import '../widgets/privacy_policy_dialog.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;
    final double horizontalPadding = width > 1200 ? (width - 1200) / 2 + 24 : 24;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        top: 80,
        bottom: 40,
      ),
      child: Column(
        children: [
          Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
          const SizedBox(height: 60),
          isMobile
              ? Column(
                  children: [
                    _buildBrandInfo(),
                    const SizedBox(height: 40),
                    _buildLinksGrid(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 2, child: _buildBrandInfo()),
                    Expanded(flex: 3, child: _buildLinksGrid(context)),
                  ],
                ),
          const SizedBox(height: 60),
          Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
          const SizedBox(height: 30),
          
          // Bottom credits
          isMobile
              ? Column(
                  children: [
                    _buildCredits(),
                    const SizedBox(height: 16),
                    _buildSocials(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCredits(),
                    _buildSocials(),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildBrandInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppLogo(height: 40, fontSize: 16),
        const SizedBox(height: 16),
        Text(
          'India\'s smartest offline-first fuel cost and savings optimizer calculator app.',
          style: GoogleFonts.dmSans(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLinksGrid(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLinkColumn(context, 'Support', [
          _LinkItem('Privacy Policy', '#privacy', url: 'https://www.termsfeed.com/live/a0e48248-56ac-4dd9-8d0e-e216118971a9'),
         
        ]),
      ],
    );
  }

  Widget _buildLinkColumn(BuildContext context, String title, List<_LinkItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.sora(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ...items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  if (item.label == 'Privacy Policy') {
                    _showPrivacyDialog(context, item.url ?? '');
                  } else if (item.url != null) {
                    final Uri uri = Uri.parse(item.url!);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  }
                },
                child: Text(
                  item.label,
                  style: GoogleFonts.dmSans(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCredits() {
    return Text(
      '© 2026 FuelDost. Made with ❤️ by Mohammed Dilshad P',
      style: GoogleFonts.dmSans(
        color: AppColors.textSecondary.withValues(alpha: 0.7),
        fontSize: 13,
      ),
    );
  }

  Widget _buildSocials() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(
          Icons.code,
          AppStrings.githubUrl,
        ),
        const SizedBox(width: 12),
        _buildSocialIcon(
          Icons.work_outline,
          AppStrings.linkedinUrl,
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 20),
        onPressed: () async {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context, String policyUrl) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Privacy Policy',
      barrierColor: Colors.black.withValues(alpha: 0.7),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: CurveTween(curve: Curves.easeOutBack).animate(anim1),
          child: FadeTransition(
            opacity: anim1,
            child: PrivacyPolicyDialog(fullPolicyUrl: policyUrl),
          ),
        );
      },
    );
  }
}

class _LinkItem {
  final String label;
  final String path;
  final String? url;

  _LinkItem(this.label, this.path, {this.url});
}
