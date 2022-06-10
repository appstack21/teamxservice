import 'dart:convert';

class TXSPartnerResponse {
  TXSPartnerResponse({
    this.partner,
  });

  TXSPartner? partner;

  factory TXSPartnerResponse.fromRawJson(String str) =>
      TXSPartnerResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSPartnerResponse.fromJson(Map<String, dynamic> json) =>
      TXSPartnerResponse(
        partner: json["partner"] == null
            ? null
            : TXSPartner.fromJson(json["partner"]),
      );

  Map<String, dynamic> toJson() => {
        "partner": partner?.toJson(),
      };
}

class TXSPartner {
  TXSPartner({
    this.code,
    this.name,
    this.agreementText,
    this.cardLinkText,
    this.agreeButtonText,
    this.cancelButtonText,
    this.products,
    this.pricingModel,
    this.premiums,
    this.showWebView,
    this.showAgreementModel,
  });

  String? code;
  String? name;
  String? agreementText;
  String? cardLinkText;
  String? agreeButtonText;
  String? cancelButtonText;
  List<TXSProduct>? products;
  List<String>? pricingModel;

  List<TXSPricingModel>? get pricingModelEnum {
    List<TXSPricingModel> models = [];
    pricingModel?.forEach((element) {
      if (element == TXSPricingModel.fixed.name) {
        models.add(TXSPricingModel.fixed);
      } else if (element == TXSPricingModel.variable.name) {
        models.add(TXSPricingModel.variable);
      }
    });
    return models;
  }

  List<double>? premiums;
  bool? showWebView;
  bool? showAgreementModel;

  factory TXSPartner.fromRawJson(String str) =>
      TXSPartner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSPartner.fromJson(Map<String, dynamic> json) => TXSPartner(
        code: json["code"],
        name: json["name"],
        agreementText: json["agreementText"],
        cardLinkText: json["cardLinkText"],
        agreeButtonText: json["agreeButtonText"],
        cancelButtonText: json["cancelButtonText"],
        products: json["products"] == null
            ? null
            : List<TXSProduct>.from(
                json["products"].map((x) => TXSProduct.fromJson(x))),
        pricingModel: json["pricingModel"] == null
            ? null
            : List<String>.from(json["pricingModel"].map((x) => x)),
        premiums: json["premiums"] == null
            ? null
            : List<double>.from(json["premiums"].map((x) => x)),
        showWebView: json["showWebView"],
        showAgreementModel: json["showAgreementModel"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "agreementText": agreementText,
        "cardLinkText": cardLinkText,
        "agreeButtonText": agreeButtonText,
        "cancelButtonText": cancelButtonText,
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "pricingModel": pricingModel == null
            ? null
            : List<dynamic>.from(pricingModel!.map((x) => x)),
        "premiums": premiums == null
            ? null
            : List<dynamic>.from(premiums!.map((x) => x)),
        "showWebView": showWebView,
        "showAgreementModel": showAgreementModel,
      };

  TXSPricingModel getPricingModel(double amount) {
    switch (code) {
      case "YUU001":
        return TXSPricingModel.fixed;
      default:
        if (amount > 500.00) {
          return TXSPricingModel.variable;
        }
        return TXSPricingModel.fixed;
    }
  }

  double getFixPremium(double amount) {
    if (premiums?.isEmpty == true) {
      return 2.0;
    }
    var premium = 5.0;

    switch (code) {
      case "YUU001":
        if (amount > 0 && amount <= 500) {
          if (premiums?.isEmpty == false) {
            return premiums?.first ?? 0.0;
          }
        } else if (amount > 500.01 && amount <= 2000) {
          if ((premiums?.length ?? 0) > 1) {
            return premiums?[1] ?? 0.0;
          }
        } else if (amount > 2000.01 && amount <= 5000) {
          if ((premiums?.length ?? 0) > 2) {
            return premiums?[2] ?? 0.0;
          }
        } else if (amount > 5000.01 && amount <= 10000) {
          if ((premiums?.length ?? 0) > 3) {
            return premiums?[3] ?? 0.0;
          }
        } else {
          return 2.0;
        }
        break;
      default:
        premium = 5.0;
    }
    return premium;
  }

  double getVariablePremimum(double amount) {
    double percentage = 0.01;
    switch (code) {
      default:
        percentage = 1.0 / 100;
    }
    double permium = amount * percentage;
    return permium;
  }

  TXSProduct? getProductDetailFromProductCode(TXSProductCode code) {
    var filterProducts = products?.where((element) {
      return element.code == code.productName;
    }).toList();
    if (filterProducts?.isNotEmpty ?? false) {
      return filterProducts?.first;
    }
  }
}

class TXSProduct {
  TXSProduct({
    this.code,
    this.name,
    this.productDescription,
    this.insuranceInfo,
  });

  String? code;
  String? name;
  String? productDescription;
  String? insuranceInfo;

  TXSProductCode? get productCodeEnum {
    if (code == TXSProductCode.purchaseProtect.name) {
      return TXSProductCode.purchaseProtect;
    } else if (code == TXSProductCode.billProtect.name) {
      return TXSProductCode.billProtect;
    } else if (code == TXSProductCode.bnplProtect.name) {
      return TXSProductCode.bnplProtect;
    } else {
      return TXSProductCode.eventCancelation;
    }
  }

  factory TXSProduct.fromRawJson(String str) =>
      TXSProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSProduct.fromJson(Map<String, dynamic> json) => TXSProduct(
        code: json["code"],
        name: json["name"],
        productDescription: json["productDescription"],
        insuranceInfo: json["insuranceInfo"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "productDescription": productDescription,
        "insuranceInfo": insuranceInfo,
      };
}

enum TXSProductCode {
  purchaseProtect,
  billProtect,
  bnplProtect,
  eventCancelation
}

extension TXProductCodeExt on TXSProductCode {
  String get productName {
    switch (this) {
      case TXSProductCode.billProtect:
        return "BILLPROTECT";

      case TXSProductCode.bnplProtect:
        return "BNPLPROTECT";

      case TXSProductCode.eventCancelation:
        return "EVENTCANCELLATIONPROTECT";

      case TXSProductCode.purchaseProtect:
        return "PURCHASEPROTECT";
    }
  }
}

enum TXSPricingModel { fixed, variable }

extension TXPricingModelExt on TXSPricingModel {
  String get name {
    switch (this) {
      case TXSPricingModel.fixed:
        return "FIXED";
      case TXSPricingModel.variable:
        return "VARIABLE";
    }
  }
}
