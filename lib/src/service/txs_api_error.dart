import 'dart:async';
import 'dart:io';

import 'package:teamxservice/src/service/txs_api_result.dart';
import 'package:http/http.dart' as http;

enum TXSErrorType {
  emptyResponse,

  /// 400
  badRequest,

  /// 401
  unAuthorized,

  /// 403
  accessForbidden,

  /// 500
  internalServerError,

  /// 503
  serviceUnavailable,

  /// 504
  gatewayTimeout,

  invalidToken,

  /// Unknown or not supported error.

  unknown,

  /// Not connected to the internet.
  notConnectedToInternet,

  /// Cannot reach the server.
  notReachedServer,

  /// Incorrect data returned from the server.
  incorrectDataReturned,

  //Host Authentication Challanged
  cancelled,

  //Missing Token
  missingToken,

  invalidConfig,

  loadFailed,

  serverError,
}

enum TXSInsuranceAction { initialize, load, bookPolicy }
enum TXSWebAction { initialize, load }

extension TXErrorExt on TXSErrorType {
  String get message {
    switch (this) {
      case TXSErrorType.incorrectDataReturned:
        return "Incorrect JSON format";

      case TXSErrorType.notConnectedToInternet:
        return "You are offline";

      case TXSErrorType.notReachedServer:
        return "Server not found";

      case TXSErrorType.cancelled:
        return "Request Cancelled";

      case TXSErrorType.serviceUnavailable:
        return "Service Unavailable";

      case TXSErrorType.emptyResponse:
        return "Empty Response";

      case TXSErrorType.gatewayTimeout:
        return "Gateway Timeout";

      case TXSErrorType.unAuthorized:
        return "Token Invalid";

      case TXSErrorType.badRequest:
        return "Incorrect Request";

      case TXSErrorType.internalServerError:
        return "Internal Server Error";

      case TXSErrorType.accessForbidden:
        return "Access Forbiddon";

      case TXSErrorType.invalidToken:
        return "Token Invalid";

      default:
        return "Unknown error";
    }
  }
}

class TXSInsuranceError {
  TXSInsuranceError._(this.errorType);
  final TXSErrorType errorType;

  factory TXSInsuranceError.missingToken() =>
      TXSInsuranceError._(TXSErrorType.missingToken);

  String get message {
    switch (errorType) {
      case TXSErrorType.missingToken:
        return "Access Token is missing";
      case TXSErrorType.invalidToken:
        return "Access Token is Invalid";
      case TXSErrorType.invalidConfig:
        return "Invalid Config";
      case TXSErrorType.loadFailed:
        return "Loading Failed";
      default:
        "Server Error";
    }
    return "";
  }
}

class TXSResponseHandler {
  static TXSResult handleException(Exception e) {
    if (e is SocketException) {
      return TXSResult.error(TXSErrorType.gatewayTimeout);
    } else if (e is TimeoutException) {
      return TXSResult.error(TXSErrorType.gatewayTimeout);
    } else if (e is FormatException) {
      return TXSResult.error(TXSErrorType.incorrectDataReturned);
    } else {
      return TXSResult.error(TXSErrorType.unknown);
    }
  }

  static http.Response returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw TXSErrorType.badRequest;
      case 401:
        throw TXSErrorType.unAuthorized;
      case 403:
        throw TXSErrorType.accessForbidden;
      case 500:
        throw TXSErrorType.internalServerError;
      case 501:
        throw TXSErrorType.serviceUnavailable;
      case 503:
        throw TXSErrorType.internalServerError;
      case 504:
        throw TXSErrorType.gatewayTimeout;
      default:
        throw TXSErrorType.unknown;
    }
  }
}
