import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../models/complaint.dart';
import '../../models/hostel.dart';
import '../../data/hostel_data.dart';
import '../../widgets/custom_button.dart';
import 'package:intl/intl.dart';

class AdminComplaintDetailsScreen extends StatefulWidget {
  final Complaint complaint;
  final VoidCallback onStatusChanged;

  const AdminComplaintDetailsScreen({
    Key? key,
    required this.complaint,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  State<AdminComplaintDetailsScreen> createState() =>
      _AdminComplaintDetailsScreenState();
}

class _AdminComplaintDetailsScreenState
    extends State<AdminComplaintDetailsScreen> {
  late ComplaintStatus _selectedStatus;
  bool _isSaving = false;

  Hostel? _hostel;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.complaint.status;

    // 🔥 Correctly map complaint.hostelId → actual hostel
    _hostel = globalHostels.firstWhere(
      (h) => h.id == widget.complaint.hostelId,
      orElse: () => Hostel(
        id: "UNKNOWN",
        name: "Unknown Hostel",
        location: "",
        rating: 0.0,
        reviews: 0,
        isJoined: false,
      ),
    );
  }

  Future<void> _saveChanges() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1));

    widget.complaint.status = _selectedStatus;

    setState(() => _isSaving = false);

    widget.onStatusChanged(); // 🔥 Update AdminDashboard

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Status updated successfully'),
        backgroundColor: AppColors.statusSolved,
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(gradient: AppColors.headerGradient),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: _buildBackIcon(),
                        ),
                        const SizedBox(width: 12),
                        _buildLogo(),
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

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _guestCard(),
                  const SizedBox(height: 16),
                  _detailsCard(),
                  const SizedBox(height: 16),

                  /// 🔥 NEW — HOSTEL NAME CARD
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppStyles.cardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hostel",
                          style: AppStyles.caption.copyWith(
                            color: AppColors.textGray,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _hostel?.name ?? "Unknown Hostel",
                          style: AppStyles.body1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  _titleCard(),
                  const SizedBox(height: 20),
                  _descriptionCard(),

                  if (widget.complaint.photoUrl != null)
                    const SizedBox(height: 20),
                  if (widget.complaint.photoUrl != null) _photoCard(),

                  const SizedBox(height: 20),
                  _statusSelector(),
                  const SizedBox(height: 24),

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

  Widget _buildBackIcon() => Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
  );

  Widget _buildLogo() => Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.bolt_rounded, color: Colors.white),
  );

  Widget _guestCard() => Container(
    padding: const EdgeInsets.all(20),
    decoration: AppStyles.cardDecoration,
    child: Row(
      children: [
        _iconContainer(),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guest Name',
                style: AppStyles.caption.copyWith(color: AppColors.textGray),
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
  );

  Widget _iconContainer() => Container(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      gradient: AppColors.primaryGradient,
      borderRadius: BorderRadius.circular(14),
    ),
    child: const Icon(Icons.person_rounded, color: Colors.white, size: 28),
  );

  Widget _detailsCard() => Container(
    padding: const EdgeInsets.all(20),
    decoration: AppStyles.cardDecoration,
    child: Row(children: [_roomColumn(), _divider(), _submittedColumn()]),
  );

  Widget _roomColumn() => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Room",
          style: AppStyles.caption.copyWith(color: AppColors.textGray),
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
              style: AppStyles.heading3.copyWith(fontSize: 20),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _divider() =>
      Container(width: 1, height: 40, color: AppColors.cardBackground);

  Widget _submittedColumn() => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Submitted",
          style: AppStyles.caption.copyWith(color: AppColors.textGray),
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
                DateFormat(
                  'MMM d, yyyy',
                ).format(widget.complaint.submittedDate),
                style: AppStyles.body1.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _titleCard() => Container(
    padding: const EdgeInsets.all(20),
    decoration: AppStyles.cardDecoration,
    child: Text(widget.complaint.title, style: AppStyles.heading3),
  );

  Widget _descriptionCard() => Container(
    padding: const EdgeInsets.all(20),
    decoration: AppStyles.cardDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
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
  );

  Widget _photoCard() => Container(
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
          child: const Center(
            child: Icon(
              Icons.image_rounded,
              color: AppColors.primaryBlue,
              size: 48,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _statusSelector() => Container(
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
        _buildOption(ComplaintStatus.viewed),
        const SizedBox(height: 12),
        _buildOption(ComplaintStatus.inProgress),
        const SizedBox(height: 12),
        _buildOption(ComplaintStatus.solved),
      ],
    ),
  );

  Widget _buildOption(ComplaintStatus status) => _StatusOption(
    status: status,
    isSelected: _selectedStatus == status,
    onTap: () {
      setState(() {
        _selectedStatus = status;
      });
    },
  );
}

class _StatusOption extends StatelessWidget {
  final ComplaintStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  const _StatusOption({
    Key? key,
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
              child: Icon(icon, color: iconColor, size: 20),
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
