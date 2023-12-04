import 'package:agile_tech/models/user.dart';
import 'package:agile_tech/screens/login_screen.dart';
import 'package:agile_tech/screens/profile_screen.dart';
import 'package:agile_tech/services/graphql_config.dart';
import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/bottom_navigation.dart';

class SignUpController extends GetxController {

  final formKey = GlobalKey<FormState>();

  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToLoginOrSignUp();

  //List of roles
  final List<String> _dropdownItems = ['Administrador', 'Cliente', 'Técnico'];

  String? _name;
  String? _lastName;
  String? _email;
  String? _password;
  final RxString currentRole = 'Cliente'.obs;
  bool loading = false;
  
  List<String> get dropdownItems => _dropdownItems;

  String get role {
    switch(currentRole.value){
      case "Administrador":
        return "ADMIN";
      case "Técnico":
        return "TECHNICIAN";
    }
    return "CLIENT";
  }

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

  void updateDropdownItem(String value){
    currentRole.value = value;
  }

  void isLoading(){
    loading = true;
    update(['loading']);
  }

  void isNotLoading(){
    loading = false;
    update(['loading']);
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

  storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  storeUser(String name, String lastName, String role, String email) async {
    final prefs = await SharedPreferences.getInstance();
    print(name);
    print(lastName);
    print(role);
    print(email);
    await prefs.setString('name', name);
    await prefs.setString('lastName', lastName);
    await prefs.setString('role', role);
    await prefs.setString('email', email);
  }

  Future<void> onSignUp() async {
    if(formKey.currentState!.validate()){
      isLoading();
      final MutationOptions options = MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql("""
            mutation Signup(\$name: String!, \$lastName: String!, \$email: String!, \$password: String!, \$role: UserRole!) {
              signup(signupInput: {
                name: \$name,
                lastName: \$lastName,
                email: \$email,
                password: \$password,
                role: \$role
              }) {
                token
                user {
                  name
                  lastName
                  role
                }
              }
            }
      """),
      variables: {
          'name': _name,
          'lastName': _lastName,
          'email': _email,
          'password': _password,
          'role': role
        },
      );

      final QueryResult result = await client.mutate(options);

      if(result.data == null){
        showDialog(
          context: Get.context!, 
          builder: (context){
            return const SimpleDialog(
              backgroundColor:Color(0xFFFFE1E1),
              title: Text(
                "Error de registro", 
                style: TextStyle(
                  color: Color(0xFF670F0F), 
                  fontFamily: FontFamilyToken.montserrat, 
                  fontSize: 20),
                ),
              children: [
                Text(
                  "Este email ya está en uso por favor ingrese uno diferente", 
                  style: TextStyle(
                    color: Color(0xFF670F0F), 
                    fontFamily: FontFamilyToken.montserrat,
                     fontSize: 14),
                )
              ],
            );
          }
        );
        isNotLoading();
      } else {
        String? token = result.data!['signup']['token'];
        User user = User.fromMap(map: result.data!['signup']['user']);
        storeUser(user.name, user.lastName, user.role, user.email!);
        print(token);
        storeToken(token!);
        isNotLoading();
        if(user.role == "ADMIN"){
          Get.off(() => const BottomNavigation(), transition: Transition.fade);
        } else {
          Get.off(() => const ProfileScreen(), transition: Transition.fade);
        }
      }
    }
  }
}