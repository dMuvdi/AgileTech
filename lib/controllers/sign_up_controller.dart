import 'package:agile_tech/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {

  final formKey = GlobalKey<FormState>();

  //List of roles
  final List<String> _dropdownItems = ['Administrador', 'Cliente', 'Técnico'];

  String? _name;
  String? _lastName;
  String? _email;
  String? _password;
  final RxString currentRole = 'Cliente'.obs;
  
  String? get name => _name;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get password => _password;
  List<String> get dropdownItems => _dropdownItems;

  set setName(String value){
    _name = value;
  }

  set setLastName(String value){
    _lastName = value;
  }

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

  void updateDropdownItem(String value){
    currentRole.value = value;
  }

  validateNameAndLastName(String? value){
    if(GetUtils.isNullOrBlank(value) == true){
      return "Ingrese el campo requerido correctamente";
    }
    return null;
  }

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

  validatePasswordReType(String? pwd){
    if(GetUtils.isNullOrBlank(pwd) == true){
      return "Ingrese el campo requerido correctamente";
    }
    if(pwd != _password){
        return "Las contraseñas no coinciden";
    }
    return null;
  }

  goToLogIn(){
    Get.off(() => const LogInScreen(), transition: Transition.leftToRight);
  }

  onSignUp() async {
    if(formKey.currentState!.validate()){
      Get.snackbar(
        "Success",
        "${_name}, ${_lastName}, ${currentRole}, ${_email}, ${_password}",
        snackPosition: SnackPosition.BOTTOM,
        padding: const EdgeInsets.all(10),
      );
      return;
    } else {
      Get.snackbar(
        "Error",
        "Error",
        snackPosition: SnackPosition.BOTTOM,
        padding: const EdgeInsets.all(10),
      );
      return;
    }
  }
}