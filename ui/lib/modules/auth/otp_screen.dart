import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import 'auth_controller.dart';

class OtpScreen extends GetView<AuthController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String mobile = Get.arguments ?? '';
    final String obscuredMobile = mobile.length == 10 
        ? 'XXXXXX${mobile.substring(6)}' 
        : mobile;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              // Top Section (35%)
              Expanded(
                flex: 35,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF028090), Color(0xFF02C39A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Back Button
                      Positioned(
                        top: 50,
                        left: 16,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                          onPressed: () => Get.back(),
                        ),
                      ),
                      // Content
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.lock_outline_rounded, size: 48, color: Colors.white),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Verify OTP',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Sent to +91 $obscuredMobile',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.85),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Section (65%)
              Expanded(
                flex: 65,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(28, 40, 28, 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter 6-digit OTP',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.navy,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // OTP Fields
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        autoFocus: true,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navy,
                          fontFamily: 'Poppins',
                        ),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12),
                          fieldHeight: 50,
                          fieldWidth: 45,
                          activeFillColor: AppColors.teal.withOpacity(0.1),
                          inactiveFillColor: AppColors.offWhite,
                          selectedFillColor: Colors.white,
                          activeColor: AppColors.teal,
                          inactiveColor: Colors.grey.shade300,
                          selectedColor: AppColors.orange,
                        ),
                        onChanged: (value) => controller.otpCode.value = value,
                      ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, duration: 400.ms),

                      const SizedBox(height: 16),

                      // Resend Section
                      Row(
                        children: [
                          const Text(
                            "Didn't receive OTP? ",
                            style: TextStyle(
                              color: AppColors.textGray,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Obx(() => controller.resendSeconds.value > 0
                              ? Text(
                                  "Resend in ${controller.resendSeconds.value}s",
                                  style: const TextStyle(
                                    color: AppColors.orange,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => controller.sendOtp(),
                                  child: const Text(
                                    "Resend OTP",
                                    style: TextStyle(
                                      color: AppColors.teal,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                )),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Verify Button
                      Obx(() => Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: AppColors.navyToTeal,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.navy.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value 
                              ? null 
                              : () => controller.verifyOtp(mobile),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : const Text(
                                  'Verify & Continue →',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                        ),
                      )).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, duration: 400.ms),

                      const SizedBox(height: 32),
                      const Center(
                        child: Text(
                          'OTP is valid for 5 minutes',
                          style: TextStyle(
                            color: AppColors.textGray,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
