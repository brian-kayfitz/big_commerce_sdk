import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';

import '../big_commerce_client.dart';

class Category {
  final String name;
  final String? description;
  final String? metaDescription;
  final List<String>? metaKeywords;
  final bool visible;
  final String? imageUrl;
  final String? customUrl;
  var children = <Category>[];
  int? id;

  int? parentId;

  Category? _parent;

  Category? get parent => _parent;

  Category({
    required this.name,
    this.id,
    this.parentId,
    this.description,
    this.metaDescription,
    this.metaKeywords,
    this.visible = true,
    this.imageUrl,
    this.customUrl,
  }) {
    metaKeywords?.removeWhere((element) => element.isEmpty);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Category &&
              runtimeType == other.runtimeType &&
              name.trim().toLowerCase() == other.name.trim().toLowerCase();

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'Category{name: $name, id: $id, subCategories: ${children.length}';
  }

  void addChild(Category category) {
    category._parent = this;
    children.add(category);
  }

  Future<void> upload(BigCommerceClient client,
      List<Category>? existing, {
        Category? parent,
      }) async {
    final known = existing?.firstWhereOrNull((element) => element == this);
    if (known == null) {
      await _doUpload(client);
    } else {
      id = known.id;
    }

    for (final child in children) {
      child.parentId = id;
      await child.upload(client, known?.children);
    }
  }

  Future<void> _doUpload(BigCommerceClient client) async {
    final result = await client.send(
      method: HTTPMethod.post,
      path: 'catalog/categories',
      body: {
        'parent_id': parentId ?? parent?.id ?? 0,
        'name': name,
        'is_visible': visible,
        if (description != null && (description ?? '').isNotEmpty)
          'description': description,
        if (metaDescription != null && (metaDescription ?? '').isNotEmpty)
          'meta_description': metaDescription,
        if (metaKeywords != null && (metaKeywords ?? []).isNotEmpty)
          'meta_keywords': metaKeywords,
        if (customUrl != null && (customUrl ?? '').isNotEmpty)
          'custom_url': {
            'url': customUrl,
            'is_customized': true,
          },
      },
    );

    final id = result['data']['id'];
    this.id = id;

    return _uploadThumbnail(client);
  }

  Future<void> _uploadThumbnail(BigCommerceClient client) async {
    if (imageUrl == null) {
      return;
    }

    assert(id != null);

    final route = 'catalog/categories/$id/image';

    final uri = Uri.parse(imageUrl!);
    final imageResponse = await get(uri);
    final outputFile = File('images/${uri.pathSegments.last}');
    if (!outputFile.parent.existsSync()) {
      outputFile.parent.createSync(recursive: true);
    }
    outputFile.writeAsBytesSync(imageResponse.bodyBytes);

    final request = MultipartRequest('POST', client.buildUri(route, null))
      ..files.add(await MultipartFile.fromPath('image_file', outputFile.path));

    request.headers[BigCommerceClient.kTokenKey] = client.apiKey;
    request.headers['content-type'] = 'multipart/form-data';

    print('Sending Thumbnail');
    await request.send();
    print('Uploaded Thumbnail!');
  }

  static Category fromBigCommereJson(Map json, List<Map> all) {
    final custom = json['custom_url'];

    final category = Category(
      name: json['name'],
      id: json['id'],
      parentId: json['parent_id'],
      description: json['description'],
      metaDescription: json['meta_description'],
      imageUrl: json['image_url'],
      visible: json['is_visible'],
      customUrl: custom['is_customized'] == true ? custom['url'] : null,
    );

    final children = all.where((e) => e['parent_id'] == category.id).toList();
    if (children.isNotEmpty) {
      final subCateogies =
      children.map((e) => Category.fromBigCommereJson(e, all));
      category.children.addAll(subCateogies);
    }

    return category;
  }

  static void addHierarchy(List<String> components, List<Category> categories) {
    if (components.isEmpty) {
      return;
    }

    final top = components.first
        .split('@')
        .first;

    if (top.isEmpty) {
      return;
    }

    final category = categories.firstWhereOrNull((e) => e.name == top) ??
        Category(name: top);
    if (!categories.contains(category)) {
      categories.add(category);
      categories.sort((a, b) => a.name.compareTo(b.name));
    }

    if (components.length > 1) {
      addHierarchy(components.sublist(1), category.children);
    }
  }

  static Set<Category> buildTree(List<String> components,
      List<Category> categories) {
    if (components.isEmpty) {
      return {};
    }

    final category = categories.firstWhereOrNull(
            (cat) => cat.name.toLowerCase() == components.first.toLowerCase());

    if (category == null) {
      return {};
    }

    final list = {category};

    if (components.length > 1) {
      list.addAll(buildTree(components.sublist(1), category.children));
    }

    return list;
  }

  static Future<dynamic> allRaw(BigCommerceClient client) {
    return client.send(
      method: HTTPMethod.get,
      path: 'catalog/categories',
      fetchAllPages: true,
    );
  }

  static Future<List<Category>> all(BigCommerceClient client) async {
    final List categories = await allRaw(client);

    return categories
        .map((e) => Category.fromBigCommereJson(e, categories.cast<Map>()))
        .toList();
  }
}
