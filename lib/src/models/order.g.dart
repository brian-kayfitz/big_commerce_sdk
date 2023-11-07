// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      products: (json['products'] as List<dynamic>)
          .map((e) => OrderProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      shippingAddresses: (json['shipping_addresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      baseHandlingCost: json['base_handling_cost'] as num?,
      baseShippingCost: json['base_shipping_cost'] as num?,
      baseWrappingCost: json['base_wrapping_cost'] as String?,
      billingAddress: json['billing_address'] == null
          ? null
          : Address.fromJson(json['billing_address'] as Map<String, dynamic>),
      channelId: json['channel_id'] as int?,
      customerMessage: json['customer_message'] as String?,
      dateCreated: readRfc822(json['date_created'] as String),
      defaultCurrencyCode: json['default_currency_code'] as String?,
      discountAmount: json['discount_amount'] as num?,
      ebayOrderId: json['ebay_order_id'] as String?,
      externalMerchantId: json['external_merchant_id'] as String?,
      externalSource: json['external_source'] as String?,
      geoipCountry: json['geoip_country'] as String?,
      geoipCountryIso2: json['geoip_country_iso2'] as String?,
      handlingCostExTax: json['handling_cost_ex_tax'] as num?,
      handlingCostIncTax: json['handling_cost_inc_tax'] as num?,
      ipAddress: json['ip_address'] as String?,
      ipAddressV6: json['ip_address_v6'] as String?,
      isDeleted: json['is_deleted'] as bool?,
      itemsShipped: json['items_shipped'] as int?,
      itemsTotal: json['items_total'] as int?,
      orderIsDigital: json['order_is_digital'] as bool?,
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['payment_method']),
      paymentProviderId: json['payment_provider_id'] as String?,
      refundedAmount: json['refunded_amount'] as String?,
      shippingCostExTax: json['shipping_cost_ex_tax'] as num?,
      shippingCostIncTax: json['shipping_cost_inc_tax'] as num?,
      staffNotes: json['staff_notes'] as String?,
      statusId: $enumDecodeNullable(_$OrderStatusEnumMap, json['status_id']),
      subtotalExTax: json['subtotal_ex_tax'] as num?,
      subtotalIncTax: json['subtotal_inc_tax'] as num?,
      taxProviderId: json['tax_provider_id'] as String?,
      customerLocale: json['customer_locale'] as String?,
      externalOrderId: json['external_order_id'] as String?,
      totalExTax: json['total_ex_tax'] as num?,
      totalIncTax: json['total_inc_tax'] as num?,
      wrappingCostExTax: json['wrapping_cost_ex_tax'] as num?,
      wrappingCostIncTax: json['wrapping_cost_inc_tax'] as num?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) {
  final val = <String, dynamic>{
    'products': instance.products,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('shipping_addresses', instance.shippingAddresses);
  writeNotNull('base_handling_cost', instance.baseHandlingCost);
  writeNotNull('base_shipping_cost', instance.baseShippingCost);
  writeNotNull('base_wrapping_cost', instance.baseWrappingCost);
  writeNotNull('billing_address', instance.billingAddress);
  writeNotNull('channel_id', instance.channelId);
  writeNotNull('customer_message', instance.customerMessage);
  writeNotNull('date_created', parseRfc822(instance.dateCreated));
  writeNotNull('default_currency_code', instance.defaultCurrencyCode);
  writeNotNull('discount_amount', instance.discountAmount);
  writeNotNull('ebay_order_id', instance.ebayOrderId);
  writeNotNull('external_merchant_id', instance.externalMerchantId);
  writeNotNull('external_source', instance.externalSource);
  writeNotNull('geoip_country', instance.geoipCountry);
  writeNotNull('geoip_country_iso2', instance.geoipCountryIso2);
  writeNotNull('handling_cost_ex_tax', instance.handlingCostExTax);
  writeNotNull('handling_cost_inc_tax', instance.handlingCostIncTax);
  writeNotNull('ip_address', instance.ipAddress);
  writeNotNull('ip_address_v6', instance.ipAddressV6);
  writeNotNull('is_deleted', instance.isDeleted);
  writeNotNull('items_shipped', instance.itemsShipped);
  writeNotNull('items_total', instance.itemsTotal);
  writeNotNull('order_is_digital', instance.orderIsDigital);
  writeNotNull(
      'payment_method', _$PaymentMethodEnumMap[instance.paymentMethod]);
  writeNotNull('payment_provider_id', instance.paymentProviderId);
  writeNotNull('refunded_amount', instance.refundedAmount);
  writeNotNull('shipping_cost_ex_tax', instance.shippingCostExTax);
  writeNotNull('shipping_cost_inc_tax', instance.shippingCostIncTax);
  writeNotNull('staff_notes', instance.staffNotes);
  writeNotNull('status_id', _$OrderStatusEnumMap[instance.statusId]);
  writeNotNull('subtotal_ex_tax', instance.subtotalExTax);
  writeNotNull('subtotal_inc_tax', instance.subtotalIncTax);
  writeNotNull('tax_provider_id', instance.taxProviderId);
  writeNotNull('customer_locale', instance.customerLocale);
  writeNotNull('external_order_id', instance.externalOrderId);
  writeNotNull('total_ex_tax', instance.totalExTax);
  writeNotNull('total_inc_tax', instance.totalIncTax);
  writeNotNull('wrapping_cost_ex_tax', instance.wrappingCostExTax);
  writeNotNull('wrapping_cost_inc_tax', instance.wrappingCostIncTax);
  return val;
}

const _$PaymentMethodEnumMap = {
  PaymentMethod.creditCard: 'Credit Card',
  PaymentMethod.cash: 'Cash',
  PaymentMethod.testPaymentGateway: 'Test Payment Gateway',
  PaymentMethod.manual: 'Manual',
};

const _$OrderStatusEnumMap = {
  OrderStatus.incomplete: 0,
  OrderStatus.pending: 1,
  OrderStatus.shipped: 2,
  OrderStatus.partiallyShipped: 3,
  OrderStatus.refunded: 4,
  OrderStatus.cancelled: 5,
  OrderStatus.declined: 6,
  OrderStatus.awaitingPayment: 7,
  OrderStatus.awaitingPickup: 8,
  OrderStatus.awaitingShipment: 9,
  OrderStatus.completed: 10,
  OrderStatus.awaitingFulfillment: 11,
  OrderStatus.manual: 12,
  OrderStatus.disputed: 13,
  OrderStatus.partially: 14,
};

OrderProduct _$OrderProductFromJson(Map<String, dynamic> json) => OrderProduct(
      id: json['id'] as int?,
      sku: json['sku'] as String?,
      name: json['name'] as String,
      nameCustomer: json['name_customer'] as String?,
      nameMerchant: json['name_merchant'] as String?,
      quantity: json['quantity'] as int,
      priceIncTax: json['price_inc_tax'] as num?,
      priceExTax: json['price_ex_tax'] as num?,
      upc: json['upc'] as String?,
      variantIdi: json['variant_idi'] as int?,
      wrappingId: json['wrapping_id'] as int?,
      wrappingName: json['wrapping_name'] as String?,
      wrappingMessage: json['wrapping_message'] as String?,
      wrappingCostExTax: json['wrapping_cost_ex_tax'] as num?,
      wrappingCostIncTax: json['wrapping_cost_inc_tax'] as num?,
    );

Map<String, dynamic> _$OrderProductToJson(OrderProduct instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  writeNotNull('name_customer', instance.nameCustomer);
  writeNotNull('name_merchant', instance.nameMerchant);
  val['quantity'] = instance.quantity;
  writeNotNull('price_inc_tax', instance.priceIncTax);
  writeNotNull('price_ex_tax', instance.priceExTax);
  writeNotNull('upc', instance.upc);
  writeNotNull('variant_idi', instance.variantIdi);
  writeNotNull('wrapping_id', instance.wrappingId);
  writeNotNull('wrapping_name', instance.wrappingName);
  writeNotNull('wrapping_message', instance.wrappingMessage);
  writeNotNull('wrapping_cost_ex_tax', instance.wrappingCostExTax);
  writeNotNull('wrapping_cost_inc_tax', instance.wrappingCostIncTax);
  writeNotNull('sku', instance.sku);
  return val;
}

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      company: json['company'] as String?,
      street1: json['street_1'] as String?,
      street2: json['street_2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      countryIso2: json['country_iso2'] as String?,
      zip: json['zip'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      shippingMethod: json['shipping_method'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('company', instance.company);
  writeNotNull('street_1', instance.street1);
  writeNotNull('street_2', instance.street2);
  writeNotNull('city', instance.city);
  writeNotNull('state', instance.state);
  writeNotNull('zip', instance.zip);
  writeNotNull('country', instance.country);
  writeNotNull('country_iso2', instance.countryIso2);
  writeNotNull('phone', instance.phone);
  writeNotNull('email', instance.email);
  writeNotNull('shipping_method', instance.shippingMethod);
  return val;
}
