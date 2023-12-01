import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {

  static HttpLink httpLink = HttpLink('http://192.168.0.224:3000/graphql',);

  GraphQLClient clientToLoginOrSignUp(){
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  }

  GraphQLClient clientToQuery(String token) {

    try{
      final AuthLink authLink = AuthLink(
        getToken: ()  => 'Bearer $token',
      );

      final Link link = authLink.concat(httpLink);

      return GraphQLClient(link: link, cache: GraphQLCache());
    } catch (e){
      print(e);
      return GraphQLClient(link: httpLink, cache: GraphQLCache());
    }
  }
}