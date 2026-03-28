import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_routes.dart';
import '../../modules/splash/splash_screen.dart';
import '../../modules/splash/splash_binding.dart';
import '../../modules/onboarding/onboarding_screen.dart';
import '../../modules/auth/login_screen.dart';
import '../../modules/auth/otp_screen.dart';
import '../../modules/auth/auth_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => const OtpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.ADMIN_DASHBOARD,
      page: () => const PlaceholderScreen(title: 'Admin Dashboard'),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.ADD_BUS,
      page: () => const PlaceholderScreen(title: 'Add Bus'),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.ADD_DRIVER,
      page: () => const PlaceholderScreen(title: 'Add Driver'),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.ADD_STUDENT,
      page: () => const PlaceholderScreen(title: 'Add Student'),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.BUS_LIST,
      page: () => const PlaceholderScreen(title: 'Bus List'),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.DRIVER_LIST,
      page: () => const PlaceholderScreen(title: 'Driver List'),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.STUDENT_LIST,
      page: () => const PlaceholderScreen(title: 'Student List'),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.DRIVER_HOME,
      page: () => const PlaceholderScreen(title: 'Driver Home'),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.STUDENT_HOME,
      page: () => const PlaceholderScreen(title: 'Student Home'),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.STUDENT_TRACKING,
      page: () => const PlaceholderScreen(title: 'Student Tracking'),
      transition: Transition.fadeIn,
    ),
  ];
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Welcome to $title screen')),
    );
  }
}
