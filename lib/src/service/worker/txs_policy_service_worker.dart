import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teamxservice/src/data/response/txs_policy_response.dart';
import 'package:teamxservice/src/data/response/txs_policydetail_response.dart';
import 'package:teamxservice/src/service/engine/txs_api_client.dart';
import 'package:teamxservice/src/service/engine/txs_api_endpoint.dart';
import 'package:teamxservice/src/service/txs_api_constants.dart';
import 'package:teamxservice/src/service/txs_api_error.dart';
import 'package:teamxservice/src/service/txs_api_header.dart';
import 'package:teamxservice/src/service/txs_api_result.dart';
import 'package:http/http.dart' as http;
import 'package:teamxservice/src/service/txs_api_target.dart';

abstract class TXSPolicyServiceWorkerInterface {
  Future<TXSResult> getPolicies(String token);
  Future<TXSResult> getPolicyDetail(
      String token, String policyNumber, String product);
  Future<TXSResult> getPolicyDocument(String token, String policyNumber);

  Future<TXSResult> getPolicyDocumentFromUrl(String url, String policyNumber);
}

class TXSPolicyServiceWorker implements TXSPolicyServiceWorkerInterface {
  final TXSAPIClient client = TXSAPIClient(client: http.Client());

  @override
  Future<TXSResult> getPolicyDetail(
      String token, String policyNumber, String product) async {
    try {
      var request = TXSServiceRequest(
          baseUrl: TXSConstants.policyBaseUrl,
          path: TXSConstants.policyBasePath +
              TXSConstants.policies +
              "/$policyNumber",
          method: TXSMethod.get,
          headers: TXSHeader.policyDetailHeader(token, product));

      var response = await client.sendRequest(request);
      response = TXSResponseHandler.returnResponse(response);

      return TXSResult<TXSPolicyDetail>.success(
          TXSPolicyDetail.fromRawJson(response.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e is TXSErrorType) {
        return TXSResult.error(e);
      } else if (e is Exception) {
        return TXSResponseHandler.handleException(e);
      } else {
        return TXSResult.error(TXSErrorType.unknown);
      }
    }
  }

  @override
  Future<TXSResult> getPolicyDocument(String token, String policyNumber) async {
    /// getting application doc directory's path in dir variable
    String dir = (await getApplicationDocumentsDirectory()).path;

    /// if `filename` File exists in local system then return that file.
    /// This is the fastest among all.
    if (await File('$dir/$policyNumber.pdf').exists()) {
      return TXSResult<TXSDocumentResponse>.success(
          TXSDocumentResponse(documentPath: '$dir/$policyNumber.pdf'));
    } else {
      try {
        var request = TXSServiceRequest(
            baseUrl: TXSConstants.policyBaseUrl,
            path: TXSConstants.policyBasePath +
                TXSConstants.policies +
                "/$policyNumber/documents",
            method: TXSMethod.get,
            headers: TXSHeader.policyDocumentHeader(token));
        var response = await client.sendRequest(request);
        response = TXSResponseHandler.returnResponse(response);

        String dir = (await getApplicationDocumentsDirectory()).path;

        File file = File('$dir/$policyNumber.pdf');

        await file.writeAsBytes(response.bodyBytes);

        return TXSResult<TXSDocumentResponse>.success(
            TXSDocumentResponse(documentPath: file.path));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        if (e is TXSErrorType) {
          return TXSResult.error(e);
        } else if (e is Exception) {
          return TXSResponseHandler.handleException(e);
        } else {
          return TXSResult.error(TXSErrorType.unknown);
        }
      }
    }
  }

  @override
  Future<TXSResult> getPolicies(String token) async {
    try {
      var jsonText = await rootBundle
          .loadString('packages/teamxservice/assets/json/policy.json');
      var response = TXSPolicyResponse.fromRawJson(jsonText);
      return TXSResult.success(response);
    } catch (e) {
      if (e is TXSErrorType) {
        return TXSResult.error(e);
      } else if (e is Exception) {
        return TXSResponseHandler.handleException(e);
      } else {
        return TXSResult.error(TXSErrorType.unknown);
      }
    }
  }

  @override
  Future<TXSResult> getPolicyDocumentFromUrl(
      String url, String policyNumber) async {
    final dir = (await getApplicationDocumentsDirectory()).path;
    final file = File('$dir/$policyNumber.pdf');
    if (await file.exists()) {
      return TXSResult<TXSDocumentResponse>.success(
          TXSDocumentResponse(documentPath: '$dir/$policyNumber.pdf'));
    }
    final response = await http.get(Uri.parse(url));
    await file.writeAsBytes(response.bodyBytes);
    return TXSResult<TXSDocumentResponse>.success(
        TXSDocumentResponse(documentPath: file.path));
  }
}
