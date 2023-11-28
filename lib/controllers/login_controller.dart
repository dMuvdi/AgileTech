import 'package:agile_tech/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {

  final formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  String? get email => _email;
  String? get password => _password;

  set setEmail(String value){
    _email = value;
  }

  set setPassword(String pwd){
    _password = pwd;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  
  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => super.onDelete;

  validateEmail(String? email){
    if(!GetUtils.isEmail(email!) || GetUtils.isNullOrBlank(email) == null){
      return "Ingrese el campo requerido correctamente";
    }
    return null;
  }

  validatePassword(String? pwd){
    if(GetUtils.isNullOrBlank(pwd) == true){
      return "Ingrese el campo requerido correctamente";
    }
    return null;
  }

  goToSignUp(){
    Get.off(() => const SignUpScreen(), transition: Transition.rightToLeft);
  }

  onLogIn() async {
    if(formKey.currentState!.validate()){
      Get.snackbar(
        "Success",
        "${_email}, ${_password}",
        snackPosition: SnackPosition.BOTTOM,
        padding: const EdgeInsets.all(10),
      );
      return;
    } else {
      Get.snackbar(
        "Error",
        "Fields empty",
        snackPosition: SnackPosition.BOTTOM,
        padding: const EdgeInsets.all(10),
      );
      return;
    }
  }
}