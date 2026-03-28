import 'package:flutter/material.dart';

class AppColors {
  static const Color navy        = Color(0xFF0B1D3A);
  static const Color teal        = Color(0xFF028090);
  static const Color orange      = Color(0xFFFF6B35);
  static const Color mint        = Color(0xFF02C39A);
  static const Color yellow      = Color(0xFFF9A825);
  static const Color lightBlue   = Color(0xFF00A896);
  static const Color white       = Color(0xFFFFFFFF);
  static const Color offWhite    = Color(0xFFF0F4F8);
  static const Color textGray    = Color(0xFF8899AA);
  static const Color darkGray    = Color(0xFF334455);

  // Gradients
  static const LinearGradient navyToTeal = LinearGradient(
    colors: [Color(0xFF0B1D3A), Color(0xFF028090)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient tealToMint = LinearGradient(
    colors: [Color(0xFF028090), Color(0xFF02C39A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient orangeToYellow = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFF9A825)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient mintToLightBlue = LinearGradient(
    colors: [Color(0xFF02C39A), Color(0xFF00A896)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
