import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../models/hostel.dart';
import '../../widgets/amenity_card.dart';
import '../../widgets/feature_item.dart';
import '../../widgets/custom_button.dart';
import '../complaint/post_complaint_screen.dart';

class HostelDetailsScreen extends StatelessWidget {
  final Hostel hostel;

  const HostelDetailsScreen({
    Key? key,
    required this.hostel,
  }) : super(key: key);

  IconData _getAmenityIcon(String amenity) {
    final amenityLower = amenity.toLowerCase();
    if (amenityLower.contains('wifi')) {
      return Icons.wifi_rounded;
    } else if (amenityLower.contains('meal')) {
      return Icons.restaurant_rounded;
    } else if (amenityLower.contains('security')) {
      return Icons.shield_rounded;
    } else if (amenityLower.contains('common') || amenityLower.contains('area')) {
      return Icons.people_rounded;
    } else if (amenityLower.contains('gym')) {
      return Icons.fitness_center_rounded;
    } else if (amenityLower.contains('study')) {
      return Icons.menu_book_rounded;
    } else if (amenityLower.contains('laundry')) {
      return Icons.local_laundry_service_rounded;
    } else if (amenityLower.contains('parking')) {
      return Icons.local_parking_rounded;
    } else {
      return Icons.check_circle_rounded;
    }
  }

  void _reportProblem(BuildContext context) {
    if (hostel.isJoined) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostComplaintScreen(hostel: hostel),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please join the hostel first to report a problem'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
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
                          'HostelCare',
                          style: AppStyles.heading3.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // Open menu
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
                      'Hostel Details',
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
                  // Hostel Info Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: AppStyles.cardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hostel.name,
                          style: AppStyles.heading2,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 20,
                              color: AppColors.primaryBlue,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              hostel.location,
                              style: AppStyles.body1.copyWith(
                                color: AppColors.textGray,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Rating and Reviews
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Color(0xFFFCD34D),
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    hostel.rating.toString(),
                                    style: AppStyles.heading2,
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
                              height: 60,
                              color: AppColors.cardBackground,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.rate_review_rounded,
                                    color: AppColors.primaryBlue,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    hostel.reviews.toString(),
                                    style: AppStyles.heading2,
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

                  // About Section
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: AppStyles.cardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About',
                          style: AppStyles.heading3,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          hostel.about ?? 'No description available.',
                          style: AppStyles.body1.copyWith(
                            color: AppColors.textGray,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Amenities Section
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: AppStyles.cardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amenities',
                          style: AppStyles.heading3,
                        ),
                        const SizedBox(height: 16),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.5,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: hostel.amenities.length,
                          itemBuilder: (context, index) {
                            final amenity = hostel.amenities[index];
                            return AmenityCard(
                              amenity: amenity,
                              icon: _getAmenityIcon(amenity),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Features Section
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.statusSolved.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.statusSolved.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FeatureItem(
                          text: 'Real-time complaint tracking',
                        ),
                        const FeatureItem(
                          text: 'Quick response from management',
                        ),
                        const FeatureItem(
                          text: '24/7 support system',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Already Joined or Report Problem Button
                  if (hostel.isJoined) ...[
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.statusSolved.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.statusSolved.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.statusSolved,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Already Joined',
                            style: AppStyles.body1.copyWith(
                              color: AppColors.statusSolved,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'Report a Problem',
                      onPressed: () => _reportProblem(context),
                      icon: const Icon(
                        Icons.chat_bubble_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primaryBlue.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_rounded,
                            color: AppColors.primaryBlue,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
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
                  ],

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