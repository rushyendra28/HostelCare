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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: AppStyles.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hostel Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hostel.name,
                        style: AppStyles.heading3,
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
                            hostel.location,
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

                // Join/Joined Button
                _buildActionButton(context),
              ],
            ),

            const SizedBox(height: 12),

            // Rating and Reviews
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFFCD34D),
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  hostel.rating.toString(),
                  style: AppStyles.body1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${hostel.reviews} reviews',
                  style: AppStyles.body2.copyWith(
                    color: AppColors.textGray,
                  ),
                ),
              ],
            ),

            // Exit message for joined hostels
            if (showExitMessage && !hostel.isJoined) ...[
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

  Widget _buildActionButton(BuildContext context) {
    if (hostel.isJoined) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.statusSolved.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  size: 16,
                  color: AppColors.statusSolved,
                ),
                const SizedBox(width: 4),
                Text(
                  'Joined',
                  style: AppStyles.caption.copyWith(
                    color: AppColors.statusSolved,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: onJoinPressed,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'Exit hostel',
                style: AppStyles.caption.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return ElevatedButton(
      onPressed: showExitMessage ? null : onJoinPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: showExitMessage 
            ? AppColors.textLight.withOpacity(0.3)
            : AppColors.primaryBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        disabledBackgroundColor: AppColors.textLight.withOpacity(0.3),
        disabledForegroundColor: Colors.white,
      ),
      child: Text(
        'Join',
        style: AppStyles.body2.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}