import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_styles.dart';
import '../models/complaint.dart';
import 'status_badge.dart';
import 'package:intl/intl.dart';

class ComplaintCard extends StatelessWidget {
  final Complaint complaint;
  final VoidCallback onTap;

  const ComplaintCard({
    Key? key,
    required this.complaint,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                Expanded(
                  child: Text(
                    complaint.title,
                    style: AppStyles.heading3.copyWith(fontSize: 18),
                  ),
                ),
                const SizedBox(width: 12),
                StatusBadge(status: complaint.status),
              ],
            ),

            const SizedBox(height: 12),

            // Guest Info
            Row(
              children: [
                const Icon(
                  Icons.person_rounded,
                  size: 16,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: 6),
                Text(
                  complaint.guestName,
                  style: AppStyles.body2.copyWith(
                    color: AppColors.textGray,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Date and Room
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 16,
                  color: AppColors.textLight,
                ),
                const SizedBox(width: 6),
                Text(
                  DateFormat('MMM d, yyyy').format(complaint.submittedDate),
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textGray,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.location_on_rounded,
                  size: 16,
                  color: AppColors.textLight,
                ),
                const SizedBox(width: 6),
                Text(
                  complaint.roomNumber,
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textGray,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}