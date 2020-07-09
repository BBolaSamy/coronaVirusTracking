import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class ApiService {
  final API api;
  ApiService(this.api);

  Future<String> getAccesToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        'Request ${api.tokenUri()} faild\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    // throw response;
  }

  Future<int> getEndPointData(
      {@required String accessToken, @required EndPoint endPoint}) async {
    final uri = api.endPointUri(endPoint);
    final response = await http.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer ${accessToken}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endPointData = data[0];
        final String _responseJsonKeys = responseJsonKeys[endPoint];
        final int result = endPointData[_responseJsonKeys];
        if (result != null) {
          return result;
        }
      }
    }
    print(
        '//Request ${api.tokenUri()} faild\nResponse: ${response.statusCode} ${response.reasonPhrase}');
  }

  static Map<EndPoint, String> responseJsonKeys = {
    EndPoint.cases: 'data',
    EndPoint.active: 'data',
    EndPoint.casesPerOneMillion: 'data',
    EndPoint.critical: 'data',
    EndPoint.deaths: 'data',
    EndPoint.deathsPerOneMillion: 'data',
    EndPoint.recovered: 'data',
    EndPoint.testsPerOneMillion: 'data',
    EndPoint.todayCases: 'data',
    EndPoint.todayDeaths: 'data',
    EndPoint.totalTests: 'data',
  };
}
