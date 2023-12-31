import 'package:agile_tech/screens/profile_screen.dart';
import 'package:agile_tech/screens/sign_up_screen.dart';
import 'package:agile_tech/services/graphql_config.dart';
import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../screens/bottom_navigation.dart';

class LogInController extends GetxController {

  final formKey = GlobalKey<FormState>();

  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToLoginOrSignUp();

  String? _email;
  String? _password;
  bool loading = false;
  RxBool isLoggedin = false.obs;

  String? get email => _email;
  String? get password => _password;

  set setEmail(String value){
    _email = value;
  }

  set setPassword(String pwd){
    _password = pwd;
  }

  validateEmail(String? email){
    if(!GetUtils.isEmail(email!) || GetUtils.isNullOrBlank(email) == null){
      return "Ingrese el campo requerido correctamente";
    }
    return null;
  }

  void isLoading(){
    loading = true;
    update(['loading']);
  }

  void isNotLoading(){
    loading = false;
    update(['loading']);
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

  storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  storeUser(String id, String name, String lastName, String role, String mail, String pwd) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
    prefs.setString('name', name);
    prefs.setString('lastName', lastName);
    prefs.setString('role', role);
    prefs.setString('email', mail);
    prefs.setString('password', pwd);
    update();
  }

  Future<void> onLogin() async {
    
    if(formKey.currentState!.validate()){
      isLoading();
      final MutationOptions options = MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql("""
            mutation LogIn(\$email: String!, \$password: String!) {
              login(loginInput: {
                email: \$email,
                password: \$password,
              }) {
                token
                user{
                  id
                  name
                  lastName
                  role
                }
              }
            }
      """),
      variables: {
          'email': _email,
          'password': _password,
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
                "Error de incio de sesión", 
                style: TextStyle(
                  color: Color(0xFF670F0F), 
                  fontFamily: FontFamilyToken.montserrat, 
                  fontSize: 20),
                ),
              children: [
                Text(
                  "Email in contraseña no coinciden", 
                  style: TextStyle(
                    color: Color(0xFF670F0F), 
                    fontFamily: FontFamilyToken.montserrat,
                     fontSize: 14),
                )
              ],
            );
          }
        );
      } else {
        String? token = result.data!['login']['token'];
        User user = User.fromMap(map: result.data!['login']['user']);
        storeUser(user.id!, user.name, user.lastName, user.role, _email!, _password!);
        print(token);
        print(user.name);
        storeToken(token!);
        isNotLoading();
        update();
        if(user.role == "ADMIN"){
          Get.off(() => const BottomNavigation(), transition: Transition.fade);
        } else {
          Get.off(() => const ProfileScreen(), transition: Transition.fade);
        }
      }
    }
  }
}