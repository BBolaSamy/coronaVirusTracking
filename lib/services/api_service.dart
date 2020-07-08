import 'dart:convert';

import 'package:http/http.dart' as http;
import 'api.dart';

class ApiService {
  final API api;
  ApiService(this.api);

  Future<String> getAccesToken() async {
    print("######################");
    http.Response response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['access_token'].toString());
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        'Request ${api.tokenUri()} faild\nResponse: ${response.statusCode} ${response.reasonPhrase}');
  }
}
