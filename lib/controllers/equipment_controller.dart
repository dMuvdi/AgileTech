import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/equipment.dart';
import '../services/graphql_config.dart';

class EquipmentController extends GetxController {

  static GraphQLConfig graphQLConfig = GraphQLConfig();

  String token = "";

  Equipment? equipment;

  String? id = Get.arguments;

  @override
  onInit() async {
    super.onInit();
    debugPrint(id);
    await getEquipment();
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
          'id': id,
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