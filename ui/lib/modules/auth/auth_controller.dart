import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';
import '../../core/services/api_service.dart';
import '../../core/services/storage_service.dart';
import '../../core/constants/app_constants.dart';

class AuthController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final StorageService _storage = Get.find<StorageService>();
  
  // Login State
  final mobileController = TextEditingController();
  final isLoading = false.obs;

  // OTP State
  final otpCode = ''.obs;
  final resendSeconds = 30.obs;
  Timer? _timer;

  void startResendTimer() {
    resendSeconds.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value > 0) {
        resendSeconds.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> sendOtp() async {
    final String mobile = mobileController.text.trim();
    
    if (mobile.length != 10 || !GetUtils.isNumericOnly(mobile)) {
      Get.snackbar(
        'Invalid Input',
        'Enter valid 10-digit mobile number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    try {
      isLoading.value = true;
      
      final response = await _api.post('/auth/send-otp', {
        'mobile_number': mobile,
      });

      if (response['success'] == true || response['message'] != null) {
        Get.toNamed(Routes.OTP, arguments: mobile);
        startResendTimer();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String mobile) async {
    if (otpCode.value.length != 6) {
      Get.snackbar(
        'Invalid OTP',
        'Please enter the 6-digit verification code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    try {
      isLoading.value = true;
      
      final response = await _api.post('/auth/verify-otp', {
        'mobile_number': mobile,
        'otp_code': otpCode.value,
      });

      if (response['token'] != null) {
        // Save Auth Data
        await _storage.saveToken(response['token']);
        await _storage.saveUser(response['user']);
        
        final String role = response['user']['role'];
        
        // Navigate based on role
        if (role == AppConstants.ROLE_ADMIN) {
          Get.offAllNamed(Routes.ADMIN_DASHBOARD);
        } else if (role == AppConstants.ROLE_DRIVER) {
          Get.offAllNamed(Routes.DRIVER_HOME);
        } else if (role == AppConstants.ROLE_STUDENT) {
          Get.offAllNamed(Routes.STUDENT_HOME);
        } else {
          Get.snackbar('Success', 'Logged in successfully');
          Get.offAllNamed(Routes.STUDENT_HOME); // Default
        }
      }
    } catch (e) {
      Get.snackbar(
        'Verification Failed',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      otpCode.value = ''; // Clear OTP on fail
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    mobileController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
