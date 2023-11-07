// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      company: json['company'] as String?,
      phone: json['phone'] as String?,
      notes: json['notes'] as String?,
      taxExemptCategory: json['tax_exempt_category'] as String?,
      customerGroupId: json['customer_group_id'] as int?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => CustomerAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      authentication: json['authentication'] == null
          ? null
          : Authentication.fromJson(
              json['authentication'] as Map<String, dynamic>),
      acceptsProductReviewAbandonedCartEmails:
          json['accepts_product_review_abandoned_cart_emails'] as bool?,
      storeCreditAmounts: (json['store_credit_amounts'] as List<dynamic>?)
          ?.map((e) => StoreCreditAmount.fromJson(e as Map<String, dynamic>))
          .toList(),
      channelIds: (json['channel_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      formFields: (json['form_fields'] as List<dynamic>?)
          ?.map((e) => FormField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) {
  final val = <String, dynamic>{
    'email': instance.email,
    'first_name': instance.firstName,
    'last_name': instance.lastName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('company', instance.company);
  writeNotNull('phone', instance.phone);
  writeNotNull('notes', instance.notes);
  writeNotNull('tax_exempt_category', instance.taxExemptCategory);
  writeNotNull('customer_group_id', instance.customerGroupId);
  writeNotNull('addresses', instance.addresses);
  writeNotNull('attributes', instance.attributes);
  writeNotNull('authentication', instance.authentication);
  writeNotNull('accepts_product_review_abandoned_cart_emails',
      instance.acceptsProductReviewAbandonedCartEmails);
  writeNotNull('store_credit_amounts', instance.storeCreditAmounts);
  writeNotNull('channel_ids', instance.channelIds);
  writeNotNull('form_fields', instance.formFields);
  return val;
}

CustomerAddress _$CustomerAddressFromJson(Map<String, dynamic> json) =>
    CustomerAddress(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      company: json['company'] as String?,
      address1: json['address1'] as String,
      address2: json['address2'] as String?,
      city: json['city'] as String,
      stateOrProvince: json['state_or_province'] as String?,
      postalCode: json['postal_code'] as String?,
      countryCode: json['country_code'] as String,
      phone: json['phone'] as String?,
      addressType:
          $enumDecodeNullable(_$AddressTypeEnumMap, json['address_type']),
      formFields: (json['form_fields'] as List<dynamic>?)
          ?.map((e) => FormField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerAddressToJson(CustomerAddress instance) {
  final val = <String, dynamic>{
    'first_name': instance.firstName,
    'last_name': instance.lastName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('company', instance.company);
  val['address1'] = instance.address1;
  writeNotNull('address2', instance.address2);
  val['city'] = instance.city;
  writeNotNull('state_or_province', instance.stateOrProvince);
  writeNotNull('postal_code', instance.postalCode);
  val['country_code'] = instance.countryCode;
  writeNotNull('phone', instance.phone);
  writeNotNull('address_type', _$AddressTypeEnumMap[instance.addressType]);
  writeNotNull('form_fields', instance.formFields);
  return val;
}

const _$AddressTypeEnumMap = {
  AddressType.residential: 'residential',
  AddressType.commercial: 'commercial',
};

FormField _$FormFieldFromJson(Map<String, dynamic> json) => FormField(
      name: json['name'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$FormFieldToJson(FormField instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

Attribute _$AttributeFromJson(Map<String, dynamic> json) => Attribute(
      attributeId: json['attribute_id'] as int,
      attributeValue: json['attribute_value'] as String,
    );

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
      'attribute_id': instance.attributeId,
      'attribute_value': instance.attributeValue,
    };

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) =>
    Authentication(
      forcePasswordReset: json['force_password_reset'] as bool?,
      newPassword: json['new_password'] as String?,
    );

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) =>
    <String, dynamic>{
      'force_password_reset': instance.forcePasswordReset,
      'new_password': instance.newPassword,
    };

StoreCreditAmount _$StoreCreditAmountFromJson(Map<String, dynamic> json) =>
    StoreCreditAmount(
      amount: json['amount'] as num?,
    );

Map<String, dynamic> _$StoreCreditAmountToJson(StoreCreditAmount instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('amount', instance.amount);
  return val;
}
