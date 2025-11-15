import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../models/hostel.dart';
import '../admin/admin_login_screen.dart';

class MenuDrawer extends StatelessWidget {
  final Hostel? currentHostel;
  final VoidCallback? onExitHostel;

  const MenuDrawer({
    Key? key,
    this.currentHostel,
    this.onExitHostel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Menu',
                        style: AppStyles.heading2.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  if (currentHostel != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Hostel',
                            style: AppStyles.caption.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentHostel!.name,
                            style: AppStyles.body1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  _MenuTile(
                    icon: Icons.home_rounded,
                    iconColor: AppColors.primaryBlue,
                    title: 'Guest Dashboard',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to dashboard
                    },
                  ),
                  _MenuTile(
                    icon: Icons.receipt_long_rounded,
                    iconColor: const Color(0xFF10B981),
                    title: 'My Complaints',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to my complaints
                    },
                  ),
                  _MenuTile(
                    icon: Icons.person_rounded,
                    iconColor: const Color(0xFF6B7280),
                    title: 'Profile',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to profile
                    },
                  ),
                  if (currentHostel != null)
                    _MenuTile(
                      icon: Icons.exit_to_app_rounded,
                      iconColor: AppColors.error,
                      title: 'Exit Current Hostel',
                      backgroundColor: AppColors.error.withOpacity(0.05),
                      onTap: () {
                        Navigator.pop(context);
                        onExitHostel?.call();
                      },
                    ),
                  const Divider(height: 32),
                  _MenuTile(
                    icon: Icons.admin_panel_settings_rounded,
                    iconColor: AppColors.primaryBlue,
                    title: 'Admin Login',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminLoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const _MenuTile({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: backgroundColor ?? iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: AppStyles.body1.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: AppColors.textLight,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}