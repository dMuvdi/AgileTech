import 'package:agile_tech/screens/bottom_navigation.dart';
import 'package:agile_tech/services/graphql_config.dart';
import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEquipmentController extends GetxController{
  //List of roles
  final List<String> _dropdownItems = ['Mecánico', 'Eléctrico'];

  final formKey = GlobalKey<FormState>();

  static GraphQLConfig graphQLConfig = GraphQLConfig();
  
  String token = "";
  String? _name;
  String? _description;
  int? _stock;
  String _imageUrl = 'no image';
  final RxString currentCategory = 'Mecánico'.obs;
  bool loading = false;
  
  String? get name => _name;
  String? get description => _description;
  int? get stock => _stock;
  String get imageUrl => _imageUrl;
  List<String> get dropdownItems => _dropdownItems;
  
  set setName(String value){
    _name = value;
  }

  set setDescription(String value){
    _description = value;
  }

  set setStock(String value){
    _stock = int.parse(value);
  }

  void updateDropdownItem(String value){
    currentCategory.value = value;
  }

  void getImageUrl(String url){
    _imageUrl = url;
  }

  validateName(String? value){
    if(GetUtils.isNullOrBlank(value) == true){
      return "Ingrese el campo requerido correctamente";
    } else if(value!.length < 10){
      return "Ingrese un nombre válido con más de 10 caracteres";
    }
    return null;
  }

  validateStockAndDescription(String? value){
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

  Future<void> onSubmit() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    GraphQLClient client = graphQLConfig.clientToQuery(token);
    
    if(formKey.currentState!.validate()){
      isLoading();
      final MutationOptions options = MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql("""
            mutation CreateEquipment(\$name: String!, \$description: String, \$category: String, \$stock: Int, \$imageUrl: String!) {
              createEquipment(input: {
                name: \$name,
                description: \$description,
                category: \$category,
                stock: \$stock,
                imageUrl: \$imageUrl,
              }) {
                error
                ok
              }
            }
      """),
      variables: {
          'name': _name,
          'description': _description,
          'category': currentCategory.value,
          'stock': _stock,
          'imageUrl': _imageUrl,
        },
      );

      final QueryResult result = await client.mutate(options);

      print(result.data);

      if(result.data == null){
        showDialog(
          context: Get.context!, 
          builder: (context){
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SimpleDialog(
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
        showDialog(
          context: Get.context!, 
          builder: (context){
            return const SimpleDialog(
              backgroundColor:Color(0xFFFFE1E1),
              title: Text(
                "Registro exitoso", 
                style: TextStyle(
                  color: Color(0xFF670F0F), 
                  fontFamily: FontFamilyToken.montserrat, 
                  fontSize: 20),
                ),
              children: [
                Text(
                  "El equipo se ha registrado exitosamente", 
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
        Get.off(const BottomNavigation());
      }
    }
  }
}