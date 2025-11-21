import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_styles.dart';
import '../models/hostel.dart';

class HostelCard extends StatelessWidget {
  final Hostel hostel;
  final VoidCallback onJoinPressed;
  final VoidCallback? onCardTap;
  final bool showExitMessage;

  const HostelCard({
    Key? key,
    required this.hostel,
    required this.onJoinPressed,
    this.onCardTap,
    this.showExitMessage = false,
  }) : super(key: key);

  String get cityName {
    try {
      final parts = hostel.location.split(',');
      if (parts.length >= 4) return parts[3].trim();
      return hostel.location;
    } catch (_) {
      return hostel.location;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isJoined = hostel.isJoined;

    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: AppStyles.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // NAME + CITY
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hostel.name,
                        style: AppStyles.heading3.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: AppColors.primaryBlue,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cityName,
                            style: AppStyles.body2.copyWith(
                              color: AppColors.textGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // JOIN BUTTON / JOINED BADGE / DISABLED JOIN
                _buildJoinSection(isJoined),
              ],
            ),

            const SizedBox(height: 12),

            // RATING
            // Row(
            //   children: [
            //     const Icon(
            //       Icons.star_rounded,
            //       color: Color(0xFFFFC107),
            //       size: 20,
            //     ),
            //     const SizedBox(width: 4),
            //     Text(
            //       hostel.rating.toStringAsFixed(1),
            //       style: AppStyles.body1.copyWith(
            //         fontWeight: FontWeight.w600,
            //         color: AppColors.textDark,
            //       ),
            //     ),
            //     const SizedBox(width: 16),
            //     Text(
            //       "${hostel.reviews} reviews",
            //       style: AppStyles.body2.copyWith(color: AppColors.textGray),
            //     ),
            //   ],
            // ),

            // RED "EXIT TO JOIN" MESSAGE
            if (showExitMessage && !isJoined) ...[
              const SizedBox(height: 12),
              Text(
                'Exit your current hostel to join this one',
                style: AppStyles.caption.copyWith(
                  color: AppColors.error,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // 🔵  JOIN / JOINED / DISABLED BUTTON BUILDER
  Widget _buildJoinSection(bool isJoined) {
    // 🟢 JOINED badge + exit link
    if (isJoined) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Joined badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFDFF8E7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.check_circle, color: Color(0xFF2ECC71), size: 18),
                SizedBox(width: 6),
                Text(
                  "Joined",
                  style: TextStyle(
                    color: Color(0xFF2ECC71),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Exit hostel small link
          InkWell(
            onTap: onJoinPressed,
            child: Text(
              'Exit hostel',
              style: AppStyles.caption.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      );
    }

    // ❌ Disabled join button (grey)
    if (showExitMessage) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          "Join",
          style: TextStyle(
            color: Color(0xFF9CA3AF), // light grey text
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    // 🔷 Normal active join button
    return InkWell(
      onTap: onJoinPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6A82FB), Color(0xFF4E67EB)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          "Join",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
