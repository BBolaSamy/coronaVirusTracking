import 'package:flutter/cupertino.dart';

import 'api_keys.dart';

enum EndPoint {
  cases,
  todayCases,
  active,
  deaths,
  todayDeaths,
  recovered,
  critical,
  casesPerOneMillion,
  deathsPerOneMillion,
  totalTests,
  testsPerOneMillion,
}

class API {
  final String apiKey;
  API({@required this.apiKey});

  factory API.sandbox() => API(apiKey: ApiKeys.sandBoxKeys);

  static final String host = 'apigw.nubentos.com';
  static final int port = 443;
  static final String basePath = "t/nubentos.com/ncovapi/2.0.0";

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );

  Uri endPointUri(EndPoint endPoint) => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: '$basePath/${paths[endPoint]}',
      );

  static Map<EndPoint, String> paths = {
    EndPoint.cases: 'cases',
    EndPoint.active: 'active',
    EndPoint.casesPerOneMillion: 'casesPerOneMillion',
    EndPoint.critical: 'critical',
    EndPoint.deaths: 'deaths',
    EndPoint.deathsPerOneMillion: 'deathsPerOneMillion',
    EndPoint.recovered: 'recovered',
    EndPoint.testsPerOneMillion: 'testsPerOneMillion',
    EndPoint.todayCases: 'todayCases',
    EndPoint.todayDeaths: 'todayDeaths',
    EndPoint.totalTests: 'totalTests',
  };
}
