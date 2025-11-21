import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../models/hostel.dart';
import '../../data/hostel_data.dart';
import '../complaint/post_complaint_screen.dart';

class HostelDetailsScreen extends StatefulWidget {
  final Hostel hostel;

  const HostelDetailsScreen({Key? key, required this.hostel}) : super(key: key);

  @override
  State<HostelDetailsScreen> createState() => _HostelDetailsScreenState();
}

class _HostelDetailsScreenState extends State<HostelDetailsScreen> {
  late Hostel _hostel; // current hostel in this screen
  Hostel? _joinedHostel; // any hostel that is currently joined (global)

  @override
  void initState() {
    super.initState();

    // sync _hostel with global list if present
    final index = globalHostels.indexWhere((h) => h.id == widget.hostel.id);
    if (index != -1) {
      _hostel = globalHostels[index];
    } else {
      _hostel = widget.hostel;
    }

    // find any joined hostel globally
    Hostel? joined;
    for (final h in globalHostels) {
      if (h.isJoined) {
        joined = h;
        break;
      }
    }
    _joinedHostel = joined;
  }

  bool get _isJoined => _hostel.isJoined;

  String get _cityName {
    try {
      final parts = _hostel.location.split(',');
      if (parts.length >= 4) {
        return parts[3].trim();
      }
      return _hostel.location;
    } catch (_) {
      return _hostel.location;
    }
  }

  void _joinHostel() {
    // if some OTHER hostel is already joined, block joining this one
    if (_joinedHostel != null && _joinedHostel!.id != _hostel.id) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please exit your current hostel first'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      final idx = globalHostels.indexWhere((h) => h.id == _hostel.id);
      final updated = Hostel(
        id: _hostel.id,
        name: _hostel.name,
        location: _hostel.location,
        rating: _hostel.rating,
        reviews: _hostel.reviews,
        about: _hostel.about ?? '',
        amenities: _hostel.amenities,
        isJoined: true,
      );

      _hostel = updated;
      if (idx != -1) {
        globalHostels[idx] = updated;
      }
      _joinedHostel = updated;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Joined ${_hostel.name}'),
        backgroundColor: AppColors.statusSolved,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _exitHostel() {
    setState(() {
      final idx = globalHostels.indexWhere((h) => h.id == _hostel.id);
      final updated = Hostel(
        id: _hostel.id,
        name: _hostel.name,
        location: _hostel.location,
        rating: _hostel.rating,
        reviews: _hostel.reviews,
        about: _hostel.about ?? '',
        amenities: _hostel.amenities,
        isJoined: false,
      );

      _hostel = updated;
      if (idx != -1) {
        globalHostels[idx] = updated;
      }

      // if this hostel was the joined one, clear global joined
      if (_joinedHostel != null && _joinedHostel!.id == updated.id) {
        _joinedHostel = null;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exited ${_hostel.name}'),
        backgroundColor: AppColors.textGray,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Short label mapping for amenities to match the design (Free, Meals, 24/7, Comm, etc.)
  String _shortAmenityLabel(String a) {
    switch (a.toLowerCase()) {
      case 'free wifi':
        return 'Free';
      case 'meals':
        return 'Meals';
      case '24/7 security':
        return '24/7';
      case 'common area':
        return 'Comm';
      default:
        // default -> first word
        final parts = a.split(' ');
        return parts.isNotEmpty ? parts.first : a;
    }
  }

  IconData _amenityIcon(String a) {
    final lower = a.toLowerCase();
    if (lower.contains('wifi')) return Icons.wifi_rounded;
    if (lower.contains('meal') || lower.contains('food')) {
      return Icons.restaurant_rounded;
    }
    if (lower.contains('security') || lower.contains('guard')) {
      return Icons.shield_rounded;
    }
    if (lower.contains('common') || lower.contains('community')) {
      return Icons.groups_rounded;
    }
    if (lower.contains('gym')) return Icons.fitness_center_rounded;
    if (lower.contains('study')) return Icons.menu_book_rounded;
    if (lower.contains('laundry')) return Icons.local_laundry_service_rounded;
    if (lower.contains('hot water')) return Icons.water_drop_rounded;
    return Icons.check_rounded;
  }

  @override
  Widget build(BuildContext context) {
    // Static “features” list, like in screenshot
    const features = [
      'Real-time complaint tracking',
      'Quick response from management',
      '24/7 support system',
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // HEADER (gradient, back, bolt, title, menu)
            Container(
              decoration: const BoxDecoration(
                gradient: AppColors.headerGradient,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: back + bolt + title + menu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Back button
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Bolt icon
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14),
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
                      // IconButton(
                      //   onPressed: () {
                      //     // If you later add a drawer, open it here
                      //     // Scaffold.of(context).openEndDrawer();
                      //   },
                      //   icon: const Icon(
                      //     Icons.menu_rounded,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Hostel Details',
                    style: AppStyles.heading1.copyWith(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // BODY
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // MAIN HOSTEL CARD (name, city, rating, reviews)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppStyles.cardDecoration.copyWith(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _hostel.name,
                            style: AppStyles.heading2.copyWith(fontSize: 22),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 18,
                                color: AppColors.primaryBlue,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _cityName,
                                style: AppStyles.body1.copyWith(
                                  color: AppColors.textGray,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              // Rating
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      size: 28,
                                      color: Color(0xFFFCD34D),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _hostel.rating.toStringAsFixed(1),
                                      style: AppStyles.heading2.copyWith(
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Rating',
                                      style: AppStyles.caption.copyWith(
                                        color: AppColors.textGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: 1,
                                height: 48,
                                color: AppColors.cardBackground,
                              ),

                              // Reviews
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.edit_note_rounded,
                                      size: 28,
                                      color: AppColors.primaryBlue,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _hostel.reviews.toString(),
                                      style: AppStyles.heading2.copyWith(
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Reviews',
                                      style: AppStyles.caption.copyWith(
                                        color: AppColors.textGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ABOUT CARD
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppStyles.cardDecoration.copyWith(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: AppStyles.heading3.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            (_hostel.about ?? '').isEmpty
                                ? 'No description available.'
                                : _hostel.about!,
                            style: AppStyles.body1.copyWith(
                              color: AppColors.textDark,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // AMENITIES CARD
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: AppStyles.cardDecoration.copyWith(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amenities',
                            style: AppStyles.heading3.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 14,
                            runSpacing: 14,
                            children: _hostel.amenities.map((a) {
                              final label = _shortAmenityLabel(a);
                              final icon = _amenityIcon(a);
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBlue.withOpacity(
                                    0.06,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.primaryBlue.withOpacity(
                                      0.3,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      icon,
                                      size: 18,
                                      color: AppColors.primaryBlue,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      label,
                                      style: AppStyles.body2.copyWith(
                                        color: AppColors.primaryBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // FEATURES (green box)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F9F0),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFBBE7C8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: features.map((text) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF34C759),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    text,
                                    style: AppStyles.body1.copyWith(
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // BOTTOM STATE: info + button
                    if (!_isJoined) ...[
                      // info banner
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7ECFF),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primaryBlue.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.info_rounded,
                              color: AppColors.primaryBlue,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Join this hostel to report problems and track complaints',
                                style: AppStyles.body2.copyWith(
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Join Hostel button (gradient style)
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Container(
                      //     decoration: const BoxDecoration(
                      //       gradient: AppColors.headerGradient,
                      //       borderRadius: BorderRadius.all(Radius.circular(20)),
                      //     ),
                      //     child: ElevatedButton(
                      //       onPressed: _joinHostel,
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.transparent,
                      //         shadowColor: Colors.transparent,
                      //         padding: const EdgeInsets.symmetric(vertical: 16),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //       ),
                      //       child: Text(
                      //         'Join Hostel',
                      //         style: AppStyles.body1.copyWith(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ] else ...[
                      // Already joined banner
                      // Container(
                      //   width: double.infinity,
                      //   padding: const EdgeInsets.all(16),
                      //   decoration: BoxDecoration(
                      //     color: const Color(0xFFE9F9F0),
                      //     borderRadius: BorderRadius.circular(20),
                      //     border: Border.all(color: const Color(0xFFBBE7C8)),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       const Icon(
                      //         Icons.check_circle_rounded,
                      //         color: Color(0xFF34C759),
                      //       ),
                      //       const SizedBox(width: 10),
                      //       Text(
                      //         'Already Joined',
                      //         style: AppStyles.body1.copyWith(
                      //           color: const Color(0xFF2E7D32),
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //       const Spacer(),
                      //       TextButton(
                      //         onPressed: _exitHostel,
                      //         child: Text(
                      //           'Exit',
                      //           style: AppStyles.body2.copyWith(
                      //             color: AppColors.error,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 16),

                      // Report a Problem button
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: AppColors.headerGradient,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      PostComplaintScreen(hostel: _hostel),
                                ),
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Report a Problem  →',
                                  style: AppStyles.body1.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
