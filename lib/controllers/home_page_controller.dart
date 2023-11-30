import 'package:agile_tech/models/equipment.dart';
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
  GraphQLClient client = graphQLConfig.clientToQuery();

  @override
  void onInit() {
    super.onInit();
    getCredentials();
  }

  void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    name = prefs.getString('name')!;
    if (prefs.getString('role')! == 'ADMIN'){
      role = 'Administrador';
    } else if (prefs.getString('role')! == 'TECHNICIAN'){
      role = 'Técnico';
    } else {
      role = 'Cliente';
    }
    update();
  }

  Future<void> getEquipments() async {
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
              reports {
                code
              }
            }
          }
    """),
    );

    final QueryResult result = await client.query(options);
    
    List? res = result.data?['getEquipments'];

    if (res == null || res.isEmpty){
      equipments = [];
    } else {
      List<Equipment> equipments = res.map((equipment) => Equipment.fromMap(map: equipment)).toList();
      this.equipments = equipments;
    }
  }
}