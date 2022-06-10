import 'dart:convert';

import 'dart:typed_data';

class TXBookPolicyResponse {
  String? accountId;
  String? policyNumber;

  TXBookPolicyResponse({this.accountId, this.policyNumber});
  factory TXBookPolicyResponse.fromRawJson(String str) =>
      TXBookPolicyResponse.fromJson(json.decode(str));
  factory TXBookPolicyResponse.fromJson(Map<String, dynamic> json) =>
      TXBookPolicyResponse(
          accountId: json["account_id"], policyNumber: json["policy_id"]);

  Map<String, dynamic> toJson() =>
      {"account_id": accountId, "policy_id": policyNumber};
}

// TxsPolicyResponse txsPolicyResponseFromJson(String str) => TxsPolicyResponse.fromJson(json.decode(str));

// String txsPolicyResponseToJson(TxsPolicyResponse data) => json.encode(data.toJson());

class TXSPolicyResponse {
  TXSPolicyResponse({
    this.policies,
  });

  List<TXSPolicy>? policies;
  factory TXSPolicyResponse.fromRawJson(String str) =>
      TXSPolicyResponse.fromJson(json.decode(str));
  factory TXSPolicyResponse.fromJson(Map<String, dynamic> json) =>
      TXSPolicyResponse(
        policies: json["policies"] == null
            ? null
            : List<TXSPolicy>.from(
                json["policies"].map((x) => TXSPolicy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "policies": policies == null
            ? null
            : List<dynamic>.from(policies!.map((x) => x.toJson())),
      };
}

class TXSPolicy {
  TXSPolicy({
    this.policyId,
    this.policyName,
    this.policyNumber,
    this.expiryDate,
    this.policyStatus,
    this.policyType,
  });

  String? policyId;
  String? policyName;
  String? policyNumber;
  String? expiryDate;
  String? policyStatus;
  String? policyType;

  factory TXSPolicy.fromJson(Map<String, dynamic> json) => TXSPolicy(
        policyId: json["policyId"],
        policyName: json["policyName"],
        policyNumber: json["policyNumber"],
        expiryDate: json["expiryDate"],
        policyStatus: json["policyStatus"],
        policyType: json["policyType"],
      );

  Map<String, dynamic> toJson() => {
        "policyId": policyId,
        "policyName": policyName,
        "policyNumber": policyNumber,
        "expiryDate": expiryDate,
        "policyStatus": policyStatus,
        "policyType": policyType,
      };
}

class TXSDocumentResponse {
  Uint8List? data;
  String? documentPath;
  TXSDocumentResponse({this.data, this.documentPath});
}
