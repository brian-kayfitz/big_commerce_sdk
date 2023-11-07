import 'package:collection/collection.dart';

import '../big_commerce_client.dart';
import 'brand.dart';
import 'category.dart';
import 'custom_field.dart';
import 'image.dart';
import 'video.dart';

class Product {
  int? id;

  String _name;

  /// A unique product name.
  /// >= 1 characters<= 250 characters
  String get name => _name;

  set name(String value) {
    _mutatedFields.add('name');
    _name = value;
  }

  /// The product type. One of: physical - a physical stock unit, digital - a digital download.
  final ProductType type;

  /// A unique user-defined product code/stock keeping unit (SKU).
  /// >= 0 characters<= 255 characters
  final String? sku;

  /// The product description, which can include HTML formatting.
  String? _description;

  String? get description => _description;

  set description(String? value) {
    _mutatedFields.add('description');
    _description = value;
  }

  /// Weight of the product, which can be used when calculating shipping costs. This is based on the unit set on the store
  final num weight;

  /// Width of the product, which can be used when calculating shipping costs.
  final num? width;

  /// Height of the product, which can be used when calculating shipping costs.
  final num? height;

  /// Depth of the product, which can be used when calculating shipping costs.
  final num? depth;

  /// The price of the product. The price should include or exclude tax, based on the store settings.
  final num price;

  /// The cost price of the product. Stored for reference only; it is not used or displayed anywhere on the store.
  final num? costPrice;

  /// The retail cost of the product. If entered, the retail cost price will be shown on the product page.
  final num? retailPrice;

  /// If entered, the sale price will be used instead of value in the price field when calculating the product's cost.
  final num? salePrice;

  /// Minimum Advertised Price
  final num? mapPrice;

  /// The ID of the tax class applied to the product. (NOTE: Value ignored if automatic tax is enabled.)
  final int? taxClassId;

  /// Accepts AvaTax System Tax Codes, which identify products and services that fall into special sales-tax categories. By using these codes, merchants who subscribe to BigCommerce's Avalara Premium integration can calculate sales taxes more accurately. Stores without Avalara Premium will ignore the code when calculating sales tax. Do not pass more than one code. The codes are case-sensitive. For details, please see Avalara's documentation.
  /// >= 0 characters<= 255 characters
  final String? productTaxCode;

  /// An array of IDs for the categories to which this product belongs. When updating a product, if an array of categories is supplied, all product categories will be overwritten. Does not accept more than 1,000 ID values.
  final List<Category> categories;

  /// A product can be added to an existing brand during a product /PUT or /POST.
  final Brand? brand;

  /// Current inventory level of the product. Simple inventory tracking must be enabled (See the inventory_tracking field) for this to take any effect.
  final int? inventoryLevel;

  /// Inventory warning level for the product. When the product's inventory level drops below the warning level, the store owner will be informed. Simple inventory tracking must be enabled (see the inventory_tracking field) for this to take any effect.
  final int? inventoryWarningLevel;

  /// The type of inventory tracking for the product. Values are: none - inventory levels will not be tracked; product - inventory levels will be tracked using the inventory_level and inventory_warning_level fields; variant - inventory levels will be tracked based on variants, which maintain their own warning levels and inventory levels
  final InventoryTracking? inventoryTracking;

  /// A fixed shipping cost for the product. If defined, this value will be used during checkout instead of normal shipping-cost calculation.
  final num? fixedCostShippingPrice;

  /// Flag used to indicate whether the product has free shipping. If true, the shipping cost for the product will be zero.
  final bool? isFreeShipping;

  /// Flag used to indicate whether the product has free shipping. If true, the shipping cost for the product will be zero.
  final bool? isVisible;

  /// Flag to determine whether the product should be displayed to customers browsing the store. If true, the product will be displayed. If false, the product will be hidden from view.
  final bool? isFeatured;

  /// An array of IDs for the related products.
  List<int>? _relatedProducts;

  List<int>? get relatedProducts => _relatedProducts;

  set relatedProducts(List<int>? value) {
    _mutatedFields.add('related_products');
    _relatedProducts = value;
  }

  /// Warranty information displayed on the product page. Can include HTML formatting.
  /// >= 0 characters<= 65535 characters
  final String? warranty;

  /// The BIN picking number for the product.
  /// >= 0 characters<= 255 characters
  final String? binPickingNumber;

  /// The layout template file used to render this product category. This field is writable only for stores with a Blueprint theme applied. For stores with a Stencil theme applied, see Custom Template Associations.
  /// https://developer.bigcommerce.com/docs/rest-content/custom-template-associations
  /// >= 0 characters<= 500 characters
  String? _layoutFile;

  String? get layoutFile => _layoutFile;

  set layoutFile(String? value) {
    _mutatedFields.add('layout_file');
    _layoutFile = value;
  }

  /// The product UPC code, which is used in feeds for shopping comparison sites and external channel integrations.
  /// >= 0 characters<= 32 characters
  final String? upc;

  /// A comma-separated list of keywords that can be used to locate the product when searching the store.
  /// >= 0 characters<= 65535 characters
  final String? searchKeywords;

  /// Availability text displayed on the checkout page, under the product title. Tells the customer how long it will normally take to ship this product, such as: 'Usually ships in 24 hours.'
  /// >= 0 characters<= 255 characters
  final String? availabilityDescription;

  /// Availability of the product. (Corresponds to the product's Purchasability section in the control panel.) Supported values: available - the product is available for purchase; disabled - the product is listed on the storefront, but cannot be purchased; preorder - the product is listed for pre-orders.
  /// https://support.bigcommerce.com/s/article/Adding-Products-v3?language=en_US#sections
  final Availability? availability;

  /// Type of gift-wrapping options. Values: any - allow any gift-wrapping options in the store; none - disallow gift-wrapping on the product; list – provide a list of IDs in the gift_wrapping_options_list field.
  final GiftWrappingType? giftWrappingOptionsType;

  /// A list of gift-wrapping option IDs.
  final List<int>? giftWrappingOptionsList;

  /// Priority to give this product when included in product lists on category pages and in search results. Lower integers will place the product closer to the top of the results.
  final int? sortOrder;

  /// The product condition. Will be shown on the product page if the is_condition_shown field's value is true. Possible values: New, Used, Refurbished.
  final Condition? condition;

  /// Flag used to determine whether the product condition is shown to the customer on the product page.
  final bool? isConditionShown;

  /// The minimum quantity an order must contain, to be eligible to purchase this product.
  final int? orderQuantityMinimum;

  /// The maximum quantity an order can contain when purchasing the product.
  final int? orderQuantityMaximum;

  /// Custom title for the product page. If not defined, the product name will be used as the meta title.
  /// >= 0 characters<= 255 characters
  final String? pageTitle;

  /// Custom meta keywords for the product page. If not defined, the store's default keywords will be used.
  final List<String>? metaKeywords;

  /// Custom meta description for the product page. If not defined, the store's default meta description will be used.
  /// >= 0 characters<= 65535 characters
  final String? metaDescription;

  /// The number of times the product has been viewed.
  final int? viewCount;

  /// False by default, indicating that this product's price should be shown on the product page. If set to true, the price is hidden. (NOTE: To successfully set is_price_hidden to true, the availability value must be disabled.)
  final bool? isPriceHidden;

  /// By default, an empty string. If is_price_hidden is true, the value of price_hidden_label is displayed instead of the price. (NOTE: To successfully set a non-empty string value with is_price_hidden set to true, the availability value must be disabled.)
  /// >= 0 characters<= 200 characters
  final String? priceHiddenLabel;

  /// The brand can be created during a product PUT or POST request. If the brand already exists then the product will be added. If not the brand will be created and the product added. If using brand_name it performs a fuzzy match and adds the brand. eg. "Common Good" and "Common good" are the same. Brand name does not return as part of a product response. Only the brand_id.
  /// Example - Common Good
  final String? brandNameOrBrandId;

  /// Global Trade Item Number
  final String? gtin;

  /// Manufacturer Part Number
  final String? mpn;

  /// The total (cumulative) rating for the product.
  final int? reviewsRatingSum;

  /// The number of times the product has been rated.
  final int? reviewsCount;

  /// The total quantity of this product sold.
  final int? totalSold;

  final List<CustomField>? customFields;

  final List<Image>? images;

  final List<Video>? videos;

  final int channel;

  Product({
    this.id,
    required String name,
    required this.type,
    this.sku,
    String? description,
    required this.weight,
    this.width,
    this.height,
    this.depth,
    required this.price,
    this.costPrice,
    this.retailPrice,
    this.salePrice,
    this.mapPrice,
    this.taxClassId,
    this.productTaxCode,
    required this.categories,
    this.brand,
    this.inventoryLevel,
    this.inventoryWarningLevel,
    this.inventoryTracking,
    this.fixedCostShippingPrice,
    this.isFreeShipping,
    this.isVisible,
    this.isFeatured,
    List<int>? relatedProducts,
    this.warranty,
    this.binPickingNumber,
    String? layoutFile,
    this.upc,
    this.searchKeywords,
    this.availabilityDescription,
    this.availability,
    this.giftWrappingOptionsType,
    this.giftWrappingOptionsList,
    this.sortOrder,
    this.condition,
    this.isConditionShown,
    this.orderQuantityMinimum,
    this.orderQuantityMaximum,
    this.pageTitle,
    this.metaKeywords,
    this.metaDescription,
    this.viewCount,
    this.isPriceHidden,
    this.priceHiddenLabel,
    this.brandNameOrBrandId,
    this.gtin,
    this.mpn,
    this.reviewsRatingSum,
    this.reviewsCount,
    this.totalSold,
    this.customFields,
    this.images,
    this.videos,
    required this.channel,
  })  : _name = name,
        _relatedProducts = relatedProducts,
        _layoutFile = layoutFile,
        _description = description;

  Product.fromJson(Map json)
      : id = json['id'],
        _name = json['name'],
        type = ProductType.values
            .firstWhere((element) => element.name == json['type']),
        sku = json['sku'],
        _description = json['description'],
        weight = json['weight'],
        width = json['width'],
        depth = json['depth'],
        height = json['height'],
        price = json['price'],
        costPrice = json['cost_price'],
        retailPrice = json['retail_price'],
        salePrice = json['sale_price'],
        mapPrice = json['map_price'],
        taxClassId = json['tax_class_id'],
        productTaxCode = json['product_tax_code'],
        categories =
            [], // json['categories'], categories.map<int?>((e) => e.id).whereNotNull().toList(),
        brand = null, // json['brand_id'], brand?.id,
        inventoryLevel = json['inventory_level'],
        inventoryWarningLevel = json['inventory_warning_level'],
        inventoryTracking = InventoryTracking.values.firstWhereOrNull(
            (element) => element.name == json['inventory_tracking']),
        fixedCostShippingPrice = json['fixed_cost_shipping_price'],
        isFreeShipping = json['is_free_shipping'],
        isVisible = json['is_visible'],
        isFeatured = json['is_featured'],
        _relatedProducts = json['related_products']?.cast<int>(),
        warranty = json['warranty'],
        binPickingNumber = json['bin_picking_number'],
        _layoutFile = json['layout_file'],
        upc = json['upc'],
        searchKeywords = json['search_keywords'],
        availabilityDescription = json['availability_description'],
        availability = Availability.values.firstWhereOrNull(
            (element) => element.name == json['availability']),
        giftWrappingOptionsType = GiftWrappingType.values.firstWhereOrNull(
            (element) => element.name == json['gift_wrapping_options_type']),
        giftWrappingOptionsList =
            json['gift_wrapping_options_list']?.cast<int>(),
        sortOrder = json['sort_order'],
        condition = Condition.values
            .firstWhereOrNull((element) => element == json['condition']),
        isConditionShown = json['is_condition_shown'],
        orderQuantityMinimum = json['order_quantity_minimum'],
        orderQuantityMaximum = json['order_quantity_maximum'],
        pageTitle = json['page_title'],
        metaKeywords = json['meta_keywords']?.cast<String>(),
        metaDescription = json['meta_description'],
        viewCount = json['view_count'],
        isPriceHidden = json['is_price_hidden'],
        priceHiddenLabel = json['price_hidden_label'],
        brandNameOrBrandId = json['brand_name or brand_id'],
        gtin = json['gtin'],
        mpn = json['mpn'],
        reviewsRatingSum = json['reviews_rating_sum'],
        reviewsCount = json['reviews_count'],
        totalSold = json['total_sold'],
        channel = 0,
        customFields =
            json['custom_fields']?.map((e) => CustomField.fromJson(e)).toList(),
        images = json['images']?.map((e) => Image.fromJson(e)).toList(),
        videos = json['videos']?.map((e) => Video.fromJson(e)).toList();

  Map toJson() {
    final json = {
      'id': id,
      'name': name,
      'type': type.name,
      'sku': sku,
      'description': _description,
      'weight': weight,
      'width': width,
      'depth': depth,
      'height': height,
      'price': price,
      'cost_price': costPrice,
      'retail_price': retailPrice,
      'sale_price': salePrice,
      'map_price': mapPrice,
      'tax_class_id': taxClassId,
      'product_tax_code': productTaxCode,
      'categories': categories.map<int?>((e) => e.id).whereNotNull().toList(),
      'brand_id': brand?.id,
      'inventory_level': inventoryLevel,
      'inventory_warning_level': inventoryWarningLevel,
      'inventory_tracking': inventoryTracking?.name,
      'fixed_cost_shipping_price': fixedCostShippingPrice,
      'is_free_shipping': isFreeShipping,
      'is_visible': isVisible,
      'is_featured': isFeatured,
      'related_products': _relatedProducts,
      'warranty': warranty,
      'bin_picking_number': binPickingNumber,
      'layout_file': layoutFile,
      'upc': upc,
      'search_keywords': searchKeywords,
      'availability_description': availabilityDescription,
      'availability': availability?.name,
      'gift_wrapping_options_type': giftWrappingOptionsType?.name,
      'gift_wrapping_options_list': giftWrappingOptionsList,
      'sort_order': sortOrder,
      'condition': condition?.name,
      'is_condition_shown': isConditionShown,
      'order_quantity_minimum': orderQuantityMinimum,
      'order_quantity_maximum': orderQuantityMaximum,
      'page_title': pageTitle,
      'meta_keywords': metaKeywords,
      'meta_description': metaDescription,
      'view_count': viewCount,
      'is_price_hidden': isPriceHidden,
      'price_hidden_label': priceHiddenLabel,
      'brand_name or brand_id': brandNameOrBrandId,
      'gtin': gtin,
      'mpn': mpn,
      'reviews_rating_sum': reviewsRatingSum,
      'reviews_count': reviewsCount,
      'total_sold': totalSold,
      'custom_fields': customFields?.map((e) => e.toJson()).toList(),
      'images': images?.map((e) => e.toJson()).toList(),
      'videos': videos?.map((e) => e.toJson()).toList(),
      'channel': channel,
    };
    json.removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty));
    return json;
  }

  final _mutatedFields = <String>{
    'name',
    'type',
    'weight',
    'price',
  };

  Future create(BigCommerceClient client) async {
    if (this.id != null) {
      return;
    }

    await _checkIfImagesAreValid();

    final body = toJson();
    body.remove('id');
    body.remove('channel');

    final Map response = await client.send(
      method: HTTPMethod.post,
      path: 'catalog/products',
      body: body,
    );

    final id = response['data']?['id'];
    this.id = id;
  }

  Future<void> delete(BigCommerceClient client) {
    assert(id != null);
    return client.send(
      method: HTTPMethod.delete,
      path: 'catalog/products',
      options: BigCommerceRequestOptions(extras: {'id:in': '$id'}),
    );
  }

  Future<void> createCustomField(
      BigCommerceClient client, CustomField field) async {
    assert(id != null);
    final path = 'catalog/products/$id/custom-fields';

    await client.send(
      method: HTTPMethod.post,
      path: path,
      body: field.toJson(),
    );

    customFields?.add(field);
  }

  Future<void> updateCustomField(
      BigCommerceClient client, CustomField field) async {
    assert(field.id != null);
    final path = 'catalog/products/$id/custom-fields/${field.id}';
    await client.send(
      method: HTTPMethod.put,
      path: path,
      body: field.toJson(),
    );

    final index = customFields?.indexWhere((element) => element.id == field.id);
    if (index != null && index >= 0) {
      customFields?[index] = field;
    }
  }

  Future<List<CustomField>> fetchCustomFields(BigCommerceClient client) async {
    assert(id != null);
    final path = 'catalog/products/$id/custom-fields';

    final results = await client.send(
      method: HTTPMethod.get,
      path: path,
      fetchAllPages: true,
    );

    final fields =
        results.map<CustomField>((json) => CustomField.fromJson(json)).toList();
    return fields;
  }

  Future assignChannel(BigCommerceClient client) async {
    final id = this.id;
    if (id == null) {
      throw Exception('No valid product id');
    }

    return client.send(
      method: HTTPMethod.put,
      path: 'catalog/products/channel-assignments',
      body: [
        {
          'product_id': id,
          'channel_id': channel,
        }
      ],
    );
  }

  Future<void> _checkIfImagesAreValid() async {
    final images = this.images;
    if (images == null) {
      return;
    }

    for (final image in images) {
      await image.validate();
    }

    images.removeWhere((image) => !image.valid);
  }

  @override
  String toString() {
    return 'Product{id: $id, sku: $sku, name: $name}';
  }

  Future<void> update(BigCommerceClient client) async {
    assert(id != null);
    final body = toJson();
    body.remove('id');
    body.remove('channel');

    body.removeWhere((key, value) => _mutatedFields.contains(key) == false);

    await client.send(
      method: HTTPMethod.put,
      path: 'catalog/products/$id',
      body: body,
    );
  }

  static Future<List<Product>> all(BigCommerceClient client) async {
    final response = await client.send(
      method: HTTPMethod.get,
      path: 'catalog/products',
      fetchAllPages: true,
    );

    return response.map<Product>((json) => Product.fromJson(json)).toList();
  }
}

enum ProductType {
  physical,
  digital,
}

enum InventoryTracking {
  none,
  product,
  variant,
}

enum Availability {
  available,
  disabled,
  preorder,
}

enum GiftWrappingType {
  any,
  none,
  list,
}

enum Condition {
  New, //CAPITALIZED to match big commerce json
  Used,
  Refurbished,
}
