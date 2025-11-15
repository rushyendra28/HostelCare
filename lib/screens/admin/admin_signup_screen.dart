import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import 'admin_login_screen.dart';

class AdminSignUpScreen extends StatefulWidget {
  const AdminSignUpScreen({Key? key}) : super(key: key);

  @override
  State<AdminSignUpScreen> createState() => _AdminSignUpScreenState();
}

class _AdminSignUpScreenState extends State<AdminSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _hostelNameController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _hostelNameController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        // Show success dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Account Created!',
                    style: AppStyles.heading3,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your admin account has been created successfully.',
                    style: AppStyles.body2.copyWith(color: AppColors.textGray),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Go to Login',
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pushReplacement(
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
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.cardBackground,
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textDark,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                ),

                const SizedBox(height: 40),

                // Title
                Text(
                  'Admin Sign Up',
                  style: AppStyles.heading1,
                ),

                const SizedBox(height: 8),

                Text(
                  'Create an admin account to manage complaints',
                  style: AppStyles.body1.copyWith(
                    color: AppColors.textGray,
                  ),
                ),

                const SizedBox(height: 48),

                // Form Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppStyles.cardDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name
                      Text(
                        'Full Name',
                        style: AppStyles.body1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _nameController,
                        style: AppStyles.body1,
                        decoration: InputDecoration(
                          hintText: 'Enter your full name',
                          hintStyle: AppStyles.body1.copyWith(
                            color: AppColors.textLight,
                          ),
                          prefixIcon: const Icon(
                            Icons.person_rounded,
                            color: AppColors.primaryBlue,
                          ),
                          filled: true,
                          fillColor: AppColors.cardBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Hostel Name
                      Text(
                        'Hostel Name',
                        style: AppStyles.body1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _hostelNameController,
                        style: AppStyles.body1,
                        decoration: InputDecoration(
                          hintText: 'Enter hostel name',
                          hintStyle: AppStyles.body1.copyWith(
                            color: AppColors.textLight,
                          ),
                          prefixIcon: const Icon(
                            Icons.business_rounded,
                            color: AppColors.primaryBlue,
                          ),
                          filled: true,
                          fillColor: AppColors.cardBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter hostel name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Email Field
                      Text(
                        'Email Address',
                        style: AppStyles.body1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: AppStyles.body1,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: AppStyles.body1.copyWith(
                            color: AppColors.textLight,
                          ),
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: AppColors.primaryBlue,
                          ),
                          filled: true,
                          fillColor: AppColors.cardBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Password Field
                      Text(
                        'Password',
                        style: AppStyles.body1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: AppStyles.body1,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: AppStyles.body1.copyWith(
                            color: AppColors.textLight,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_rounded,
                            color: AppColors.primaryBlue,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: AppColors.textGray,
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.cardBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Confirm Password Field
                      Text(
                        'Confirm Password',
                        style: AppStyles.body1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        style: AppStyles.body1,
                        decoration: InputDecoration(
                          hintText: 'Confirm your password',
                          hintStyle: AppStyles.body1.copyWith(
                            color: AppColors.textLight,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_rounded,
                            color: AppColors.primaryBlue,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: AppColors.textGray,
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.cardBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Sign Up Button
                CustomButton(
                  text: 'Create Account',
                  onPressed: _signUp,
                  isLoading: _isLoading,
                  icon: const Icon(
                    Icons.person_add_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),

                const SizedBox(height: 24),

                // Login Link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppStyles.body2.copyWith(
                          color: AppColors.textGray,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdminLoginScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Login',
                          style: AppStyles.body2.copyWith(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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