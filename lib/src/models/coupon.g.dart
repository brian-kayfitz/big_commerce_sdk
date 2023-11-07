// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      name: json['name'] as String,
      type: $enumDecode(_$CouponTypeEnumMap, json['type']),
      amount: json['amount'] as String,
      minPurchase: json['min_purchase'] as String?,
      expires: json['expires'] as String?,
      enabled: json['enabled'] as bool?,
      code: json['code'] as String,
      appliesTo: json['applies_to'],
      maxUses: json['max_uses'] as int?,
      maxUsesPerCustomer: json['max_uses_per_customer'] as int?,
      restrictedTo: json['restricted_to'] == null
          ? null
          : CouponRestrictedTo.fromJson(
              json['restricted_to'] as Map<String, dynamic>),
      shippingMethods: (json['shipping_methods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'type': _$CouponTypeEnumMap[instance.type]!,
    'amount': instance.amount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('min_purchase', instance.minPurchase);
  writeNotNull('expires', instance.expires);
  writeNotNull('enabled', instance.enabled);
  val['code'] = instance.code;
  writeNotNull('applies_to', instance.appliesTo);
  writeNotNull('max_uses', instance.maxUses);
  writeNotNull('max_uses_per_customer', instance.maxUsesPerCustomer);
  writeNotNull('restricted_to', instance.restrictedTo);
  writeNotNull('shipping_methods', instance.shippingMethods);
  return val;
}

const _$CouponTypeEnumMap = {
  CouponType.perItemDiscount: 'per_item_discount',
  CouponType.perTotalDiscount: 'per_total_discount',
  CouponType.shippingDiscount: 'shipping_discount',
  CouponType.freeShipping: 'free_shipping',
  CouponType.percentageDiscount: 'percentage_discount',
};

CouponAppliesTo _$CouponAppliesToFromJson(Map<String, dynamic> json) =>
    CouponAppliesTo(
      ids: (json['ids'] as List<dynamic>).map((e) => e as int).toList(),
      entity: $enumDecode(_$CoupleAppliesToTypeEnumMap, json['entity']),
    );

Map<String, dynamic> _$CouponAppliesToToJson(CouponAppliesTo instance) =>
    <String, dynamic>{
      'ids': instance.ids,
      'entity': _$CoupleAppliesToTypeEnumMap[instance.entity]!,
    };

const _$CoupleAppliesToTypeEnumMap = {
  CoupleAppliesToType.products: 'products',
  CoupleAppliesToType.categories: 'categories',
};

CouponRestrictedTo _$CouponRestrictedToFromJson(Map<String, dynamic> json) =>
    CouponRestrictedTo(
      countries: json['countries'] as String,
    );

Map<String, dynamic> _$CouponRestrictedToToJson(CouponRestrictedTo instance) =>
    <String, dynamic>{
      'countries': instance.countries,
    };
