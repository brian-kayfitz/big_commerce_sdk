// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_template_association.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomTemplateAssociation _$CustomTemplateAssociationFromJson(
        Map<String, dynamic> json) =>
    CustomTemplateAssociation(
      id: json['id'] as int?,
      channelId: json['channel_id'] as int,
      entityType: $enumDecode(_$EntityTypeEnumMap, json['entity_type']),
      entityId: json['entity_id'] as int,
      fileName: json['file_name'] as String,
      isValid: json['is_valid'] as bool?,
      dateCreated: json['date_created'] as String?,
      dateModified: json['date_modified'] as String?,
    );

Map<String, dynamic> _$CustomTemplateAssociationToJson(
    CustomTemplateAssociation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['channel_id'] = instance.channelId;
  val['entity_type'] = _$EntityTypeEnumMap[instance.entityType]!;
  val['entity_id'] = instance.entityId;
  val['file_name'] = instance.fileName;
  writeNotNull('is_valid', instance.isValid);
  writeNotNull('date_created', instance.dateCreated);
  writeNotNull('date_modified', instance.dateModified);
  return val;
}

const _$EntityTypeEnumMap = {
  EntityType.product: 'product',
  EntityType.category: 'category',
  EntityType.brand: 'brand',
  EntityType.page: 'page',
};
