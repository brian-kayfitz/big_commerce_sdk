import 'dart:convert';

import 'package:big_commerce_sdk/big_commerce_sdk.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

enum CouponType {
  @JsonValue('per_item_discount')
  perItemDiscount,

  @JsonValue('per_total_discount')
  perTotalDiscount,

  @JsonValue('shipping_discount')
  shippingDiscount,

  @JsonValue('free_shipping')
  freeShipping,

  @JsonValue('percentage_discount')
  percentageDiscount
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class Coupon {
  final String name;

  final CouponType type;

  /// The discount to apply to an order, as either an amount or a percentage. This field’s usage is determined by the coupon type. For example, a type of + percentage_discount would determine a percentage here.
  final String amount;

  /// Specifies a minimum value that an order must have before the coupon can be applied to it.
  final String? minPurchase;

  /// Specifies when a coupon expires. Coupons need not have an expiry date – you can also control expiry via + max_uses or max_uses_per_customer. If you do use this date field, the value must be in <a href="http://tools.ietf.org/html/rfc2822#section-3.3" target="_blank">RFC 2822</a> format.
  final String? expires;

  final bool? enabled;

  final String code;

  final CouponAppliesTo appliesTo;

  final int? maxUses;

  final int? maxUsesPerCustomer;

  final CouponRestrictedTo? restrictedTo;

  /// This is a list of shipping-method names. A shipping method must be enabled on the store to use it with a coupon. To check which shipping methods are enabled, please use the List Shipping Methods endpoint.
  final List<String>? shippingMethods;

  const Coupon({
    required this.name,
    required this.type,
    required this.amount,
    this.minPurchase,
    this.expires,
    this.enabled,
    required this.code,
    required this.appliesTo,
    this.maxUses,
    this.maxUsesPerCustomer,
    this.restrictedTo,
    this.shippingMethods,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  Future<void> create(BigCommerceClient client) async {
    final json = toJson();
    await client.send(
      method: HTTPMethod.post,
      path: 'coupons',
      body: json,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class CouponAppliesTo {
  final List<int> ids;
  final CoupleAppliesToType entity;

  CouponAppliesTo({required this.ids, required this.entity})
      : assert(ids.isNotEmpty);

  factory CouponAppliesTo.fromJson(Map<String, dynamic> json) =>
      _$CouponAppliesToFromJson(json);

  Map<String, dynamic> toJson() => _$CouponAppliesToToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

enum CoupleAppliesToType {
  @JsonValue('products')
  products,
  @JsonValue('categories')
  categories
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class CouponRestrictedTo {
  final String countries;

  CouponRestrictedTo({required this.countries});

  factory CouponRestrictedTo.fromJson(Map<String, dynamic> json) =>
      _$CouponRestrictedToFromJson(json);

  Map<String, dynamic> toJson() => _$CouponRestrictedToToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
