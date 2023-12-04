import 'package:agile_tech/screens/login_screen.dart';
import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/graphql_config.dart';

class ProfileController extends GetxController {

  static GraphQLConfig graphQLConfig = GraphQLConfig();

  String token = "";
  String name = "";
  String lastName = "";
  String role = "";
  String email = "";

  bool loading = false;

  @override
  onInit() async {
    super.onInit();
    getCredentials();
  }

  void logOut() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Seguro desear cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancelar', style: TextStyle(color: Color(0xFF670F0F),),),
            ),
            TextButton(
              onPressed: () {
                prefs.remove('token');
                prefs.remove('name');
                prefs.remove('lastName');
                prefs.remove('role');
                prefs.remove('email');
                Get.off(() => const LogInScreen(), transition: Transition.fade);
                update();
              },
              child: const Text('OK', style: TextStyle(color: Color(0xFF670F0F),),),
            ),
          ],
        );
      },
    );
  }

  void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!;
    lastName = prefs.getString('lastName')!;
    role = prefs.getString('role')!;
    email = prefs.getString('email')!;
    if (role == 'ADMIN'){
      role = 'Administrador';
    } else if (role == 'TECHNICIAN'){
      role = 'Técnico';
    } else {
      role = 'Cliente';
    }
    update();
  }

  void isLoading(){
    loading = true;
    update(['loading']);
  }

  void isNotLoading(){
    loading = false;
    update(['loading']);
  }

  Future<void> deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    
    try{
      isLoading();
      GraphQLClient client = graphQLConfig.clientToQuery(token);
      final MutationOptions options = MutationOptions(
      fetchPolicy: FetchPolicy.noCache,
        document: gql("""
            mutation DeleteUser(\$id: ID!) {
            removeUser(id:\$id) {
              user{
                name
              }
            }
          }
      """),
        variables: {
          'id': prefs.getString('id'),
        }
      );
      final QueryResult result = await client.mutate(options);
      
      if (result.hasException){
        print(result.exception);
      }
      if(result.data == null){
        showDialog(
          context: Get.context!, 
          builder: (context){
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SimpleDialog(
                backgroundColor:Color(0xFFFFE1E1),
                title: Text(
                  "Error de eliminación", 
                  style: TextStyle(
                    color: Color(0xFF670F0F), 
                    fontFamily: FontFamilyToken.montserrat, 
                    fontSize: 20),
                  ),
                children: [
                  Text(
                    "Por favor intentelo nuevamente", 
                    style: TextStyle(
                      color: Color(0xFF670F0F), 
                      fontFamily: FontFamilyToken.montserrat,
                        fontSize: 14),
                  )
                ],
              ),
            );
          }
        );
        isNotLoading();
      } else {
        Get.off(() => const LogInScreen(), transition: Transition.fade);
        showDialog(
          context: Get.context!, 
          builder: (context){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SimpleDialog(
                backgroundColor:const Color(0xFFFFE1E1),
                title: const Text(
                  "Eliminado con éxito", 
                  style: TextStyle(
                    color: Color(0xFF670F0F), 
                    fontFamily: FontFamilyToken.montserrat, 
                    fontSize: 20),
                  ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Su usuario ${result.data?['removeUser']['user']['name']} ha sido eliminado con éxito", 
                      style: const TextStyle(
                        color: Color(0xFF670F0F), 
                        fontFamily: FontFamilyToken.montserrat,
                          fontSize: 14),
                    ),
                  )
                ],
              ),
            );
          }
        );
        isNotLoading();
      }
    } catch (e){
      print(e);
    }
  }
}