import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'hostel_selection_screen.dart';

class HostelSearchScreen extends StatefulWidget {
  const HostelSearchScreen({Key? key}) : super(key: key);

  @override
  State<HostelSearchScreen> createState() => _HostelSearchScreenState();
}

class _HostelSearchScreenState extends State<HostelSearchScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchHostels() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HostelSelectionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),

              // Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),

              const SizedBox(height: 32),

              // App Name
              Text(
                'HostelCare',
                style: AppStyles.heading1,
              ),

              const SizedBox(height: 8),

              Text(
                'Join your hostel to continue',
                style: AppStyles.body1,
              ),

              const SizedBox(height: 48),

              // Search Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Your Hostel',
                    style: AppStyles.body1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    hint: 'Search hostel name or location...',
                    controller: _searchController,
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Search Button
              CustomButton(
                text: 'Search Hostels',
                onPressed: _searchHostels,
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}