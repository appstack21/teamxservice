abstract class TXSTarget {
  late String baseUrl;
  late String path;
  late TXSMethod method;
  late dynamic params;
  late dynamic headers;
  late String scheme;
}

enum TXSMethod { get, post }

extension TXRequestTypeExtention on TXSMethod {
  String get name {
    switch (this) {
      case TXSMethod.get:
        return "GET";

      case TXSMethod.post:
        return "POST";
    }
  }
}
