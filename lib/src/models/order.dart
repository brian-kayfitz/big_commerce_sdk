import 'dart:convert';

import 'package:big_commerce_sdk/big_commerce_sdk.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class Order {
  /// Products and Billing address only required for POST operation.
  final List<OrderProduct> products;
  final List<Address>? shippingAddresses;

  /// The value of the base handling cost. (Float, Float-As-String, Integer)
  final num? baseHandlingCost;

  /// The value of the base shipping cost. (Float, Float-As-String, Integer)
  final num? baseShippingCost;

  /// The value of the base wrapping cost expressed as a floating point number to four decimal places in string format.
  final String? baseWrappingCost;

  final Address? billingAddress;

  final int? channelId;

  final String? customerMessage;

  /// The date the order was created, formatted in the RFC-2822 standard.
  /// You set this attribute on Order creation (POST) to support the migration of historical orders.
  /// If you do not provide a value, then it will default to the current date/time. e.g., Tue, 20 Nov 2012 00:00:00 +0000.
  @JsonKey(
    toJson: parseRfc822,
    fromJson: readRfc822,
  )
  final DateTime? dateCreated;

  /// The currency code of the transactional currency the shopper pays in; writeable when multi-currency is enabled.
  final String? defaultCurrencyCode;

  /// Amount of discount for this transaction. (Float, Float-As-String, Integer)
  final num? discountAmount;

  /// If the order was placed through eBay, the eBay order number will be included. Otherwise, the value will be 0.
  final String? ebayOrderId;

  /// The merchant ID represents an upstream order from an external system.
  /// It is the source of truth for orders. After setting it, you cannot write to or update the external_merchant_id.
  /// For example, you can update the Facebook by Meta page ID in a POST request,
  /// but a PUT request to update the order will return a 400 error.
  /// Please remove it from your request before trying again.
  final String? externalMerchantId;

  /// This value identifies an external system that generated the order and submitted it to BigCommerce with the Orders API.
  ///
  ///     - When supplying the value, we recommend combining the type of system and vendor, e.g., ERP (Acumatica) or POS (Square).
  ///     - If you are migrating historical orders processed on another eCommerce platform to BigCommerce, supply the following code as the value: M-MIG. This code will exclude historical orders from the store’s GMV/order count, which factors into pricing.
  ///     - If you do not provide a value, then it will default to null.
  ///
  /// Example: null
  final String? externalSource;

  /// The full name of the country where the customer made the purchase, based on the IP.
  final String? geoipCountry;

  /// The country where the customer made the purchase, in ISO2 format, based on the IP.
  final String? geoipCountryIso2;

  /// The value of the handling cost, excluding tax. (Float, Float-As-String, Integer)
  final num? handlingCostExTax;

  /// The value of the handling cost, including tax. (Float, Float-As-String, Integer)
  final num? handlingCostIncTax;

  /// Pv4 Address of the customer, if known.
  ///
  /// Note: You can set either ip_address or ip_address_v6. Setting the ip_address value will reset the ip_address_v6 value and vice versa.
  /// <= 30 characters
  ///
  /// 12.345.678.910
  final String? ipAddress;

  /// IPv6 Address of the customer, if known.
  ///
  /// Note: You can set either ip_address or ip_address_v6. Setting the ip_address_v6 value will reset the ip_address value and vice versa.
  /// <= 39 characters
  ///
  /// 2001:db8:3333:4444:5555:6666:7777:8888
  final String? ipAddressV6;

  /// Indicates whether the order was deleted (archived). Set to to true, to archive an order.
  final bool? isDeleted;

  /// The number of items that have been shipped.
  final int? itemsShipped;

  /// The total number of items in the order.
  final int? itemsTotal;

  /// Whether this is an order for digital products.
  final bool? orderIsDigital;

  final PaymentMethod? paymentMethod;

  final String? paymentProviderId;

  final String? refundedAmount;

  final num? shippingCostExTax;

  final num? shippingCostIncTax;

  final String? staffNotes;

  final OrderStatus? statusId;

  final num? subtotalExTax;

  final num? subtotalIncTax;

  final String? taxProviderId;

  final String? customerLocale;

  final String? externalOrderId;

  final num? totalExTax;

  final num? totalIncTax;

  final num? wrappingCostExTax;

  final num? wrappingCostIncTax;

  const Order({
    required this.products,
    this.shippingAddresses,
    this.baseHandlingCost,
    this.baseShippingCost,
    this.baseWrappingCost,
    this.billingAddress,
    this.channelId,
    this.customerMessage,
    this.dateCreated,
    this.defaultCurrencyCode,
    this.discountAmount,
    this.ebayOrderId,
    this.externalMerchantId,
    this.externalSource,
    this.geoipCountry,
    this.geoipCountryIso2,
    this.handlingCostExTax,
    this.handlingCostIncTax,
    this.ipAddress,
    this.ipAddressV6,
    this.isDeleted,
    this.itemsShipped,
    this.itemsTotal,
    this.orderIsDigital,
    this.paymentMethod,
    this.paymentProviderId,
    this.refundedAmount,
    this.shippingCostExTax,
    this.shippingCostIncTax,
    this.staffNotes,
    this.statusId,
    this.subtotalExTax,
    this.subtotalIncTax,
    this.taxProviderId,
    this.customerLocale,
    this.externalOrderId,
    this.totalExTax,
    this.totalIncTax,
    this.wrappingCostExTax,
    this.wrappingCostIncTax,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Future<void> create(BigCommerceClient client) async {
    final json = toJson();
    await client.send(
      method: HTTPMethod.post,
      path: 'orders',
      apiVersionOverride: 2,
      body: json,
    );
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

String? parseRfc822(DateTime? date) {
  if (date == null) {
    return null;
  }

  final formatter = DateFormat("EEE, dd MMM yyyy HH:mm:ss");
  final buffer = StringBuffer();
  buffer.write(formatter.format(date));

  final timezone = date.timeZoneOffset.inHours * 100;
  buffer.write(' ');
  buffer.write(timezone > 0 ? '+' : '-');
  buffer.write('0');
  buffer.write(timezone.abs());

  return buffer.toString();
}

DateTime readRfc822(String dateString) {
  final formatter = DateFormat("EEE, dd MMM yyyy HH:mm:ss");
  if (dateString.contains('+') || dateString.contains('-')) {
    final timeZoneIndicator = dateString.contains('+') ? ' +' : ' -';
    final date = formatter.parse(dateString.split(timeZoneIndicator).first);

    return date;
  } else {
    return formatter.parse(dateString);
  }
}

/// Does not have to be a real Big Commerce product
@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class OrderProduct {
  final int? id;

  final String name;

  ///Alias for name_customer. The product name that is shown to customer in storefront. xxx and xxx_customer always hold the same value, updating either xxx or xxx_customer will change value for both of those fields.
  /// >= 1 characters
  ///
  /// Fog Linen Chambray Towel - Beige Stripe
  final String? nameCustomer;

  final String? nameMerchant;

  final int quantity;
  final num? priceIncTax;
  final num? priceExTax;
  final String? upc;
  final int? variantIdi;

  final int? wrappingId;

  // ID of the gift wrapping that will be used for this product. If provided, then wrapping_cost_ex_tax and wrapping_cost_inc_tax are required. When updating an order product line item, if wrapping_id is set to 0 and no other wrapping fields are provided,then the wrapping will be removed from the order product.
  final String? wrappingName;

  // If the wrapping_id is provided, this field will populate with the name of the gift wrapping that is to be used.
  final String? wrappingMessage;
  final num? wrappingCostExTax;

  // When provided, this value should be equal to wrapping_cost_ex_tax times quantity to accurately reflect wrapping cost per unit.
  final num? wrappingCostIncTax;

  final String? sku;

  const OrderProduct({
    this.id,
    this.sku,
    required this.name,
    this.nameCustomer,
    this.nameMerchant,
    required this.quantity,
    this.priceIncTax,
    this.priceExTax,
    this.upc,
    this.variantIdi,
    this.wrappingId,
    this.wrappingName,
    this.wrappingMessage,
    this.wrappingCostExTax,
    this.wrappingCostIncTax,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderProductFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class Address {
  final String? firstName;
  final String? lastName;
  final String? company;

  @JsonKey(name: 'street_1')
  final String? street1;

  @JsonKey(name: 'street_2')
  final String? street2;
  final String? city;
  final String? state;
  final String? zip;
  final String? country;
  final String? countryIso2;
  final String? phone;
  final String? email;
  final String? shippingMethod;

  const Address({
    this.firstName,
    this.lastName,
    this.company,
    this.street1,
    this.street2,
    this.city,
    this.state,
    this.country,
    this.countryIso2,
    this.zip,
    this.phone,
    this.email,
    this.shippingMethod,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

enum PaymentMethod {
  @JsonValue('Credit Card')
  creditCard,
  @JsonValue('Cash')
  cash,
  @JsonValue('Test Payment Gateway')
  testPaymentGateway,
  @JsonValue('Manual')
  manual,
}

enum OrderStatus {
  @JsonValue(0)
  incomplete, //	An incomplete order happens when a shopper reached the payment page, but did not complete the transaction.
  @JsonValue(1)
  pending, // Customer started the checkout process, but did not complete it.
  @JsonValue(2)
  shipped, // Order has been shipped, but receipt has not been confirmed; seller has used the Ship Items action.
  @JsonValue(3)
  partiallyShipped, // Only some items in the order have been shipped, due to some products being pre-order only or other reasons.
  @JsonValue(4)
  refunded, //	Seller has used the Refund action.
  @JsonValue(5)
  cancelled, //	Seller has cancelled an order, due to a stock inconsistency or other reasons.
  @JsonValue(6)
  declined, //	Seller has marked the order as declined for lack of manual payment, or other reasons.
  @JsonValue(7)
  awaitingPayment, //	Customer has completed checkout process, but payment has yet to be confirmed.
  @JsonValue(8)
  awaitingPickup, //	Order has been pulled, and is awaiting customer pickup from a seller-specified location.
  @JsonValue(9)
  awaitingShipment, // Order has been pulled and packaged, and is awaiting collection from a shipping provider.
  @JsonValue(10)
  completed, //	Client has paid for their digital product and their file(s) are available for download.
  @JsonValue(11)
  awaitingFulfillment, //	Customer has completed the checkout process and payment has been confirmed.
  @JsonValue(12)
  manual, // Verification Required	Order is on hold while some aspect needs to be manually confirmed.
  @JsonValue(13)
  disputed, //Customer has initiated a dispute resolution process for the PayPal transaction that paid for the order.
  @JsonValue(14)
  partially, // Refunded
}
