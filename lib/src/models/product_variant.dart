import 'dart:convert';

import 'package:collection/collection.dart';

import '../../big_commerce_sdk.dart';

class ProductVariant {
  int? id;

  final Product product;

  /// >= 1 characters<= 255 characters
  final String sku;

  /// Array of option and option values IDs that make up this variant. Will be empty if the variant is the product's base variant.
  final List<ProductVariantValue> optionValues;

  /// This variant’s base price on the storefront. If a Price List ID is used, the Price List value will be used. If a Price List ID is not used, and this value is null, the product’s default price (set in the Product resource’s price field) will be used as the base price.
  final num? price;

  /// The cost price of the variant. Not affected by Price List prices.
  final num? costPrice;

  /// This variant’s sale price on the storefront. If a Price List ID is used, the Price List value will be used. If a Price List ID is not used, and this value is null, the product’s sale price (set in the Product resource’s price field) will be used as the sale price.
  final num? salePrice;

  /// This variant’s retail price on the storefront. If a Price List ID is used, the Price List value will be used. If a Price List ID is not used, and this value is null, the product’s retail price (set in the Product resource’s price field) will be used as the retail price.
  final num? retailPrice;

  /// This variant’s base weight on the storefront. If this value is null, the product’s default weight (set in the Product resource’s weight field) will be used as the base weight.
  final num? weight;

  /// Width of the variant, which can be used when calculating shipping costs. If this value is null, the product's default width (set in the Product resource's width field) will be used as the base width.
  final num? width;

  /// Height of the variant, which can be used when calculating shipping costs. If this value is null, the product's default height (set in the Product resource's height field) will be used as the base height.
  final num? height;

  /// Depth of the variant, which can be used when calculating shipping costs. If this value is null, the product's default depth (set in the Product resource's depth field) will be used as the base depth.
  final num? depth;

  /// Flag used to indicate whether the variant has free shipping. If true, the shipping cost for the variant will be zero.
  final bool? isFreeShipping;

  /// A fixed shipping cost for the variant. If defined, this value will be used during checkout instead of normal shipping-cost calculation.
  final num? fixedCostShippingPrice;

  /// If true, this variant will not be purchasable on the storefront.
  final bool? purchasingDisabled;

  /// If purchasing_disabled is true, this message should show on the storefront when the variant is selected.
  /// >= 0 characters<= 255 characters
  final String? purchasingDisabledMessage;

  /// The UPC code used in feeds for shopping comparison sites and external channel integrations.
  final String? upc;

  /// Inventory level for the variant, which is used when the product’s inventory_tracking is set to variant. The Catalog API returns the inventory for only the default location.
  ///
  /// The inventory for a variant cannot exceed 2,147,483,647 in the catalog. The sum of the variant inventories, or the total inventory for a product, cannot exceed 2,147,483,647.
  ///
  /// If you exceed the limit, the store sets the variant inventory to the limit if no other variant inventories are set. If other variant inventories are set, the store does not save the variant inventory rather than setting the variant inventory to the remaining limit.
  ///
  /// The Catalog API handles limits in a different way than the Inventory API. For more information, see Limit handling.
  /// https://developer.bigcommerce.com/buy-online-pick-up-in-store/inventory#limit-handling-in-inventory-versus-catalog-api
  final int? inventoryLevel;

  /// When the variant hits this inventory level, it is considered low stock.
  final int? inventoryWarningLevel;

  /// Identifies where in a warehouse the variant is located.
  /// >= 0 characters<= 255 characters
  final String? binPickingNumber;

  /// Publicly available image url
  final Image? image;

  /// Global Trade Item Number
  ///
  /// 012345678905
  final String? gtin;

  /// Manufacturer Part Number
  ///
  /// HV-HM02
  final String? mpn;

  ProductVariant({
    this.id,
    required this.sku,
    required this.product,
    this.price,
    this.costPrice,
    this.weight,
    this.purchasingDisabled,
    this.image,
    this.isFreeShipping,
    required this.optionValues,
    this.salePrice,
    this.retailPrice,
    this.width,
    this.height,
    this.depth,
    this.fixedCostShippingPrice,
    this.purchasingDisabledMessage,
    this.upc,
    this.inventoryLevel,
    this.inventoryWarningLevel,
    this.binPickingNumber,
    this.gtin,
    this.mpn,
  });

  ProductVariant.fromJson(Map json, this.product)
      : id = json['id'],
        sku = json['sku'],
        price = json['price'],
        costPrice = json['cost_price'],
        purchasingDisabled = json['purchasing_disabled'],
        weight = json['weight'],
        isFreeShipping = json['is_free_shipping'],
        optionValues = json['option_values']
            ?.map<ProductVariantValue>((e) => ProductVariantValue.fromJson(e))
            .toList(),
        image = Image.fromUrl(json['image_url']),
        salePrice = json['sale_price'],
        retailPrice = json['retail_price'],
        width = json['width'],
        height = json['height'],
        depth = json['depth'],
        fixedCostShippingPrice = json['fixed_cost_shipping_price'],
        purchasingDisabledMessage = json['purchasing_disabled_message'],
        upc = json['upc'],
        inventoryLevel = json['inventory_level'],
        inventoryWarningLevel = json['inventory_warning_level'],
        binPickingNumber = json['bin_picking_number'],
        gtin = json['gtin'],
        mpn = json['mpn'];

  Map toJson() => {
        'product_id': product.id,
        'sku': sku,
        'price': price,
        'cost_price': costPrice,
        'purchasing_disabled': purchasingDisabled,
        'weight': weight,
        'is_free_shipping': isFreeShipping,
        'option_values': optionValues.map((e) => e.toJson()).toList(),
        'image_url': (image?.valid ?? false)
            ? image!.imageUrl.toString()
            : null,
        'sale_price': salePrice,
        'retail_price': retailPrice,
        'width': width,
        'height': height,
        'depth': depth,
        'fixed_cost_shipping_price': fixedCostShippingPrice,
        'purchasing_disabled_message': purchasingDisabledMessage,
        'upc': upc,
        'inventory_level': inventoryLevel,
        'inventory_warning_level': inventoryWarningLevel,
        'bin_picking_number': binPickingNumber,
        'gtin': gtin,
        'mpn': mpn,
      }..removeWhere(
          (key, value) => value == null || value is String && value.isEmpty);

  Future<void> create({required BigCommerceClient client}) async {
    if (image != null) {
      await image?.validate();
    }

    final response = await client.send(
      method: HTTPMethod.post,
      path: 'catalog/products/${product.id}/variants',
      body: toJson(),
    );

    id = response['data']['id'];
  }

  static Future<List<ProductVariant>> get({
    required Product product,
    required BigCommerceClient client,
  }) async {
    final path = 'catalog/products/${product.id}/variants';
    final results = await client.send(
      method: HTTPMethod.get,
      fetchAllPages: true,
      path: path,
    );

    final data = results is List ? results : results['data'];
    return data
        .map<ProductVariant>((json) => ProductVariant.fromJson(json, product))
        .toList();
  }

  Future<void> delete({required BigCommerceClient client}) async {
    assert(id != null);
    final path = 'catalog/products/${product.id}/variants/$id';
    await client.send(method: HTTPMethod.delete, path: path);
  }

  @override
  String toString() => toJson().toString();
}

class ProductVariantValue {
  final String optionDisplayName;
  final String label;
  final int id;
  final int optionId;

  const ProductVariantValue({
    required this.optionDisplayName,
    required this.label,
    required this.id,
    required this.optionId,
  });

  ProductVariantValue.fromOptionAndValue(
    ProductOption option,
    ProductOptionValue value,
  )   : assert(option.values.contains(value)),
        optionDisplayName = option.name,
        optionId = option.id,
        id = value.id,
        label = value.label;

  Map toJson() => {
        'option_display_name': optionDisplayName,
        'label': label,
        'id': id,
        'option_id': optionId,
      };

  @override
  String toString() => toJson().toString();

  ProductVariantValue.fromJson(Map json)
      : optionDisplayName = json['option_display_name'],
        label = json['label'],
        id = json['id'],
        optionId = json['option_id'];
}

class ProductOption {
  final int id;
  final String name;
  final int sort;
  final ProductOptionType type;
  final List<ProductOptionValue> values;

  const ProductOption({
    required this.id,
    required this.name,
    required this.sort,
    required this.type,
    required this.values,
  });

  ProductOption.fromJson(Map json)
      : id = json['id'],
        name = json['display_name'],
        sort = json['sort_order'],
        type = ProductOptionType.values
            .firstWhere((element) => element.key == json['type']),
        values = json['option_values']
            .map<ProductOptionValue>((e) => ProductOptionValue.fromJson(e))
            .toList();

  @override
  String toString() {
    return '$name - ${values.length}';
  }

  static Future<ProductOption> create({
    required BigCommerceClient client,
    required ProductOptionBuilder builder,
  }) async {
    final payload = builder.toJson();
    final response = await client.send(
      method: HTTPMethod.post,
      path: 'catalog/products/${builder.product.id}/options',
      body: payload,
    );

    final data = response['data'];
    return ProductOption.fromJson(data);
  }

  static Future<List<ProductOption>> get({
    required Product product,
    required BigCommerceClient client,
  }) async {
    final response = await client.send(
      method: HTTPMethod.get,
      path: 'catalog/products/${product.id}/options',
      fetchAllPages: true,
    );

    return response
        .map<ProductOption>((json) => ProductOption.fromJson(json))
        .toList();
  }

  Future<void> delete(Product parent, BigCommerceClient client) async {
    final path = 'catalog/products/${parent.id}/options/$id';
    await client.send(method: HTTPMethod.delete, path: path);
  }
}

class ProductOptionBuilder {
  final Product product;
  final String displayName;
  final ProductOptionType type;
  final int sortOrder;
  final List<String> optionValues;

  const ProductOptionBuilder({
    required this.product,
    required this.displayName,
    required this.type,
    required this.sortOrder,
    required this.optionValues,
  });

  Map toJson() => {
        'product_id': product.id,
        'display_name': displayName,
        'type': type.key,
        'sort_order': sortOrder,
        'option_values': optionValues
            .mapIndexed((index, label) => {
                  'label': label,
                  'sort_order': index,
                })
            .toList()
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

enum ProductOptionType {
  radioButtons('radio_buttons'),
  rectangles('rectangles'),
  dropdown('dropdown'),
  productList('product_list'),
  productListWithImages('product_list_with_images'),
  swatch('swatch');

  const ProductOptionType(this.key);
  final String key;
}

class ProductOptionValue {
  final int id;
  final String label;

  ProductOptionValue.fromJson(Map json)
      : id = json['id'],
        label = json['label'];
}
