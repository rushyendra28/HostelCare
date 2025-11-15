import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const primaryBlue = Color(0xFF5B7FFF);
  static const primaryPurple = Color(0xFFA855F7);
  
  // Background
  static const background = Color(0xFFF5F7FA);
  static const white = Color(0xFFFFFFFF);
  static const cardBackground = Color(0xFFF8F9FE);
  
  // Text
  static const textDark = Color(0xFF1F2937);
  static const textGray = Color(0xFF6B7280);
  static const textLight = Color(0xFF9CA3AF);
  
  // Status Colors
  static const statusInProgress = Color(0xFF5B7FFF);
  static const statusViewed = Color(0xFFFCD34D);
  static const statusSolved = Color(0xFF10B981);
  
  // Error & Warning
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFFCD34D);
  
  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const headerGradient = LinearGradient(
    colors: [Color(0xFF5B7FFF), Color(0xFF8B6FFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}