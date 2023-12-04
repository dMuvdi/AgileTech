import 'package:agile_tech/models/equipment.dart';
import 'package:agile_tech/screens/login_screen.dart';
import 'package:agile_tech/services/graphql_config.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {

  String token = "";
  String name = "";
  String role = "";
  List<Equipment> equipments = [];

  static GraphQLConfig graphQLConfig = GraphQLConfig();

  @override
  void onInit() {
    super.onInit();
    getCredentials();
    getEquipments();
    update();
  }

  void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    name = prefs.getString('name')!;
    print(name);
    role = prefs.getString('role')!;
    print(role);
    if (role == 'ADMIN'){
      role = 'Administrador';
    } else if (role == 'TECHNICIAN'){
      role = 'Técnico';
    } else {
      role = 'Cliente';
    }
    update();
  }

  int getAmountOfEquipments(String category){
    List<Equipment> equipmentCountList = equipments.where((equipment) => equipment.category == category).toList();
    // Get the number of items in the filtered list
    int equipmentCount = equipmentCountList.length;
    return equipmentCount;
  }

  Future<void> getEquipments() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    
    try{
      GraphQLClient client = graphQLConfig.clientToQuery(token);
      final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.noCache,
        document: gql("""
            query GetEqupments{
              getEquipments {
                id
                name
                description
                category
                stock
                imageUrl
              }
            }
      """),
      );
      final QueryResult result = await client.query(options);
      
      if (result.hasException){
        print(result.exception);
        Get.off(const LogInScreen(), transition: Transition.leftToRight);
      }

      List? res = result.data?['getEquipments'];

      if (res == null || res.isEmpty){
        equipments = [];
      } else {
        List<Equipment> equipments = res.map((equipment) => Equipment.fromMap(map: equipment)).toList();
        this.equipments = equipments;
      }
      update();
    } catch (e){
      print(e);
      Get.off(const LogInScreen(), transition: Transition.leftToRight);
    }
  }
}