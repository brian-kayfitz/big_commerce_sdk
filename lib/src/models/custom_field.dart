class CustomField {
  int? id;

  /// The name of the field, shown on the storefront, orders, etc. Required for /POST
  /// >= 1 characters<= 250 characters
  final String name;

  /// The name of the field, shown on the storefront, orders, etc. Required for /POST
  /// >= 1 characters<= 250 characters
  final String value;

  CustomField({
    this.id,
    required this.name,
    required this.value,
  });

  CustomField.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        value = json['value'];

  Map toJson() => {
        if (id != null) 'id': id,
        'name': name,
        'value': value,
      };

  @override
  String toString() {
    return 'CustomField{id: $id, name: $name, value: $value}';
  }

  static List<CustomField> parse(
    String fields, {
    String fieldDelimiter = ';',
    String keyValueDelimited = '=',
  }) {
    return fields.split(fieldDelimiter).map((field) {
      final components = field.split(keyValueDelimited);
      return CustomField(name: components.first, value: components.last);
    }).toList();
  }

  CustomField copyWith({String? value}) => CustomField(
        id: id,
        name: name,
        value: value ?? this.value,
      );
}
