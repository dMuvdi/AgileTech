import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/equipment.dart';
import '../services/graphql_config.dart';

class EquipmentController extends GetxController {

  static GraphQLConfig graphQLConfig = GraphQLConfig();

  String token = "";

  Equipment? equipment = Get.arguments;

  bool loading = false;

  @override
  onInit() async {
    super.onInit();
    debugPrint(equipment!.id);
    await getEquipment();
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

  Future<void> deleteEquipment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    
    try{
      isLoading();
      GraphQLClient client = graphQLConfig.clientToQuery(token);
      final MutationOptions options = MutationOptions(
      fetchPolicy: FetchPolicy.noCache,
        document: gql("""
            mutation DeleteEquipment(\$id: ID!) {
            removeEquipment(id:\$id) {
              equipment{
                name
                description
              }
            }
          }
      """),
        variables: {
          'id': equipment!.id,
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
                    "Porfavor intentelo nuevamente", 
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
        Get.back();
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
                      "El equipo ${result.data?['removeEquipment']['equipment']['name']} ha sido eliminado con éxito", 
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

  Future<void> getEquipment() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    
    try{
      GraphQLClient client = graphQLConfig.clientToQuery(token);
      final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.noCache,
        document: gql("""
            query GetEquipment(\$id: String!){
            getEquipment(id:\$id){
              error
              ok
              equipment{
                id
                name
                description
                category
                stock
                imageUrl
              }
            }
          }
      """),
        variables: {
          'id': equipment!.id,
        }
      );
      final QueryResult result = await client.query(options);
      
      if (result.hasException){
        print(result.exception);
      }

      Map<String, dynamic>? res = result.data?['getEquipment']['equipment'];

      if (res == null || res.isEmpty){
        equipment = null;
      } else {
        equipment = Equipment.fromMap(map: res);
        print(equipment!.name);
      }
      update();
    } catch (e){
      print(e);
    }
  }
  
}