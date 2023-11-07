import 'dart:convert';

import 'package:big_commerce_sdk/big_commerce_sdk.dart';
import 'package:collection/collection.dart';
import 'package:email_validator/email_validator.dart';

class Review {
  Review({
    required this.productId,
    required String title,
    required this.dateReviewed,
    String? text,
    this.status,
    this.rating,
    String? name,
    String? email,
  })  : title = title.trim(),
        text = text?.trim(),
        name = name?.trim(),
        email = email?.trim(),
        assert((rating ?? 0) >= 0 && (rating ?? 0) <= 5),
        assert(name != null && name.isNotEmpty ? name.length <= 255 : true);

  Review.fromJson(Map json)
      : productId = json['product_id'],
        title = json['title'],
        dateReviewed = DateTime.parse(json['date_reviewed']),
        text = json['text'],
        status = ReviewStatus.values
            .firstWhereOrNull((e) => e.name == json['status']),
        rating = json['rating'],
        name = json['name'],
        email = json['email'];

  final int productId;
  final String title;
  final String? text;
  final ReviewStatus? status;
  final int? rating;
  final String? name;
  final String? email;
  final DateTime dateReviewed;

  Future<void> create(BigCommerceClient client) {
    final path = 'catalog/products/$productId/reviews';

    final body = toJson();
    body.remove('product_id');

    if (email != null && !EmailValidator.validate(email!)) {
      body.remove('email');
    }

    return client.send(
      method: HTTPMethod.post,
      path: path,
      body: body,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'title': title,
      'date_reviewed': dateReviewed.toIso8601String(),
      if (text != null) 'text': text,
      if (status != null) 'status': status?.name,
      if (rating != null) 'rating': rating,
      if (name?.isNotEmpty ?? false) 'name': name,
      if (email?.isNotEmpty ?? false) 'email': email,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

enum ReviewStatus { approved, disapproved, pending }
