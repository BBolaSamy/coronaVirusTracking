import 'package:flutter/cupertino.dart';

import 'api_keys.dart';

class API {
  final String apiKey;
  API({@required this.apiKey});

  factory API.sandbox()=>API(apiKey:ApiKeys.sandBoxKeys);

  static final String host = 'apigw.nubentos.com';
  static final int port = 443 ;

  Uri tokenUri()=> Uri(
    scheme: 'https',
    host: host,
    port: port,
    path: 'token',
    queryParameters: {'grant_type':'client_credentials'},
  );
}
