import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../app/theme/app_colors.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B1D3A), Color(0xFF028090)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Animated bus icon inside a white circle
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    spreadRadius: 10,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.directions_bus_rounded,
                  size: 60,
                  color: AppColors.orange,
                ),
              ),
            )
            .animate()
            .scale(
              duration: 600.ms,
              curve: Curves.elasticOut,
            ),

            const SizedBox(height: 24),

            // 2. "CampusRoute" typewriter text
            SizedBox(
              height: 50,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'CampusRoute',
                    textStyle: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),

            const SizedBox(height: 8),

            // 3. "Smart Campus Mobility" tagline text
            const Text(
              'Smart Campus Mobility',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF02C39A),
                letterSpacing: 2.0,
                fontFamily: 'Poppins',
              ),
            )
            .animate()
            .fadeIn(
              delay: 800.ms,
              duration: 500.ms,
            ),

            const SizedBox(height: 60),

            // 4. Circular progress indicator
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: AppColors.orange,
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
