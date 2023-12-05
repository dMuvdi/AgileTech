import 'package:agile_tech/services/graphql_config.dart';
import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/report.dart';

class CreateReportController extends GetxController{

  final formKey = GlobalKey<FormState>();

  static GraphQLConfig graphQLConfig = GraphQLConfig();

  Report report = Get.arguments;
  
  String token = "";
  String? _code;
  String? _description;
  String? equipmentId = Get.arguments;

  bool loading = false;
  
  String? get code => _code;
  String? get description => _description;
  
  set setCode(String value){
    _code = value;
  }

  set setDescription(String value){
    _description = value;
  }

  validateCode(String? value){
    final numericRegex = RegExp(r'^[0-9]+$');
    if(GetUtils.isNullOrBlank(value) == true){
      return "Ingrese el campo requerido correctamente";
    } else if(numericRegex.hasMatch(value!) == false){
      return "El campo no puede contener letras solo números";
    }
    return null;
  }

  validateDescription(String? value){
    if(GetUtils.isNullOrBlank(value) == true){
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

  Future<void> onSubmitUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    String? userId = prefs.getString('id');
    print(userId);
    print(equipmentId);
    GraphQLClient client = graphQLConfig.clientToQuery(token);
    isLoading();
    final MutationOptions options = MutationOptions(
      fetchPolicy: FetchPolicy.noCache,
      document: gql("""
          mutation UpdateReport(\$code: String!, \$description: String!, \$equipmentId: String!, \$userId: String!){
          updateReport(input:{
            code:\$code,
            description:\$description,
            equipmentId:\$equipmentId,
            userId:\$userId
          }){
            report{
              code
              description
            }
          }
        }
    """),
    variables: {
        'code': _code,
        'description': _description,
        'equipmentId': equipmentId,
        'userId': userId,
      },
    );

    final QueryResult result = await client.mutate(options);

    print(result.data);

    if(result.data?['createReport']['report'] == null){
      showDialog(
        context: Get.context!, 
        builder: (context){
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SimpleDialog(
              backgroundColor:Color(0xFFFFE1E1),
              title: Text(
                "Error de registro de reporte", 
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
    } else{
      Get.back();
      showDialog(
        context: Get.context!, 
        builder: (context){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SimpleDialog(
              backgroundColor:const Color(0xFFFFE1E1),
              title: const Text(
                "Reporte creado con éxito", 
                style: TextStyle(
                  color: Color(0xFF670F0F), 
                  fontFamily: FontFamilyToken.montserrat, 
                  fontSize: 20),
                ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "El reporte ${result.data?['createReport']['report']['code']} ha sido creado con éxito", 
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
  }

  Future<void> onSubmit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    String? userId = prefs.getString('id');
    print(userId);
    print(equipmentId);
    GraphQLClient client = graphQLConfig.clientToQuery(token);
    isLoading();
    final MutationOptions options = MutationOptions(
      fetchPolicy: FetchPolicy.noCache,
      document: gql("""
          mutation CreateReport(\$code: String!, \$description: String!, \$equipmentId: String!, \$userId: String!){
          createReport(input:{
            code:\$code,
            description:\$description,
            equipmentId:\$equipmentId,
            userId:\$userId
          }){
            report{
              code
              description
            }
          }
        }
    """),
    variables: {
        'code': _code,
        'description': _description,
        'equipmentId': equipmentId,
        'userId': userId,
      },
    );

    final QueryResult result = await client.mutate(options);

    print(result.data);

    if(result.data?['createReport']['report'] == null){
      showDialog(
        context: Get.context!, 
        builder: (context){
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SimpleDialog(
              backgroundColor:Color(0xFFFFE1E1),
              title: Text(
                "Error de registro de reporte", 
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
    } else{
      Get.back();
      showDialog(
        context: Get.context!, 
        builder: (context){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SimpleDialog(
              backgroundColor:const Color(0xFFFFE1E1),
              title: const Text(
                "Reporte creado con éxito", 
                style: TextStyle(
                  color: Color(0xFF670F0F), 
                  fontFamily: FontFamilyToken.montserrat, 
                  fontSize: 20),
                ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "El reporte ${result.data?['createReport']['report']['code']} ha sido creado con éxito", 
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
  }
}