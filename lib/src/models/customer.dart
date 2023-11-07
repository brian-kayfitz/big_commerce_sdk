import 'dart:convert';

import 'package:big_commerce_sdk/big_commerce_sdk.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class Customer {
  final String email;
  final String firstName;
  final String lastName;
  final String? company;
  final String? phone;
  final String? notes;
  final String? taxExemptCategory;
  final int? customerGroupId;
  final List<CustomerAddress>? addresses;
  final List<Attribute>? attributes;
  final Authentication? authentication;
  final bool? acceptsProductReviewAbandonedCartEmails;
  final List<StoreCreditAmount>? storeCreditAmounts;
  final List<int>? channelIds;
  final List<FormField>? formFields;

  const Customer({
    required this.email,
    required this.firstName,
    required this.lastName,
    this.company,
    this.phone,
    this.notes,
    this.taxExemptCategory,
    this.customerGroupId,
    this.addresses,
    this.attributes,
    this.authentication,
    this.acceptsProductReviewAbandonedCartEmails,
    this.storeCreditAmounts,
    this.channelIds,
    this.formFields,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  Future<void> create(BigCommerceClient client) async {
    final json = toJson();
    await client.send(
      method: HTTPMethod.post,
      path: 'customers',
      body: [json],
    );
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class CustomerAddress {
  final String firstName;
  final String lastName;
  final String? company;
  final String address1;
  final String? address2;
  final String city;
  final String? stateOrProvince;
  final String? postalCode;
  final String countryCode;
  final String? phone;
  final AddressType? addressType;
  final List<FormField>? formFields;

  const CustomerAddress({
    required this.firstName,
    required this.lastName,
    this.company,
    required this.address1,
    this.address2,
    required this.city,
    this.stateOrProvince,
    required this.postalCode,
    required this.countryCode,
    this.phone,
    this.addressType,
    this.formFields,
  });

  factory CustomerAddress.fromJson(Map<String, dynamic> json) =>
      _$CustomerAddressFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerAddressToJson(this);
}

enum AddressType {
  @JsonValue('residential')
  residential,
  @JsonValue('commercial')
  commercial
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class FormField {
  final String name;
  final String value;

  const FormField({
    required this.name,
    required this.value,
  });

  factory FormField.fromJson(Map<String, dynamic> json) =>
      _$FormFieldFromJson(json);
  Map<String, dynamic> toJson() => _$FormFieldToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Attribute {
  final int attributeId;
  final String attributeValue;

  const Attribute({
    required this.attributeId,
    required this.attributeValue,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);
  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Authentication {
  final bool? forcePasswordReset;
  final String? newPassword;

  const Authentication({
    this.forcePasswordReset,
    this.newPassword,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class StoreCreditAmount {
  final num? amount;

  const StoreCreditAmount({
    this.amount,
  });

  factory StoreCreditAmount.fromJson(Map<String, dynamic> json) =>
      _$StoreCreditAmountFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCreditAmountToJson(this);
}
