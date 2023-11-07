import 'dart:convert';

import 'package:big_commerce_sdk/big_commerce_sdk.dart';
import 'package:json_annotation/json_annotation.dart';

part 'custom_template_association.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class CustomTemplateAssociation {
  int? id;
  final int channelId;
  final EntityType entityType;
  final int entityId;
  final String fileName;
  final bool? isValid;
  final String? dateCreated;
  final String? dateModified;

  CustomTemplateAssociation({
    this.id,
    required this.channelId,
    required this.entityType,
    required this.entityId,
    required this.fileName,
    this.isValid,
    this.dateCreated,
    this.dateModified,
  });

  factory CustomTemplateAssociation.fromJson(Map<String, dynamic> json) =>
      _$CustomTemplateAssociationFromJson(json);

  Map<String, dynamic> toJson() => _$CustomTemplateAssociationToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  static Future<List<CustomTemplateAssociation>> all(
      BigCommerceClient client) async {
    final result = await client.send(
      method: HTTPMethod.get,
      path: 'storefront/custom-template-associations',
      fetchAllPages: true,
    );

    final data = (result is Map) ? result['data'] : result;
    return data
        .map<CustomTemplateAssociation>(
            (e) => CustomTemplateAssociation.fromJson(e))
        .toList();
  }

  Future<void> upsert(BigCommerceClient client) {
    return client.send(
      method: HTTPMethod.put,
      path: 'storefront/custom-template-associations',
      body: [toJson()],
    );
  }
}

enum EntityType {
  product,
  category,
  brand,
  page,
}
