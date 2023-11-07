class Brand {
  final int id;
  final String name;

  const Brand({
    required this.id,
    required this.name,
  });

  Brand.fromJson(Map json)
      : id = json['id'],
        name = json['name'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Brand &&
          runtimeType == other.runtimeType &&
          name.trim().toLowerCase() == other.name.trim().toLowerCase();

  @override
  int get hashCode => name.hashCode;
}
