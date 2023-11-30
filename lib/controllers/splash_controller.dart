import 'package:agile_tech/screens/bottom_navigation.dart';
import 'package:agile_tech/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  
  @override
  void onReady() {
    super.onReady();
    startApp();
  }

  Future<void> startApp() async {
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if(token != null){
      Get.off(() => const BottomNavigation(), transition: Transition.fade);
    } else {
      Get.off(() => const LogInScreen(), transition: Transition.fade);
    }
  }
}