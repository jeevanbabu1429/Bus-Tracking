import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';
import '../../core/services/storage_service.dart';
import '../../core/constants/app_constants.dart';

class SplashController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    _startNavigation();
  }

  Future<void> _startNavigation() async {
    // Wait for 3.5 seconds to show animations
    await Future.delayed(const Duration(milliseconds: 3500));

    final String? token = await _storage.getToken();

    if (token != null) {
      final String? role = await _storage.getUserRole();
      
      switch (role) {
        case AppConstants.ROLE_ADMIN:
          Get.offAllNamed(Routes.ADMIN_DASHBOARD);
          break;
        case AppConstants.ROLE_DRIVER:
          Get.offAllNamed(Routes.DRIVER_HOME);
          break;
        case AppConstants.ROLE_STUDENT:
          Get.offAllNamed(Routes.STUDENT_HOME);
          break;
        default:
          Get.offAllNamed(Routes.LOGIN);
          break;
      }
    } else {
      Get.offAllNamed(Routes.ONBOARDING);
    }
  }
}
