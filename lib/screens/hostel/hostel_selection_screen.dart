import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../models/hostel.dart';
import '../../widgets/hostel_card.dart';
import '../../widgets/custom_text_field.dart';
import 'hostel_details_screen.dart';
import '../menu/menu_drawer.dart';

class HostelSelectionScreen extends StatefulWidget {
  const HostelSelectionScreen({Key? key}) : super(key: key);

  @override
  State<HostelSelectionScreen> createState() => _HostelSelectionScreenState();
}

class _HostelSelectionScreenState extends State<HostelSelectionScreen> {
  final _searchController = TextEditingController();
  String? _currentHostelId;

  // Sample hostel data
  final List<Hostel> _hostels = [
    Hostel(
      id: '1',
      name: 'Sunrise Hostel',
      location: 'Mumbai',
      rating: 4.5,
      reviews: 234,
      about:
          'A modern and well-maintained hostel with excellent facilities. Our hostel provides a safe and comfortable living environment for students and working professionals. We pride ourselves on quick issue resolution and responsive management.',
      amenities: ['Free WiFi', 'Meals', '24/7 Security', 'Common Area'],
      isJoined: false,
    ),
    Hostel(
      id: '2',
      name: 'Green Valley Residence',
      location: 'Bangalore',
      rating: 4.8,
      reviews: 456,
      about: 'Premium hostel with modern amenities and dedicated support.',
      amenities: ['Free WiFi', 'Meals', '24/7 Security', 'Common Area', 'Gym'],
      isJoined: false,
    ),
    Hostel(
      id: '3',
      name: 'Ocean View Hostel',
      location: 'Goa',
      rating: 4.3,
      reviews: 189,
      about: 'Beach-side hostel with stunning views and peaceful environment.',
      amenities: ['Free WiFi', 'Meals', '24/7 Security'],
      isJoined: false,
    ),
    Hostel(
      id: '4',
      name: 'Mountain Peak Lodge',
      location: 'Pune',
      rating: 4.6,
      reviews: 312,
      about: 'Nestled in the hills, perfect for students seeking tranquility.',
      amenities: [
        'Free WiFi',
        'Meals',
        '24/7 Security',
        'Common Area',
        'Study Room',
      ],
      isJoined: false,
    ),
  ];

  List<Hostel> _filteredHostels = [];

  @override
  void initState() {
    super.initState();
    _filteredHostels = _hostels;
    _searchController.addListener(_filterHostels);
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
        _filteredHostels = _hostels;
      } else {
        _filteredHostels = _hostels.where((hostel) {
          return hostel.name.toLowerCase().contains(query) ||
              hostel.location.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _toggleJoinHostel(String hostelId) {
    setState(() {
      final hostelIndex = _hostels.indexWhere((h) => h.id == hostelId);
      if (hostelIndex != -1) {
        final hostel = _hostels[hostelIndex];

        if (hostel.isJoined) {
          // Exit hostel - show confirmation dialog
          _showExitDialog(hostelId);
        } else {
          // Join hostel
          if (_currentHostelId != null) {
            // User already has a hostel, show must exit message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Please exit your current hostel first'),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else {
            // Join the hostel
            _hostels[hostelIndex] = Hostel(
              id: hostel.id,
              name: hostel.name,
              location: hostel.location,
              rating: hostel.rating,
              reviews: hostel.reviews,
              about: hostel.about,
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
        }
      }
    });
  }

  void _showExitDialog(String hostelId) {
    final hostel = _hostels.firstWhere((h) => h.id == hostelId);

    showDialog(
      context: context,
      builder: (context) => Dialog(
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
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
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
              Text(
                'Exit current hostel?',
                style: AppStyles.heading3,
                textAlign: TextAlign.center,
              ),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: AppColors.background,
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
      final hostelIndex = _hostels.indexWhere((h) => h.id == hostelId);
      if (hostelIndex != -1) {
        final hostel = _hostels[hostelIndex];
        _hostels[hostelIndex] = Hostel(
          id: hostel.id,
          name: hostel.name,
          location: hostel.location,
          rating: hostel.rating,
          reviews: hostel.reviews,
          about: hostel.about,
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
      }
    });
  }

  void _navigateToDetails(Hostel hostel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HostelDetailsScreen(hostel: hostel),
      ),
    );
  }

  Hostel? get _getCurrentHostel {
    if (_currentHostelId == null) return null;
    try {
      return _hostels.firstWhere((h) => h.id == _currentHostelId);
    } catch (e) {
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
          if (_currentHostelId != null) {
            _showExitDialog(_currentHostelId!);
          }
        },
      ),
      body: Builder(
        builder: (context) => Column(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // App Bar
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
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Scaffold.of(context).openEndDrawer();
                            },
                            icon: const Icon(
                              Icons.menu_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Title
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

                      // Search Field
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

            // Hostel List
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
                          onCardTap: () => _navigateToDetails(hostel),
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

