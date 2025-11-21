import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../data/hostel_data.dart';
import '../../models/hostel.dart';
import '../../widgets/hostel_card.dart';
import '../../widgets/custom_text_field.dart';
import 'hostel_details_screen.dart';
import '../menu/menu_drawer.dart';
import 'add_hostel_screen.dart';

class HostelSelectionScreen extends StatefulWidget {
  final String searchQuery;

  const HostelSelectionScreen({super.key, required this.searchQuery});

  @override
  State<HostelSelectionScreen> createState() => _HostelSelectionScreenState();
}

class _HostelSelectionScreenState extends State<HostelSelectionScreen> {
  final _searchController = TextEditingController();
  String? _currentHostelId;

  List<Hostel> _filteredHostels = [];

  @override
  void initState() {
    super.initState();

    // 🔥 NEW: pre-fill search text
    _searchController.text = widget.searchQuery;

    // 🔥 NEW: initial filtering using searchQuery
    final query = widget.searchQuery.toLowerCase();
    if (query.isEmpty) {
      _filteredHostels = globalHostels;
    } else {
      _filteredHostels = globalHostels.where((hostel) {
        return hostel.name.toLowerCase().contains(query) ||
            hostel.location.toLowerCase().contains(query);
      }).toList();
    }

    // Existing listener — do not modify
    _searchController.addListener(_filterHostels);
  }

  /// 🔥 IMPORTANT: Refresh hostels when coming back to this page
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      // ✔ Don't override filter, only reset full list
      // (actual filtering continues via searchController listener)
      if (_searchController.text.isEmpty) {
        _filteredHostels = globalHostels;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterHostels() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredHostels = globalHostels;
      } else {
        _filteredHostels = globalHostels.where((hostel) {
          return hostel.name.toLowerCase().contains(query) ||
              hostel.location.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Future<void> _openAddHostel() async {
    final newHostel = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddHostelScreen()),
    );

    if (newHostel != null && newHostel is Hostel) {
      globalHostels.add(newHostel);

      setState(() {
        // refresh the whole list
        _filteredHostels = List.from(globalHostels);

        // re-apply search filter (if search field is not empty)
        _filterHostels();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hostel '${newHostel.name}' added successfully"),
          backgroundColor: AppColors.statusSolved,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _toggleJoinHostel(String hostelId) {
    setState(() {
      final index = globalHostels.indexWhere((h) => h.id == hostelId);
      if (index == -1) return;

      final hostel = globalHostels[index];

      if (hostel.isJoined) {
        _showExitDialog(hostelId);
      } else {
        if (_currentHostelId != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Please exit your current hostel first'),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
          return;
        }

        globalHostels[index] = Hostel(
          id: hostel.id,
          name: hostel.name,
          location: hostel.location,
          rating: hostel.rating,
          reviews: hostel.reviews,
          about: hostel.about ?? "",
          amenities: hostel.amenities,
          isJoined: true,
        );
        _currentHostelId = hostelId;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully joined ${hostel.name}'),
            backgroundColor: AppColors.statusSolved,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      _filterHostels();
    });
  }

  void _showExitDialog(String hostelId) {
    final hostel = globalHostels.firstWhere((h) => h.id == hostelId);

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B6B), Color(0xFFFF4757)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text('Exit current hostel?', style: AppStyles.heading3),
              const SizedBox(height: 12),
              Text(
                'You must exit this hostel before joining another one.',
                style: AppStyles.body2.copyWith(color: AppColors.textGray),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppStyles.body1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B6B), Color(0xFFFF4757)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _exitHostel(hostelId);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Exit hostel',
                          style: AppStyles.body1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _exitHostel(String hostelId) {
    setState(() {
      final index = globalHostels.indexWhere((h) => h.id == hostelId);
      if (index == -1) return;

      final hostel = globalHostels[index];

      globalHostels[index] = Hostel(
        id: hostel.id,
        name: hostel.name,
        location: hostel.location,
        rating: hostel.rating,
        reviews: hostel.reviews,
        about: hostel.about ?? "",
        amenities: hostel.amenities,
        isJoined: false,
      );
      _currentHostelId = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exited ${hostel.name}'),
          backgroundColor: AppColors.textGray,
          behavior: SnackBarBehavior.floating,
        ),
      );

      _filterHostels();
    });
  }

  void _openHostelDetails(Hostel hostel) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => HostelDetailsScreen(hostel: hostel)),
    );
  }

  Hostel? get _getCurrentHostel {
    if (_currentHostelId == null) return null;
    try {
      return globalHostels.firstWhere((h) => h.id == _currentHostelId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      endDrawer: MenuDrawer(
        currentHostel: _getCurrentHostel,
        onExitHostel: () {
          if (_currentHostelId != null) _showExitDialog(_currentHostelId!);
        },
      ),
      body: Builder(
        builder: (context) => Column(
          children: [
            // HEADER
            Container(
              decoration: const BoxDecoration(
                gradient: AppColors.headerGradient,
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TOP ROW
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
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
                                'HostelCare',
                                style: AppStyles.heading3.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () =>
                                Scaffold.of(context).openEndDrawer(),
                            icon: const Icon(
                              Icons.menu_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      Text(
                        'Select Your Hostel',
                        style: AppStyles.heading1.copyWith(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Choose your hostel to get started',
                        style: AppStyles.body1.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 24),

                      CustomTextField(
                        hint: 'Search hostels or cities...',
                        controller: _searchController,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // HOSTEL LIST
            Expanded(
              child: _filteredHostels.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 64,
                            color: AppColors.textLight,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No hostels found',
                            style: AppStyles.body1.copyWith(
                              color: AppColors.textGray,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: _filteredHostels.length,
                      itemBuilder: (context, index) {
                        final hostel = _filteredHostels[index];
                        return HostelCard(
                          hostel: hostel,
                          onJoinPressed: () => _toggleJoinHostel(hostel.id),
                          onCardTap: () => _openHostelDetails(hostel),
                          showExitMessage:
                              _currentHostelId != null && !hostel.isJoined,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
