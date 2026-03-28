import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/routes/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: "Your College.\nYour Buses.",
      description: "One app for all colleges. Each college manages their own buses, drivers and students independently.",
      icon: Icons.account_balance,
      gradient: AppColors.navyToTeal,
      activeColor: AppColors.teal,
      showIconCircle: true,
    ),
    OnboardingData(
      title: "Track Your Bus\nLive.",
      description: "See exactly where your bus is on the map in real time. No more waiting and guessing at the stop.",
      icon: Icons.location_on_rounded,
      gradient: AppColors.orangeToYellow,
      activeColor: AppColors.orange,
    ),
    OnboardingData(
      title: "Never Miss\nYour Bus.",
      description: "Driver taps START and your bus appears on the map instantly. Get notified when it's nearby.",
      icon: Icons.notifications_active_rounded,
      gradient: AppColors.mintToLightBlue,
      activeColor: AppColors.mint,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(data: _pages[index]);
            },
          ),
          
          // Bottom Navigation Section
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 12,
                    dotColor: AppColors.textGray.withOpacity(0.3),
                    activeDotColor: _pages[_currentPage].activeColor,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Get.offAllNamed(Routes.LOGIN),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: AppColors.textGray,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.navyToTeal,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage == _pages.length - 1) {
                            Get.offAllNamed(Routes.LOGIN);
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1 ? 'Get Started →' : 'Next →',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ).animate(key: ValueKey(_currentPage)).slideY(begin: 0.3, delay: 300.ms, duration: 400.ms).fadeIn(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Gradient Section (55%)
        Expanded(
          flex: 55,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(gradient: data.gradient),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (data.showIconCircle)
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                    ),
                  Icon(
                    data.icon,
                    size: 100,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Bottom Content Section (45%)
        Expanded(
          flex: 45,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(32, 48, 32, 0),
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
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                    fontFamily: 'Poppins',
                  ),
                ).animate(key: ValueKey(data.title)).slideY(begin: 0.3, duration: 400.ms).fadeIn(),
                
                const SizedBox(height: 16),
                
                Text(
                  data.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textGray,
                    height: 1.5,
                    fontFamily: 'Poppins',
                  ),
                ).animate(key: ValueKey(data.description)).slideY(begin: 0.3, delay: 150.ms, duration: 400.ms).fadeIn(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final LinearGradient gradient;
  final Color activeColor;
  final bool showIconCircle;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.activeColor,
    this.showIconCircle = false,
  });
}
