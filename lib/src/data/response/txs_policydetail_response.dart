// To parse this JSON data, do
//
//     final txsPolicyDetail = txsPolicyDetailFromJson(jsonString);

import 'dart:convert';

// TxsPolicyDetail txsPolicyDetailFromJson(String? str) => TxsPolicyDetail.fromJson(json.decode(str));

// String? txsPolicyDetailToJson(TxsPolicyDetail data) => json.encode(data.toJson());

class TXSPolicyDetail {
  TXSPolicyDetail(
      {this.policyNumber,
      this.productName,
      this.productType,
      this.sourceSystem,
      this.productClass,
      this.effectiveDate,
      this.expirationDate,
      this.sponsorName,
      this.productId,
      this.status,
      this.policyStatus,
      this.productClassCode,
      this.cancellationDate,
      this.sponsor,
      this.premium,
      this.additionalProps,
      this.additionalInfo,
      this.policyHolder,
      this.insured,
      this.benefits,
      this.coverages,
      this.paymentDetails});

  String? policyNumber;
  String? productName;
  String? productType;
  String? sourceSystem;
  String? productClass;
  DateTime? effectiveDate;
  DateTime? expirationDate;
  String? sponsorName;
  String? productId;
  String? status;
  String? policyStatus;
  String? productClassCode;
  DateTime? cancellationDate;
  String? sponsor;
  double? premium;
  TXSAdditionalProps? additionalProps;
  List<TXSAdditionalInfo>? additionalInfo;
  TXSPolicyHolder? policyHolder;
  List<TXSInsured>? insured;
  List<TXSBenefit>? benefits;
  List<TXSCoverage>? coverages;
  TXSPaymentDetails? paymentDetails;

  bool isDocumentDownloaded = false;
  factory TXSPolicyDetail.fromRawJson(String str) =>
      TXSPolicyDetail.fromJson(json.decode(str));
  factory TXSPolicyDetail.fromJson(Map<String, dynamic> json) =>
      TXSPolicyDetail(
        policyNumber: json["policy_number"],
        productName: json["product_name"],
        productType: json["product_type"],
        sourceSystem: json["source_system"],
        productClass: json["product_class"],
        effectiveDate: json["effective_date"] == null
            ? null
            : DateTime.parse(json["effective_date"]),
        expirationDate: json["expiration_date"] == null
            ? null
            : DateTime.parse(json["expiration_date"]),
        sponsorName: json["sponsor_name"],
        productId: json["product_id"],
        status: json["status"],
        policyStatus: json["policy_status"],
        productClassCode: json["product_class_code"],
        cancellationDate: json["cancellation_date"] == null
            ? null
            : DateTime?.parse(json["cancellation_date"]),
        sponsor: json["sponsor"],
        premium: json["premium"] == null ? null : json["premium"]?.toDouble(),
        additionalProps: json["additional_props"] == null
            ? null
            : TXSAdditionalProps.fromJson(json["additional_props"]),
        additionalInfo: json["additional_info"] == null
            ? null
            : List<TXSAdditionalInfo>.from(json["additional_info"]
                .map((x) => TXSAdditionalInfo.fromJson(x))),
        policyHolder: json["policy_holder"] == null
            ? null
            : TXSPolicyHolder.fromJson(json["policy_holder"]),
        insured: json["insured"] == null
            ? null
            : List<TXSInsured>.from(
                json["insured"].map((x) => TXSInsured.fromJson(x))),
        benefits: json["benefits"] == null
            ? null
            : List<TXSBenefit>.from(
                json["benefits"].map((x) => TXSBenefit.fromJson(x))),
        coverages: json["coverages"] == null
            ? null
            : List<TXSCoverage>.from(
                json["coverages"].map((x) => TXSCoverage.fromJson(x))),
        paymentDetails: json["payment_details"] == null
            ? null
            : TXSPaymentDetails.fromJson(json["payment_details"]),
      );

  Map<String, dynamic> toJson() => {
        "policy_number": policyNumber,
        "product_name": productName,
        "product_type": productType,
        "source_system": sourceSystem,
        "product_class": productClass,
        "effective_date": effectiveDate?.toIso8601String(),
        "expiration_date": expirationDate?.toIso8601String(),
        "sponsor_name": sponsorName,
        "product_id": productId,
        "status": status,
        "policy_status": policyStatus,
        "product_class_code": productClassCode,
        "cancellation_date": cancellationDate == null
            ? null
            : "${cancellationDate?.year.toString().padLeft(4, '0')}-${cancellationDate?.month.toString().padLeft(2, '0')}-${cancellationDate?.day.toString().padLeft(2, '0')}",
        "sponsor": sponsor,
        "premium": premium,
        "additional_props": additionalProps?.toJson(),
        "additional_info": additionalInfo == null
            ? null
            : List<dynamic>.from(additionalInfo!.map((x) => x.toJson())),
        "policy_holder": policyHolder?.toJson(),
        "insured": insured == null
            ? null
            : List<dynamic>.from(insured!.map((x) => x.toJson())),
        "benefits": benefits == null
            ? null
            : List<dynamic>.from(benefits!.map((x) => x.toJson())),
        "coverages": coverages == null
            ? null
            : List<dynamic>.from(coverages!.map((x) => x.toJson())),
        "payment_details":
            paymentDetails == null ? null : paymentDetails!.toJson(),
      };
}

class TXSAdditionalInfo {
  TXSAdditionalInfo({
    this.categoryCode,
    this.description,
    this.key,
    this.productId,
    this.value,
  });

  String? categoryCode;
  String? description;
  String? key;
  String? productId;
  String? value;

  factory TXSAdditionalInfo.fromJson(Map<String, dynamic> json) =>
      TXSAdditionalInfo(
        categoryCode: json["category_code"],
        description: json["description"],
        key: json["key"],
        productId: json["product_id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "category_code": categoryCode,
        "description": description,
        "key": key,
        "product_id": productId,
        "value": value,
      };
}

class TXSAdditionalProps {
  TXSAdditionalProps({
    this.planType,
    this.planName,
    this.covertTypeName,
    this.tripStartDate,
    this.tripEndDate,
    this.documentUrl,
  });

  String? planType;
  String? planName;
  String? covertTypeName;
  DateTime? tripStartDate;
  DateTime? tripEndDate;
  String? documentUrl;

  factory TXSAdditionalProps.fromJson(Map<String, dynamic> json) =>
      TXSAdditionalProps(
        planType: json["plan_type"],
        planName: json["plan_name"],
        covertTypeName: json["covert_type_name"],
        tripStartDate: json["trip_start_date"] == null
            ? null
            : DateTime.parse(json["trip_start_date"]),
        tripEndDate: json["trip_end_date"] == null
            ? null
            : DateTime.parse(json["trip_end_date"]),
        documentUrl: json["document_url"],
      );

  Map<String, dynamic> toJson() => {
        "plan_type": planType,
        "plan_name": planName,
        "covert_type_name": covertTypeName,
        "trip_start_date": tripStartDate == null
            ? null
            : "${tripStartDate?.year.toString().padLeft(4, '0')}-${tripStartDate?.month.toString().padLeft(2, '0')}-${tripStartDate?.day.toString().padLeft(2, '0')}",
        "trip_end_date": tripEndDate == null
            ? null
            : "${tripEndDate?.year.toString().padLeft(4, '0')}-${tripEndDate?.month.toString().padLeft(2, '0')}-${tripEndDate?.day.toString().padLeft(2, '0')}",
        "document_url": documentUrl,
      };
}

class TXSBenefit {
  TXSBenefit({
    this.productId,
    this.code,
    this.description,
    this.amounts,
  });

  String? productId;
  String? code;
  String? description;
  TXSAmounts? amounts;

  factory TXSBenefit.fromJson(Map<String, dynamic> json) => TXSBenefit(
        productId: json["product_id"],
        code: json["code"],
        description: json["description"],
        amounts: json["amounts"] == null
            ? null
            : TXSAmounts.fromJson(json["amounts"]),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "code": code,
        "description": description,
        "amounts": amounts?.toJson(),
      };
}

class TXSAmounts {
  TXSAmounts({
    this.mainInsured,
    this.dependent,
    this.partner,
    this.total,
    this.adult,
    this.child,
  });

  dynamic mainInsured;
  dynamic dependent;
  dynamic partner;
  dynamic total;
  dynamic adult;
  dynamic child;

  factory TXSAmounts.fromJson(Map<String, dynamic> json) => TXSAmounts(
        mainInsured: json["main_insured"],
        dependent: json["dependent"],
        partner: json["partner"],
        total: json["total"],
        adult: json["adult"],
        child: json["child"],
      );

  Map<String, dynamic> toJson() => {
        "main_insured": mainInsured,
        "dependent": dependent,
        "partner": partner,
        "total": total,
        "adult": adult,
        "child": child,
      };
}

class TXSCoverage {
  TXSCoverage({
    this.name,
    this.code,
    this.amounts,
    this.geniusCoverCode,
    this.geniusCoverText,
    this.geniusSectionCode,
    this.geniusSectionText,
  });

  String? name;
  String? code;
  TXSAmounts? amounts;
  String? geniusCoverCode;
  String? geniusCoverText;
  String? geniusSectionCode;
  String? geniusSectionText;

  factory TXSCoverage.fromJson(Map<String, dynamic> json) => TXSCoverage(
        name: json["name"],
        code: json["code"],
        amounts: json["amounts"] == null
            ? null
            : TXSAmounts.fromJson(json["amounts"]),
        geniusCoverCode: json["genius_cover_code"],
        geniusCoverText: json["genius_cover_text"],
        geniusSectionCode: json["genius_section_code"],
        geniusSectionText: json["genius_section_text"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "amounts": amounts?.toJson(),
        "genius_cover_code": geniusCoverCode,
        "genius_cover_text": geniusCoverText,
        "genius_section_code": geniusSectionCode,
        "genius_section_text": geniusSectionText,
      };
}

class TXSInsured {
  TXSInsured({
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.emailAddresses,
    this.role,
  });

  String? id;
  String? firstName;
  String? lastName;
  DateTime? birthDate;
  List<String>? emailAddresses;
  String? role;

  factory TXSInsured.fromJson(Map<String, dynamic> json) => TXSInsured(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        emailAddresses: json["email_addresses"] == null
            ? null
            : List<String>.from(json["email_addresses"].map((x) => x)),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "birth_date": birthDate == null
            ? null
            : "${birthDate?.year.toString().padLeft(4, '0')}-${birthDate?.month.toString().padLeft(2, '0')}-${birthDate?.day.toString().padLeft(2, '0')}",
        "email_addresses": emailAddresses == null
            ? null
            : List<dynamic>.from(emailAddresses!.map((x) => x)),
        "role": role,
      };
}

class TXSPolicyHolder {
  TXSPolicyHolder({
    this.id,
    this.firstName,
    this.lastName,
    this.brithDate,
    this.emailAddresses,
    this.addresses,
    this.phoneNumbers,
  });

  String? id;
  String? firstName;
  String? lastName;
  DateTime? brithDate;
  List<String>? emailAddresses;
  List<TXSAddress>? addresses;
  List<TXSPhoneNumber>? phoneNumbers;

  factory TXSPolicyHolder.fromJson(Map<String, dynamic> json) =>
      TXSPolicyHolder(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        brithDate: json["brith_date"] == null
            ? null
            : DateTime.parse(json["brith_date"]),
        emailAddresses: json["email_addresses"] == null
            ? null
            : List<String>.from(json["email_addresses"].map((x) => x)),
        addresses: json["addresses"] == null
            ? null
            : List<TXSAddress>.from(
                json["addresses"].map((x) => TXSAddress.fromJson(x))),
        phoneNumbers: json["phone_numbers"] == null
            ? null
            : List<TXSPhoneNumber>.from(
                json["phone_numbers"].map((x) => TXSPhoneNumber.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "brith_date": brithDate == null
            ? null
            : "${brithDate?.year.toString().padLeft(4, '0')}-${brithDate?.month.toString().padLeft(2, '0')}-${brithDate?.day.toString().padLeft(2, '0')}",
        "email_addresses": emailAddresses == null
            ? null
            : List<dynamic>.from(emailAddresses!.map((x) => x)),
        "addresses": addresses == null
            ? null
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "phone_numbers": phoneNumbers == null
            ? null
            : List<dynamic>.from(phoneNumbers!.map((x) => x.toJson())),
      };
}

class TXSAddress {
  TXSAddress({
    this.id,
    this.type,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.addressLine4,
    this.city,
    this.country,
    this.postalCode,
  });

  String? id;
  String? type;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? addressLine4;
  String? city;
  String? country;
  String? postalCode;

  factory TXSAddress.fromJson(Map<String, dynamic> json) => TXSAddress(
        id: json["id"],
        type: json["type"],
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        addressLine3: json["address_line3"],
        addressLine4: json["address_line4"],
        city: json["city"],
        country: json["country"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "address_line3": addressLine3,
        "address_line4": addressLine4,
        "city": city,
        "country": country,
        "postal_code": postalCode,
      };
}

class TXSPhoneNumber {
  TXSPhoneNumber({
    this.type,
    this.number,
  });

  String? type;
  String? number;

  factory TXSPhoneNumber.fromJson(Map<String, dynamic> json) => TXSPhoneNumber(
        type: json["type"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "number": number,
      };
}

// To parse this JSON data, do
//
//     final txsPaymentDetails = txsPaymentDetailsFromJson(jsonString);

class TXSPaymentDetails {
  TXSPaymentDetails({
    this.name,
    this.paidThroughDate,
    this.dueDate,
    this.currency,
    this.frequency,
    this.card,
  });

  String? name;
  DateTime? paidThroughDate;
  DateTime? dueDate;
  String? currency;
  String? frequency;
  TXSCard? card;

  factory TXSPaymentDetails.fromJson(Map<String, dynamic> json) =>
      TXSPaymentDetails(
        name: json["name"],
        paidThroughDate: json["paid_through_date"] == null
            ? null
            : DateTime.parse(json["paid_through_date"]),
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        currency: json["currency"],
        frequency: json["frequency"],
        card: json["card"] == null ? null : TXSCard.fromJson(json["card"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "paid_through_date": paidThroughDate == null
            ? null
            : "${paidThroughDate?.year.toString().padLeft(4, '0')}-${paidThroughDate?.month.toString().padLeft(2, '0')}-${paidThroughDate?.day.toString().padLeft(2, '0')}",
        "due_date": dueDate == null
            ? null
            : "${dueDate?.year.toString().padLeft(4, '0')}-${dueDate?.month.toString().padLeft(2, '0')}-${dueDate?.day.toString().padLeft(2, '0')}",
        "currency": currency,
        "frequency": frequency,
        "card": card == null ? null : card!.toJson(),
      };
}

class TXSCard {
  TXSCard({
    this.number,
    this.expirationDate,
    this.typeCode,
    this.type,
  });

  String? number;
  String? expirationDate;
  String? typeCode;
  String? type;

  factory TXSCard.fromJson(Map<String, dynamic> json) => TXSCard(
        number: json["number"],
        expirationDate: json["expiration_date"],
        typeCode: json["type_code"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "expiration_date": expirationDate,
        "type_code": typeCode,
        "type": type,
      };
}
