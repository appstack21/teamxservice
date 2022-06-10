// To parse this JSON data, do
//
//     final txPolicyBookRequest = txPolicyBookRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';

extension DoubleExt on double {
  double roundTo(int places) {
    var divisor = pow(10.0, places);
    return (this * divisor).round() / divisor;
  }
}

class TXSPolicyBookRequest {
  TXSPolicyBookRequest({
    this.requestDate,
    this.channel,
    this.effectiveDate,
    this.contractHolders,
    this.insureds,
    this.insuranceSelections,
  });

  String? requestDate;
  String? channel;
  String? effectiveDate;
  List<TXSContractHolder>? contractHolders;
  List<TXSInsured>? insureds;
  TXSInsuranceSelections? insuranceSelections;

  factory TXSPolicyBookRequest.fromRawJson(String str) =>
      TXSPolicyBookRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSPolicyBookRequest.fromJson(Map<String, dynamic> json) =>
      TXSPolicyBookRequest(
        requestDate: json["request_date"],
        channel: json["channel"],
        effectiveDate: json["effective_date"],
        contractHolders: json["contract_holders"] == null
            ? null
            : List<TXSContractHolder>.from(json["contract_holders"]
                .map((x) => TXSContractHolder.fromJson(x))),
        insureds: json["insureds"] == null
            ? null
            : List<TXSInsured>.from(
                json["insureds"].map((x) => TXSInsured.fromJson(x))),
        insuranceSelections: json["insurance_selections"] == null
            ? null
            : TXSInsuranceSelections.fromJson(json["insurance_selections"]),
      );

  Map<String, dynamic> toJson() => {
        "request_date": requestDate,
        "channel": channel,
        "effective_date": effectiveDate,
        "contract_holders": contractHolders == null
            ? null
            : List<dynamic>.from(contractHolders!.map((x) => x.toJson())),
        "insureds": insureds == null
            ? null
            : List<dynamic>.from(insureds!.map((x) => x.toJson())),
        "insurance_selections":
            insuranceSelections == null ? null : insuranceSelections!.toJson(),
      };

  static TXSPolicyBookRequest createRequest() {
    var request = TXSPolicyBookRequest();

    DateTime now = DateTime.now();
    String date = DateFormat('yyyy/MM/dd').format(now);

    request.requestDate = date;
    request.channel = "internet";
    request.effectiveDate = date;

    List<TXSContractHolder> contractHolders = [];
    TXSContractHolder holder = TXSContractHolder();

    holder.firstName = "John Cena";
    holder.nationality = "Singapore";
    holder.relationship = "self";
    holder.dateOfBirth = "2003/5/1";

    var rng = Random();
    var randomAccount = rng.nextInt(99999999);

    holder.identification = TXSIdentification(
        typeOfId: "Singapore NRIC", idValue: randomAccount.toString());
    //Address
    holder.homeAddress = TXSHomeAddress(
        addressLines: [""], city: "", state: "", postalCode: "", country: "sg");
    holder.mailingAddress = false;
    //TXSPhone
    holder.phone = [TXSPhone(phoneNumber: "+65 88888888", type: "personal")];
    holder.email = "nagaraju.kunchala@chubb.com";
    contractHolders.add(holder);

    request.contractHolders = contractHolders;

    List<TXSInsured> insureds = [];
    TXSInsured insured = TXSInsured();

    insured.insured = holder;
    insured.beneficiaries = [];
    insureds.add(insured);
    request.insureds = insureds;

    var insuranceSelection = TXSInsuranceSelections();
    var checkout = now.add(const Duration(days: 4));
    var checkin = now.subtract(const Duration(days: 3));
    var daysCalculator = TXSDaysCalculator(
        checkInDate: DateFormat('yyyy/MM/dd').format(checkin),
        checkOutDate: DateFormat('yyyy/MM/dd').format(checkout),
        duration: 8);

    insuranceSelection.campaignId = "pweb-sp";
    insuranceSelection.additionalData = TXSAdditionalData(
        deviceDetails: TXSChannelPreferences(),
        channelPreferences: TXSChannelPreferences(),
        localeId: "en-SG",
        familyType: "myself",
        daysCalculator: daysCalculator);

    insuranceSelection.paymentType = "credit card";

    insuranceSelection.paymentDetails = TXSPaymentDetails(
        cardType: "masterCard",
        cardholderName: "Christopher",
        paymentToken: "542288LZ83AP0007",
        expMonth: "07",
        expYear: "30",
        cvv: "123",
        paymentFrequency: 8);

    insuranceSelection.offerId = "1";
    insuranceSelection.offer = TXSOffer(
        offerId: "1",
        name: "Classic",
        paymentFrequency: 8,
        additionalData: TXSAdditionalDataClass(standardPrice: 16.56),
        premium: 13.93,
        tax: 0.97.roundTo(2),
        total: 14.9);

    List<TXSPricingQuestion> pricingQuestions = [];

    var pricingQuestionOne = TXSPricingQuestion(
        question: TXSQuestion(
            questionId: "familyType",
            label: "Your Family",
            value: TXSValue(code: "Your Family", description: "")));
    var pricingQuestionTwo = TXSPricingQuestion(
        question: TXSQuestion(
            questionId: "days-calculator",
            label: "Your Family",
            value: TXSValue(code: daysCalculator, description: "")));

    var pricingQuestionThree = TXSPricingQuestion(
        question: TXSQuestion(
            questionId: "promo_code",
            label: "Your Family",
            value: TXSValue(description: "")));

    pricingQuestions.add(pricingQuestionOne);
    pricingQuestions.add(pricingQuestionTwo);
    pricingQuestions.add(pricingQuestionThree);

    insuranceSelection.pricingQuestions = pricingQuestions;
    request.insuranceSelections = insuranceSelection;

    // printLongString(jsonEncode(request));
    return request;
  }

  static void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => print(match.group(0)));
  }
}

class TXSContractHolder {
  TXSContractHolder({
    this.firstName,
    this.nationality,
    this.relationship,
    this.dateOfBirth,
    this.identification,
    this.homeAddress,
    this.mailingAddress,
    this.phone,
    this.email,
  });

  String? firstName;
  String? nationality;
  String? relationship;
  String? dateOfBirth;
  TXSIdentification? identification;
  TXSHomeAddress? homeAddress;
  bool? mailingAddress;
  List<TXSPhone>? phone;
  String? email;

  factory TXSContractHolder.fromRawJson(String str) =>
      TXSContractHolder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSContractHolder.fromJson(Map<String, dynamic> json) =>
      TXSContractHolder(
        firstName: json["first_name"],
        nationality: json["nationality"],
        relationship: json["relationship"],
        dateOfBirth: json["date_of_birth"],
        identification: json["identification"] == null
            ? null
            : TXSIdentification.fromJson(json["identification"]),
        homeAddress: json["home_address"] == null
            ? null
            : TXSHomeAddress.fromJson(json["home_address"]),
        mailingAddress: json["mailing_address"],
        phone: json["phone"] == null
            ? null
            : List<TXSPhone>.from(
                json["phone"].map((x) => TXSPhone.fromJson(x))),
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "nationality": nationality,
        "relationship": relationship,
        "date_of_birth": dateOfBirth,
        "identification":
            identification == null ? null : identification!.toJson(),
        "home_address": homeAddress == null ? null : homeAddress!.toJson(),
        "mailing_address": mailingAddress,
        "phone": phone == null
            ? null
            : List<dynamic>.from(phone!.map((x) => x.toJson())),
        "email": email,
      };
}

class TXSHomeAddress {
  TXSHomeAddress({
    this.addressLines,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  List<String>? addressLines;
  String? city;
  String? state;
  String? postalCode;
  String? country;

  factory TXSHomeAddress.fromRawJson(String str) =>
      TXSHomeAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSHomeAddress.fromJson(Map<String, dynamic> json) => TXSHomeAddress(
        addressLines: json["address_lines"] == null
            ? null
            : List<String>.from(json["address_lines"].map((x) => x)),
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "address_lines": addressLines == null
            ? null
            : List<dynamic>.from(addressLines!.map((x) => x)),
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "country": country,
      };
}

class TXSIdentification {
  TXSIdentification({
    this.typeOfId,
    this.idValue,
  });

  String? typeOfId;
  String? idValue;

  factory TXSIdentification.fromRawJson(String str) =>
      TXSIdentification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSIdentification.fromJson(Map<String, dynamic> json) =>
      TXSIdentification(
        typeOfId: json["type_of_id"],
        idValue: json["id_value"],
      );

  Map<String, dynamic> toJson() => {
        "type_of_id": typeOfId,
        "id_value": idValue,
      };
}

class TXSPhone {
  TXSPhone({
    this.phoneNumber,
    this.type,
  });

  String? phoneNumber;
  String? type;

  factory TXSPhone.fromRawJson(String str) =>
      TXSPhone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSPhone.fromJson(Map<String, dynamic> json) => TXSPhone(
        phoneNumber: json["phone_number"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "type": type,
      };
}

class TXSInsuranceSelections {
  TXSInsuranceSelections({
    this.campaignId,
    this.additionalData,
    this.paymentType,
    this.paymentDetails,
    this.offerId,
    this.offer,
    this.pricingQuestions,
  });

  String? campaignId;
  TXSAdditionalData? additionalData;
  String? paymentType;
  TXSPaymentDetails? paymentDetails;
  String? offerId;
  TXSOffer? offer;
  List<TXSPricingQuestion>? pricingQuestions;

  factory TXSInsuranceSelections.fromRawJson(String str) =>
      TXSInsuranceSelections.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSInsuranceSelections.fromJson(Map<String, dynamic> json) =>
      TXSInsuranceSelections(
        campaignId: json["campaign_id"],
        additionalData: json["additional_data"] == null
            ? null
            : TXSAdditionalData.fromJson(json["additional_data"]),
        paymentType: json["payment_type"],
        paymentDetails: json["payment_details"] == null
            ? null
            : TXSPaymentDetails.fromJson(json["payment_details"]),
        offerId: json["offer_id"],
        offer: json["offer"] == null ? null : TXSOffer.fromJson(json["offer"]),
        pricingQuestions: json["pricing_questions"] == null
            ? null
            : List<TXSPricingQuestion>.from(json["pricing_questions"]
                .map((x) => TXSPricingQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "campaign_id": campaignId,
        "additional_data":
            additionalData == null ? null : additionalData!.toJson(),
        "payment_type": paymentType,
        "payment_details":
            paymentDetails == null ? null : paymentDetails!.toJson(),
        "offer_id": offerId ?? "1",
        "offer": offer == null ? null : offer!.toJson(),
        "pricing_questions": pricingQuestions == null
            ? null
            : List<dynamic>.from(pricingQuestions!.map((x) => x.toJson())),
      };
}

class TXSAdditionalData {
  TXSAdditionalData({
    this.deviceDetails,
    this.channelPreferences,
    this.localeId,
    this.familyType,
    this.daysCalculator,
  });

  TXSChannelPreferences? deviceDetails;
  TXSChannelPreferences? channelPreferences;
  String? localeId;
  String? familyType;
  TXSDaysCalculator? daysCalculator;

  factory TXSAdditionalData.fromRawJson(String str) =>
      TXSAdditionalData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSAdditionalData.fromJson(Map<String, dynamic> json) =>
      TXSAdditionalData(
        deviceDetails: json["device_details"] == null
            ? null
            : TXSChannelPreferences.fromJson(json["device_details"]),
        channelPreferences: json["channel_preferences"] == null
            ? null
            : TXSChannelPreferences.fromJson(json["channel_preferences"]),
        localeId: json["locale_id"],
        familyType: json["familyType"],
        daysCalculator: json["days-calculator"] == null
            ? null
            : TXSDaysCalculator.fromJson(json["days-calculator"]),
      );

  Map<String, dynamic> toJson() => {
        "device_details":
            deviceDetails == null ? null : deviceDetails?.toJson(),
        "channel_preferences":
            channelPreferences == null ? null : channelPreferences!.toJson(),
        "locale_id": localeId,
        "familyType": familyType,
        "days-calculator":
            daysCalculator == null ? null : daysCalculator!.toJson(),
      };
}

class TXSChannelPreferences {
  TXSChannelPreferences();

  factory TXSChannelPreferences.fromRawJson(String str) =>
      TXSChannelPreferences.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSChannelPreferences.fromJson(Map<String, dynamic> json) =>
      TXSChannelPreferences();

  Map<String, dynamic> toJson() => {};
}

class TXSDaysCalculator {
  TXSDaysCalculator({
    this.checkInDate,
    this.checkOutDate,
    this.duration,
  });

  String? checkInDate;
  String? checkOutDate;
  int? duration;

  factory TXSDaysCalculator.fromRawJson(String str) =>
      TXSDaysCalculator.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSDaysCalculator.fromJson(Map<String, dynamic> json) =>
      TXSDaysCalculator(
        checkInDate: json["checkInDate"],
        checkOutDate: json["checkOutDate"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "checkInDate": checkInDate,
        "checkOutDate": checkOutDate,
        "duration": duration,
      };
}

class TXSOffer {
  TXSOffer({
    this.offerId,
    this.name,
    this.paymentFrequency,
    this.additionalData,
    this.premium,
    this.tax,
    this.total,
  });

  String? offerId;
  String? name;
  int? paymentFrequency;
  TXSAdditionalDataClass? additionalData;
  double? premium;
  double? tax;
  double? total;

  factory TXSOffer.fromRawJson(String str) =>
      TXSOffer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSOffer.fromJson(Map<String, dynamic> json) => TXSOffer(
        offerId: json["offerId"],
        name: json["name"],
        paymentFrequency: json["paymentFrequency"],
        additionalData: json["additionalData"] == null
            ? null
            : TXSAdditionalDataClass.fromJson(json["additionalData"]),
        premium: json["premium"] == null ? null : json["premium"]!.toDouble(),
        tax: json["tax"] == null ? null : json["tax"]!.toDouble(),
        total: json["total"] == null ? null : json["total"]!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "offerId": offerId,
        "name": name,
        "paymentFrequency": paymentFrequency,
        "additionalData":
            additionalData == null ? null : additionalData!.toJson(),
        "premium": premium,
        "tax": tax,
        "total": total,
      };
}

class TXSAdditionalDataClass {
  TXSAdditionalDataClass({
    this.standardPrice,
  });

  double? standardPrice;

  factory TXSAdditionalDataClass.fromRawJson(String str) =>
      TXSAdditionalDataClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSAdditionalDataClass.fromJson(Map<String, dynamic> json) =>
      TXSAdditionalDataClass(
        standardPrice: json["standardPrice"] == null
            ? null
            : json["standardPrice"]!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "standardPrice": standardPrice,
      };
}

class TXSPaymentDetails {
  TXSPaymentDetails({
    this.cardType,
    this.cardholderName,
    this.paymentToken,
    this.expMonth,
    this.expYear,
    this.cvv,
    this.paymentFrequency,
  });

  String? cardType;
  String? cardholderName;
  String? paymentToken;
  String? expMonth;
  String? expYear;
  String? cvv;
  int? paymentFrequency;

  factory TXSPaymentDetails.fromRawJson(String str) =>
      TXSPaymentDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSPaymentDetails.fromJson(Map<String, dynamic> json) =>
      TXSPaymentDetails(
        cardType: json["card_type"],
        cardholderName: json["cardholder_name"],
        paymentToken: json["payment_token"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        cvv: json["cvv"],
        paymentFrequency: json["payment_frequency"],
      );

  Map<String, dynamic> toJson() => {
        "card_type": cardType,
        "cardholder_name": cardholderName,
        "payment_token": paymentToken,
        "exp_month": expMonth,
        "exp_year": expYear,
        "cvv": cvv,
        "payment_frequency": paymentFrequency,
      };
}

class TXSPricingQuestion {
  TXSPricingQuestion({
    this.question,
  });

  TXSQuestion? question;

  factory TXSPricingQuestion.fromRawJson(String str) =>
      TXSPricingQuestion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSPricingQuestion.fromJson(Map<String, dynamic> json) =>
      TXSPricingQuestion(
        question: json["question"] == null
            ? null
            : TXSQuestion.fromJson(json["question"]),
      );

  Map<String, dynamic> toJson() => {
        "question": question == null ? null : question!.toJson(),
      };
}

class TXSQuestion {
  TXSQuestion({
    this.questionId,
    this.label,
    this.value,
  });

  String? questionId;
  String? label;
  TXSValue? value;

  factory TXSQuestion.fromRawJson(String str) =>
      TXSQuestion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSQuestion.fromJson(Map<String, dynamic> json) => TXSQuestion(
        questionId: json["question_id"],
        label: json["label"],
        value: json["value"] == null ? null : TXSValue.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "label": label,
        "value": value == null ? null : value!.toJson(),
      };
}

class TXSValue {
  TXSValue({
    this.code,
    this.description,
  });

  dynamic code;
  String? description;

  factory TXSValue.fromRawJson(String str) =>
      TXSValue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSValue.fromJson(Map<String, dynamic> json) => TXSValue(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    if (code != null) {
      json["code"] = code;
      json["description"] = description;
    } else {
      json["description"] = description;
    }

    return json;
  }
}

class TXSInsured {
  TXSInsured({
    this.insured,
    this.beneficiaries,
  });

  TXSContractHolder? insured;
  List<dynamic>? beneficiaries;

  factory TXSInsured.fromRawJson(String str) =>
      TXSInsured.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TXSInsured.fromJson(Map<String, dynamic> json) => TXSInsured(
        insured: json["insured"] == null
            ? null
            : TXSContractHolder.fromJson(json["insured"]),
        beneficiaries: json["beneficiaries"] == null
            ? null
            : List<dynamic>.from(json["beneficiaries"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "insured": insured == null ? null : insured!.toJson(),
        "beneficiaries": beneficiaries == null
            ? null
            : List<dynamic>.from(beneficiaries!.map((x) => x)),
      };
}
