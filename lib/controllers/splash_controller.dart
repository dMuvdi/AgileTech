import 'package:agile_tech/screens/login_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  
  @override
  void onReady() {
    super.onReady();
    startApp();
  }

  Future<void> startApp() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.off(() => const LogInScreen(), transition: Transition.fade);
  }
}