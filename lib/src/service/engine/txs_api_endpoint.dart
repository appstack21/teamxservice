import 'package:teamxservice/src/service/txs_api_target.dart';

class TXSServiceRequest implements TXSTarget {
  TXSServiceRequest(
      {required this.baseUrl,
      required this.path,
      required this.method,
      this.headers,
      this.params,
      this.scheme = "https"});
  @override
  String baseUrl;

  @override
  dynamic headers;

  @override
  dynamic params;

  @override
  String path;

  @override
  TXSMethod method;

  @override
  String scheme;
}
