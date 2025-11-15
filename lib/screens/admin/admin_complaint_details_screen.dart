import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../models/complaint.dart';
import '../../widgets/custom_button.dart';
import 'package:intl/intl.dart';

class AdminComplaintDetailsScreen extends StatefulWidget {
  final Complaint complaint;

  const AdminComplaintDetailsScreen({
    Key? key,
    required this.complaint,
  }) : super(key: key);

  @override
  State<AdminComplaintDetailsScreen> createState() =>
      _AdminComplaintDetailsScreenState();
}

class _AdminComplaintDetailsScreenState
    extends State<AdminComplaintDetailsScreen> {
  late ComplaintStatus _selectedStatus;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.complaint.status;
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isSaving = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSaving = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Status updated successfully'),
          backgroundColor: AppColors.statusSolved,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header with gradient
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.headerGradient,
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // App Bar
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.bolt_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'HostelCare Admin',
                          style: AppStyles.heading3.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Complaint Details',
                      style: AppStyles.heading1.copyWith(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Guest Info Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppStyles.cardDecoration,
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Guest Name',
                                style: AppStyles.caption.copyWith(
                                  color: AppColors.textGray,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.complaint.guestName,
                                style: AppStyles.heading3.copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Details Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppStyles.cardDecoration,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Room',
                                style: AppStyles.caption.copyWith(
                                  color: AppColors.textGray,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    size: 18,
                                    color: AppColors.primaryBlue,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.complaint.roomNumber,
                                    style: AppStyles.heading3.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.cardBackground,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Submitted',
                                style: AppStyles.caption.copyWith(
                                  color: AppColors.textGray,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today_rounded,
                                    size: 18,
                                    color: AppColors.primaryBlue,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      DateFormat('MMM d, yyyy')
                                          .format(widget.complaint.submittedDate),
                                      style: AppStyles.body1.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Problem Title Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppStyles.cardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.complaint.title,
                          style: AppStyles.heading3,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Description Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppStyles.cardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: AppStyles.body1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.complaint.description,
                          style: AppStyles.body1.copyWith(
                            color: AppColors.textGray,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Attached Photo
                  if (widget.complaint.photoUrl != null)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppStyles.cardDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attached Photo',
                            style: AppStyles.body1.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.image_rounded,
                                    color: AppColors.primaryBlue,
                                    size: 48,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Photo attached',
                                    style: AppStyles.body2.copyWith(
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Update Status Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppStyles.cardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Update Status',
                          style: AppStyles.body1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _StatusOption(
                          status: ComplaintStatus.viewed,
                          isSelected: _selectedStatus == ComplaintStatus.viewed,
                          onTap: () {
                            setState(() {
                              _selectedStatus = ComplaintStatus.viewed;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        _StatusOption(
                          status: ComplaintStatus.inProgress,
                          isSelected: _selectedStatus == ComplaintStatus.inProgress,
                          onTap: () {
                            setState(() {
                              _selectedStatus = ComplaintStatus.inProgress;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        _StatusOption(
                          status: ComplaintStatus.solved,
                          isSelected: _selectedStatus == ComplaintStatus.solved,
                          onTap: () {
                            setState(() {
                              _selectedStatus = ComplaintStatus.solved;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Save Button
                  CustomButton(
                    text: 'Save Changes',
                    onPressed: _saveChanges,
                    isLoading: _isSaving,
                    icon: const Icon(
                      Icons.save_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusOption extends StatelessWidget {
  final ComplaintStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  const _StatusOption({
    Key? key,  // ✅ Correct
    required this.status,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  Color get backgroundColor {
    switch (status) {
      case ComplaintStatus.viewed:
        return const Color(0xFFFCD34D).withOpacity(0.1);
      case ComplaintStatus.inProgress:
        return AppColors.primaryBlue.withOpacity(0.1);
      case ComplaintStatus.solved:
        return AppColors.statusSolved.withOpacity(0.1);
    }
  }

  Color get iconColor {
    switch (status) {
      case ComplaintStatus.viewed:
        return const Color(0xFFFCD34D);
      case ComplaintStatus.inProgress:
        return AppColors.primaryBlue;
      case ComplaintStatus.solved:
        return AppColors.statusSolved;
    }
  }

  IconData get icon {
    switch (status) {
      case ComplaintStatus.viewed:
        return Icons.visibility_rounded;
      case ComplaintStatus.inProgress:
        return Icons.hourglass_empty_rounded;
      case ComplaintStatus.solved:
        return Icons.check_circle_rounded;
    }
  }

  String get label {
    switch (status) {
      case ComplaintStatus.viewed:
        return 'Viewed';
      case ComplaintStatus.inProgress:
        return 'In Progress';
      case ComplaintStatus.solved:
        return 'Solved';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? backgroundColor : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? iconColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppStyles.body1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}