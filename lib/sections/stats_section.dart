import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/animated_stat.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;
    final double horizontalPadding = width > 1200
        ? (width - 1200) / 2 + 24
        : 24;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 60),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B7A3E), Color(0xFF0F4E27)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B7A3E).withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: isMobile
          ? Column(
              children: [
                _buildStatWrapper(
                  const AnimatedStat(
                    endValue: 10000,
                    suffix: '+',
                    label: 'Trips Calculated',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Divider(color: Colors.white24, height: 1),
                ),
                _buildStatWrapper(
                  const AnimatedStat(
                    endValue: 50000,
                    prefix: '₹',
                    suffix: '+',
                    label: 'User Fuel Savings',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Divider(color: Colors.white24, height: 1),
                ),
                _buildStatWrapper(
                  const AnimatedStat(
                    endValue: 100,
                    suffix: '%',
                    label: 'Free & Offline First',
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildStatWrapper(
                    const AnimatedStat(
                      endValue: 10000,
                      suffix: '+',
                      label: 'Trips Calculated',
                    ),
                  ),
                ),
                Container(height: 80, width: 1, color: Colors.white24),
                Expanded(
                  child: _buildStatWrapper(
                    const AnimatedStat(
                      endValue: 50000,
                      prefix: '₹',
                      suffix: '+',
                      label: 'User Fuel Savings',
                    ),
                  ),
                ),
                Container(height: 80, width: 1, color: Colors.white24),
                Expanded(
                  child: _buildStatWrapper(
                    const AnimatedStat(
                      endValue: 100,
                      suffix: '%',
                      label: 'Free & Offline First',
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatWrapper(Widget stat) {
    return stat
        .animate()
        .fadeIn(duration: 800.ms)
        .scale(begin: const Offset(0.9, 0.9));
  }
}
