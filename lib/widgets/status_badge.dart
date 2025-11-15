import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_styles.dart';
import '../models/complaint.dart';

class StatusBadge extends StatelessWidget {
  final ComplaintStatus status;

  const StatusBadge({Key? key, required this.status}) : super(key: key);

  Color get backgroundColor {
    switch (status) {
      case ComplaintStatus.inProgress:
        return AppColors.statusInProgress.withOpacity(0.1);
      case ComplaintStatus.viewed:
        return AppColors.statusViewed.withOpacity(0.1);
      case ComplaintStatus.solved:
        return AppColors.statusSolved.withOpacity(0.1);
    }
  }

  Color get textColor {
    switch (status) {
      case ComplaintStatus.inProgress:
        return AppColors.statusInProgress;
      case ComplaintStatus.viewed:
        return AppColors.statusViewed;
      case ComplaintStatus.solved:
        return AppColors.statusSolved;
    }
  }

  IconData get icon {
    switch (status) {
      case ComplaintStatus.inProgress:
        return Icons.hourglass_empty_rounded;
      case ComplaintStatus.viewed:
        return Icons.visibility_rounded;
      case ComplaintStatus.solved:
        return Icons.check_circle_rounded;
    }
  }

  String get text {
    switch (status) {
      case ComplaintStatus.inProgress:
        return 'In Progress';
      case ComplaintStatus.viewed:
        return 'Viewed';
      case ComplaintStatus.solved:
        return 'Solved';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppStyles.caption.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
