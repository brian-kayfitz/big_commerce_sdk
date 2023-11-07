import 'dart:io';

import 'package:big_commerce_sdk/big_commerce_sdk.dart';
import 'package:http/http.dart';

class Image {
  /// The unique numeric ID of the image; increments sequentially.
  final int? id;

  /// Must be a fully qualified URL path, including protocol. Limit of 8MB per file.
  final Uri imageUrl;

  final bool isThumbnail;

  final String? description;

  bool _validated = false;
  bool get valid => _validated;

  Image({
    this.id,
    required this.imageUrl,
    required this.isThumbnail,
    this.description,
  });

  static Image? fromUrl(
    String? url, {
    String? description,
  }) {
    if (url == null || url.isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }

    return Image(
      imageUrl: uri,
      isThumbnail: false,
      description: description,
    );
  }

  Image.fromJson(Map json)
      : id = json['id'],
        imageUrl = Uri.parse(json['image_url']),
        isThumbnail = json['is_thumbnail'] ?? false,
        description = json['description'];

  Map toJson() => {
        'image_url': imageUrl.toString(),
        'is_thumbnail': isThumbnail,
        if (description != null) 'description': description
      };

  Future<void> validate() async {
    if (_validated) {
      return;
    }

    try {
      final results = await head(imageUrl);
      _validated = results.statusCode == HttpStatus.ok;
    } catch (e) {
      _validated = false;
      return;
    }
  }

  Future<void> create({
    required Product product,
    required BigCommerceClient client,
  }) async {
    assert(id == null);
    assert(product.id != null);

    await validate();
    if (!_validated) {
      throw Exception('Invalid image url: $imageUrl');
    }

    await client.send(
      method: HTTPMethod.post,
      path: 'catalog/products/${product.id}/images',
      body: toJson(),
    );
  }

  @override
  String toString() {
    return 'Image{id: $id, imageUrl: $imageUrl, isThumbnail: $isThumbnail, description: $description, _validated: $_validated}';
  }
}
