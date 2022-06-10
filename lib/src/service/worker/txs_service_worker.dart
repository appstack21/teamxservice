import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:teamxservice/src/data/entity/txs_policy_request.dart';
import 'package:teamxservice/src/data/response/txs_partner_response.dart';
import 'package:teamxservice/src/data/response/txs_policy_response.dart';
import 'package:teamxservice/src/service/engine/txs_api_client.dart';
import 'package:teamxservice/src/service/engine/txs_api_endpoint.dart';
import 'package:teamxservice/src/service/txs_api_constants.dart';
import 'package:teamxservice/src/service/txs_api_error.dart';
import 'package:teamxservice/src/service/txs_api_header.dart';
import 'package:teamxservice/src/service/txs_api_result.dart';
import 'package:http/http.dart' as http;
import 'package:teamxservice/src/service/txs_api_target.dart';

abstract class TXSServiceWorkerInterface {
  Future<TXSResult> bookPolicy(String token, dynamic userData);
  Future<TXSResult> fetchPartner(String token, String partnerCode);
}

class TXSServiceWorker implements TXSServiceWorkerInterface {
  final TXSAPIClient client = TXSAPIClient(client: http.Client());

  @override
  Future<TXSResult> bookPolicy(String token, dynamic userData) async {
    try {
      var policyRequestData = TXSPolicyBookRequest.createRequest();
      var request = TXSServiceRequest(
          baseUrl: TXSConstants.baseUrl,
          path: TXSConstants.bookPolicyPath,
          method: TXSMethod.post,
          headers: TXSHeader.bookPolicyHeader(),
          params: policyRequestData.toRawJson());

      var response = await client.sendRequest(request);
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      if (kDebugMode) {
        print("RESPONSE $response");
      }
      response = TXSResponseHandler.returnResponse(response);

      return TXSResult<TXBookPolicyResponse>.success(
          TXBookPolicyResponse.fromRawJson(response.body));
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
  Future<TXSResult> fetchPartner(String token, String partnerCode) async {
    try {
      var jsonText = await rootBundle
          .loadString('packages/teamxservice/assets/json/partner.json');
      var response = TXSPartnerResponse.fromRawJson(jsonText);
      return TXSResult.success(response.partner);
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
}
