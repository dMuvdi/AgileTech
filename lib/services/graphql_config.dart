import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraphQLConfig {

  GraphQLClient clientToQuery() {

    final HttpLink httpLink = HttpLink(
      'http://192.168.0.224:3000/graphql',
    );

    final AuthLink authLink = AuthLink(
      getToken: ()  => 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImIyMGFkZDE1LTUwZTEtNGZiZS04MTM3LTBhMTI0Mzk0YWI3MyIsImlhdCI6MTcwMTM4MzU1NSwiZXhwIjoxNzAxMzk3OTU1fQ.gDVV4hExExfuciPkw0fAm1t5KF7O_fTfprlJnA9Hf8Q',
    );

    print(authLink);

    // Combine the HttpLink and AuthLink
    final Link link = authLink.concat(httpLink);

    return GraphQLClient(link: link, cache: GraphQLCache());
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    return 'Bearer $token';
  }
}