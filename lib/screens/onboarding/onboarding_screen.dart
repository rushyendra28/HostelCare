import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_styles.dart';
import '../../widgets/custom_button.dart';
import '../../models/onboarding_item.dart';
import '../../screens/hostel/hostel_search_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      title: AppStrings.onboarding1Title,
      subtitle: AppStrings.onboarding1Subtitle,
      iconPath: 'document', // Using icon name
    ),
    OnboardingItem(
      title: AppStrings.onboarding2Title,
      subtitle: AppStrings.onboarding2Subtitle,
      iconPath: 'activity',
    ),
    OnboardingItem(
      title: AppStrings.onboarding3Title,
      subtitle: AppStrings.onboarding3Subtitle,
      iconPath: 'shield',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _skipOnboarding() {
    _finishOnboarding();
  }

  void _finishOnboarding() {
    // Navigate to hostel search screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HostelSearchScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _onboardingItems.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_onboardingItems[index]);
                },
              ),
            ),

            // Page Indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _onboardingItems.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.primaryBlue,
                  dotColor: AppColors.textLight.withOpacity(0.3),
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 4,
                  spacing: 8,
                ),
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CustomButton(
                    text: _currentPage == _onboardingItems.length - 1
                        ? AppStrings.getStarted
                        : AppStrings.next,
                    onPressed: _nextPage,
                  ),
                  if (_currentPage < _onboardingItems.length - 1) ...[
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _skipOnboarding,
                      child: Text(
                        AppStrings.skip,
                        style: AppStyles.body1.copyWith(
                          color: AppColors.textGray,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Container
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              color: _getIconColor(item.iconPath).withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: _getIconColor(item.iconPath).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  _getIconData(item.iconPath),
                  size: 100,
                  color: _getIconColor(item.iconPath).withOpacity(0.6),
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),

          // Title
          Text(
            item.title,
            style: AppStyles.heading1.copyWith(fontSize: 28),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Subtitle
          Text(
            item.subtitle,
            style: AppStyles.body1.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconPath) {
    switch (iconPath) {
      case 'document':
        return Icons.description_rounded;
      case 'activity':
        return Icons.show_chart_rounded;
      case 'shield':
        return Icons.verified_user_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  Color _getIconColor(String iconPath) {
    switch (iconPath) {
      case 'document':
        return const Color(0xFF8B9FFF);
      case 'activity':
        return const Color(0xFF8B7FFF);
      case 'shield':
        return const Color(0xFF7FD4D4);
      default:
        return AppColors.primaryBlue;
    }
  }
}