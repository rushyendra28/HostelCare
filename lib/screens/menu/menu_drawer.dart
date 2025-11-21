import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../models/hostel.dart';
import '../admin/admin_login_screen.dart';

class MenuDrawer extends StatelessWidget {
  final Hostel? currentHostel;
  final VoidCallback? onExitHostel;

  const MenuDrawer({Key? key, this.currentHostel, this.onExitHostel})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Header with Gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Menu',
                        style: AppStyles.heading1.copyWith(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
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
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (currentHostel != null) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Hostel',
                            style: AppStyles.caption.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            currentHostel!.name,
                            style: AppStyles.heading3.copyWith(
                              color: Colors.white,
                              fontSize: 18,
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
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  // _MenuTile(
                  //   icon: Icons.home_rounded,
                  //   iconColor: AppColors.primaryBlue,
                  //   iconBackground: AppColors.primaryBlue.withOpacity(0.1),
                  //   title: 'Guest Dashboard',
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     // Navigate to dashboard
                  //   },
                  // ),
                  // const SizedBox(height: 8),
                  // _MenuTile(
                  //   icon: Icons.receipt_long_rounded,
                  //   iconColor: const Color(0xFF10B981),
                  //   iconBackground: const Color(0xFF10B981).withOpacity(0.1),
                  //   title: 'My Complaints',
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     // Navigate to my complaints
                  //   },
                  // ),
                  // const SizedBox(height: 8),
                  // _MenuTile(
                  //   icon: Icons.person_rounded,
                  //   iconColor: const Color(0xFF6B7280),
                  //   iconBackground: const Color(0xFF6B7280).withOpacity(0.1),
                  //   title: 'Profile',
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     // Navigate to profile
                  //   },
                  // ),
                  if (currentHostel != null) ...[
                    const SizedBox(height: 8),
                    _MenuTile(
                      icon: Icons.exit_to_app_rounded,
                      iconColor: AppColors.error,
                      iconBackground: AppColors.error.withOpacity(0.1),
                      title: 'Exit Current Hostel',
                      titleColor: AppColors.error,
                      onTap: () {
                        Navigator.pop(context);
                        onExitHostel?.call();
                      },
                    ),
                  ],
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                    child: Divider(height: 1),
                  ),
                  _MenuTile(
                    icon: Icons.shield_rounded,
                    iconColor: AppColors.primaryBlue,
                    iconBackground: AppColors.primaryBlue.withOpacity(0.1),
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
  final Color iconBackground;
  final String title;
  final Color? titleColor;
  final VoidCallback onTap;

  const _MenuTile({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    this.titleColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: AppStyles.body1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: titleColor ?? AppColors.textDark,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
