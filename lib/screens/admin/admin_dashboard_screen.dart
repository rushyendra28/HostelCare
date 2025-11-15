import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../models/complaint.dart';
import '../../widgets/complaint_card.dart';
import 'admin_complaint_details_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // Sample complaints data
  final List<Complaint> _complaints = [
    Complaint(
      id: '1',
      title: 'Water leakage in bathroom',
      description:
          'The bathroom ceiling has a water leak that drips constantly.',
      guestName: 'Ramesh Kumar',
      roomNumber: '204',
      submittedDate: DateTime(2025, 11, 12),
      status: ComplaintStatus.inProgress,
    ),
    Complaint(
      id: '2',
      title: 'AC not working properly',
      description: 'The air conditioner in my room is not cooling.',
      guestName: 'Priya Sharma',
      roomNumber: '301',
      submittedDate: DateTime(2025, 11, 10),
      status: ComplaintStatus.viewed,
    ),
    Complaint(
      id: '3',
      title: 'WiFi connection issue',
      description: 'Unable to connect to WiFi for the past two days.',
      guestName: 'Amit Patel',
      roomNumber: '105',
      submittedDate: DateTime(2025, 11, 8),
      status: ComplaintStatus.solved,
    ),
    Complaint(
      id: '4',
      title: 'Broken window lock',
      description: 'The window lock in my room is broken and needs repair.',
      guestName: 'Ramesh Kumar',
      roomNumber: '204',
      submittedDate: DateTime(2025, 11, 5),
      status: ComplaintStatus.solved,
    ),
    Complaint(
      id: '5',
      title: 'Noisy AC unit',
      description: 'The AC makes loud noise throughout the night.',
      guestName: 'Sneha Reddy',
      roomNumber: '402',
      submittedDate: DateTime(2025, 11, 4),
      status: ComplaintStatus.inProgress,
    ),
    Complaint(
      id: '6',
      title: 'Light not working',
      description: 'Main ceiling light not functioning.',
      guestName: 'Vikram Singh',
      roomNumber: '210',
      submittedDate: DateTime(2025, 11, 2),
      status: ComplaintStatus.viewed,
    ),
  ];

  int get _totalComplaints => _complaints.length;
  int get _viewedComplaints =>
      _complaints.where((c) => c.status == ComplaintStatus.viewed).length;
  int get _inProgressComplaints =>
      _complaints.where((c) => c.status == ComplaintStatus.inProgress).length;
  int get _solvedComplaints =>
      _complaints.where((c) => c.status == ComplaintStatus.solved).length;

  void _navigateToComplaintDetails(Complaint complaint) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminComplaintDetailsScreen(complaint: complaint),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header with gradient
          Container(
            decoration: const BoxDecoration(gradient: AppColors.headerGradient),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Admin Dashboard',
                      style: AppStyles.heading1.copyWith(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Manage all hostel complaints',
                      style: AppStyles.body1.copyWith(
                        color: Colors.white.withOpacity(0.9),
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
                  // Statistics Cards - FIXED
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.3, // ✅ Changed from 1.3 to 1.5
                    children: [
                      _StatCard(
                        icon: Icons.trending_up_rounded,
                        iconColor: AppColors.primaryBlue,
                        count: _totalComplaints.toString(),
                        label: 'Total Complaints',
                        backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                      ),
                      _StatCard(
                        icon: Icons.visibility_rounded,
                        iconColor: const Color(0xFFFCD34D),
                        count: _viewedComplaints.toString(),
                        label: 'Viewed',
                        backgroundColor: const Color(
                          0xFFFCD34D,
                        ).withOpacity(0.1),
                      ),
                      _StatCard(
                        icon: Icons.hourglass_empty_rounded,
                        iconColor: const Color(0xFF8B7FFF),
                        count: _inProgressComplaints.toString(),
                        label: 'In Progress',
                        backgroundColor: const Color(
                          0xFF8B7FFF,
                        ).withOpacity(0.1),
                      ),
                      _StatCard(
                        icon: Icons.check_circle_rounded,
                        iconColor: AppColors.statusSolved,
                        count: _solvedComplaints.toString(),
                        label: 'Solved',
                        backgroundColor: AppColors.statusSolved.withOpacity(
                          0.1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // All Complaints Section
                  Text('All Complaints', style: AppStyles.heading3),

                  const SizedBox(height: 16),

                  // Complaints List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _complaints.length,
                    itemBuilder: (context, index) {
                      final complaint = _complaints[index];
                      return ComplaintCard(
                        complaint: complaint,
                        onTap: () => _navigateToComplaintDetails(complaint),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ FIXED _StatCard Widget
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String count;
  final String label;
  final Color backgroundColor;

  const _StatCard({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.count,
    required this.label,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // ✅ Reduced from 20 to 16
      decoration: AppStyles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ Added
        children: [
          Container(
            width: 44, // ✅ Reduced from 48 to 44
            height: 44, // ✅ Reduced from 48 to 44
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22, // ✅ Reduced from 24 to 22
            ),
          ),
          const SizedBox(height: 4), // ✅ Added small spacing
          Flexible(
            // ✅ Wrapped in Flexible to prevent overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  // ✅ Added FittedBox for count
                  fit: BoxFit.scaleDown,
                  child: Text(
                    count,
                    style: AppStyles.heading1.copyWith(
                      fontSize: 28, // ✅ Reduced from 32 to 28
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 2), // ✅ Reduced from 4 to 2
                Text(
                  label,
                  style: AppStyles.caption.copyWith(
                    color: AppColors.textGray,
                    fontSize: 11, // ✅ Added explicit font size
                  ),
                  maxLines: 2, // ✅ Allow wrapping to 2 lines
                  overflow: TextOverflow.ellipsis, // ✅ Handle overflow
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
