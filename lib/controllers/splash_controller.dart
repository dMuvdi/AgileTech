import 'package:agile_tech/screens/bottom_navigation.dart';
import 'package:agile_tech/screens/login_screen.dart';
import 'package:agile_tech/screens/profile_screen.dart';
import 'package:agile_tech/services/graphql_config.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {

  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToLoginOrSignUp();
  
  @override
  void onReady() {
    super.onReady();
    startApp();
  }

  Future<void> reLogin(String email, String password) async {
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
                  name
                  lastName
                  role
                }
              }
            }
      """),
      variables: {
          'email': email,
          'password': password,
        },
      );

      final QueryResult result = await client.mutate(options);

      String? token = result.data!['login']['token'];
      storeToken(token!);
  }

  storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> startApp() async {
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    String? token = prefs.getString('token');
    String? role = prefs.getString('role');

    print(token);

    if(email != null && password != null && token != null){
      reLogin(email, password);
      if(role == "ADMIN"){
        Get.off(() => const BottomNavigation(), transition: Transition.fade);
      } else {
        Get.off(() => const ProfileScreen(), transition: Transition.fade);
      }
    } else {
      Get.off(() => const LogInScreen(), transition: Transition.fade);
    }
  }
}