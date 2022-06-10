import 'package:http/http.dart';

class TXSHeader {
  static var country = "sg";
  static var product = "staycation";
  static var partner = "dbs";
  static var campaign = "pweb-sp";
  static var contentType = "application/json";
  static var authoraization = "Authorization";
  static var apiVersion = "apiVersion";

  static var subscriptionKey = "Ocp-Apim-Subscription-Key";

  static Object bookPolicyHeader() {
    return {
      "Content-Type": TXSHeader.contentType,
      "country": TXSHeader.country,
      "product": TXSHeader.product,
      "partner": TXSHeader.partner,
      "campaign": TXSHeader.campaign,
    };
  }

  static Object commonHeader(String? token) {
    var header = {
      "Authorization": "Bearer $token",
      "Content-Type": TXSHeader.contentType,
      "country": TXSHeader.country,
      "product": TXSHeader.product,
      "partner": TXSHeader.partner,
      "campaign": TXSHeader.campaign,
    };
    if (token != null) {
      header.addAll({"Authorization": "Bearer $token"});
    }
    return header;
  }

  static Object policyDetailHeader(String token, String product) {
    return {
      'apiVersion': '1',
      "Content-Type": TXSHeader.contentType,
      'Ocp-Apim-Subscription-Key': '445a83b5ee1b44d49443379fcb7259ae',
      'country': 'sg',
      'product': product,
      'studio-version': '2',
      'Authorization': 'Bearer $token',
    };
  }

  static Object policyDocumentHeader(String token) {
    return {
      'apiVersion': '1',
      'Ocp-Apim-Subscription-Key': '445a83b5ee1b44d49443379fcb7259ae',
      'country': 'sg',
      'product': 'default',
      'studio-version': '2',
      'Content-Type': 'application/pdf',
      'Authorization': 'Bearer $token',
    };
  }
}
