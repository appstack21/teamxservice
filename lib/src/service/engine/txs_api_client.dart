import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teamxservice/src/service/txs_api_target.dart';

abstract class TXAPIClientInterface {}

class TXSAPIClient {
  TXSAPIClient({required this.client});
  final http.Client client;

  Future<http.Response> sendRequest(TXSTarget request) async {
    switch (request.method) {
      case TXSMethod.get:
        Uri uri = Uri(
            scheme: request.scheme,
            host: request.baseUrl,
            path: request.path,
            queryParameters: request.params);
        print(uri);
        return client.get(uri, headers: request.headers);
      case TXSMethod.post:
        Uri uri = Uri(
            scheme: request.scheme, host: request.baseUrl, path: request.path);
        return client.post(uri, headers: request.headers, body: request.params);
    }
  }
}
