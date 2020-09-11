import 'package:corona_tracking/services/api.dart';
import 'package:corona_tracking/services/api_service.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart';

class DataRepository {
  final ApiService apiService;
  DataRepository({@required this.apiService});

  String _accessToken;

  Future<int> getEndPointData(EndPoint endPoint) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccesToken();
      }
      return apiService.getEndPointData(
          accessToken: _accessToken, endPoint: endPoint);
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccesToken();
        return apiService.getEndPointData(
            accessToken: _accessToken, endPoint: endPoint);
      }
      rethrow;
    }
  }
}
