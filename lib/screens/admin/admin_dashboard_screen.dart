import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../models/complaint.dart';
import '../../models/hostel.dart';
import '../../data/hostel_data.dart';
import '../../widgets/complaint_card.dart';
import 'admin_complaint_details_screen.dart';
import '../hostel/add_hostel_screen.dart';
import '../../data/complaint_data.dart';
import '../../extensions/complaint_sort_extension.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  String _selectedHostelId = "ALL";

  // sample complaints + global
  final List<Complaint> _sampleComplaints = [
    Complaint(
      id: '1',
      title: 'Water leakage in bathroom',
      description: 'Bathroom ceiling leaks constantly.',
      guestName: 'Ramesh Kumar',
      roomNumber: '204',
      submittedDate: DateTime(2025, 11, 12, 8, 30),
      status: ComplaintStatus.inProgress,
      photoUrl: null,
      hostelId: "SAMPLE_H1",
    ),
    Complaint(
      id: '2',
      title: 'AC not working',
      description: 'The AC is not cooling properly.',
      guestName: 'Priya Sharma',
      roomNumber: '301',
      submittedDate: DateTime(2025, 11, 10, 19, 45),
      status: ComplaintStatus.viewed,
      photoUrl: null,
      hostelId: "SAMPLE_H2",
    ),
  ];

  List<Complaint> get _allComplaints => [
    ..._sampleComplaints,
    ...globalComplaints,
  ];

  List<Complaint> get _filteredComplaints {
    if (_selectedHostelId == "ALL") {
      return SortedComplaints(_allComplaints).sortedByDate();
    }

    return SortedComplaints(
          _allComplaints.where((c) => c.hostelId == _selectedHostelId).toList(),
        ) // <-- REQUIRED
        .sortedByDate();
  }

  int get _totalComplaints => _filteredComplaints.length;

  int get _viewedComplaints => _filteredComplaints
      .where((c) => c.status == ComplaintStatus.viewed)
      .length;

  int get _inProgressComplaints => _filteredComplaints
      .where((c) => c.status == ComplaintStatus.inProgress)
      .length;

  int get _solvedComplaints => _filteredComplaints
      .where((c) => c.status == ComplaintStatus.solved)
      .length;

  void _navigateToComplaintDetails(Complaint complaint) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminComplaintDetailsScreen(
          complaint: complaint,
          onStatusChanged: () => setState(() {}),
        ),
      ),
    );
  }

  void _openAddHostel() async {
    final Hostel? newHostel = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddHostelScreen()),
    );

    if (newHostel != null) {
      setState(() => globalHostels.add(newHostel));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Hostel added successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // HEADER
          Container(
            decoration: const BoxDecoration(gradient: AppColors.headerGradient),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TOP BAR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        ElevatedButton.icon(
                          onPressed: _openAddHostel,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryBlue,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.add_rounded),
                          label: const Text("Add Hostel"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

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

          // BODY
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// STATS GRID
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.1,
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

                  const SizedBox(height: 10),

                  //dropdown
                  Row(
                    children: [
                      // Expanded(
                      //   child: Text(
                      //     'Filter by Hostel',
                      //     style: AppStyles.heading3,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),
                      // const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.cardBackground),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedHostelId,
                            items: [
                              const DropdownMenuItem(
                                value: "ALL",
                                child: Text("All Hostels"),
                              ),
                              ...globalHostels.map(
                                (hostel) => DropdownMenuItem(
                                  value: hostel.id,
                                  child: Text(hostel.name),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() => _selectedHostelId = value!);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// COMPLAINTS HEADER + DROPDOWN
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Complaints',
                          style: AppStyles.heading3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.cardBackground),
                        ),
                        // child: DropdownButtonHideUnderline(
                        //   child: DropdownButton<String>(
                        //     value: _selectedHostelId,
                        //     items: [
                        //       const DropdownMenuItem(
                        //         value: "ALL",
                        //         child: Text("All Hostels"),
                        //       ),
                        //       ...globalHostels.map(
                        //         (hostel) => DropdownMenuItem(
                        //           value: hostel.id,
                        //           child: Text(hostel.name),
                        //         ),
                        //       ),
                        //     ],
                        //     onChanged: (value) {
                        //       setState(() => _selectedHostelId = value!);
                        //     },
                        //   ),
                        // ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// EMPTY STATE HANDLING
                  if (_filteredComplaints.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          Icon(
                            Icons.inbox_rounded,
                            size: 80,
                            color: AppColors.textLight,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No complaints for this hostel',
                            style: AppStyles.body1.copyWith(
                              color: AppColors.textGray,
                            ),
                          ),
                        ],
                      ),
                    ),

                  /// COMPLAINT LIST
                  if (_filteredComplaints.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _filteredComplaints.length,
                      itemBuilder: (context, index) {
                        final complaint = _filteredComplaints[index];
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

extension SortedComplaints on List<Complaint> {
  List<Complaint> sortedByDate() {
    return List.from(this)
      ..sort((a, b) => b.submittedDate.compareTo(a.submittedDate));
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String count;
  final String label;
  final Color backgroundColor;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.count,
    required this.label,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppStyles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 6),
          Text(count, style: AppStyles.heading1.copyWith(fontSize: 28)),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppStyles.caption.copyWith(
              color: AppColors.textGray,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
