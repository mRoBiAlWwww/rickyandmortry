class Favorite {
  final int id;
  final String name;
  final String image;
  final DateTime createdTime;

  const Favorite({
    required this.id,
    required this.name,
    required this.image,
    required this.createdTime,
  });

  Favorite copy({
    int? id,
    String? name,
    String? image,
    DateTime? createdTime,
  }) => Favorite(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
    createdTime: createdTime ?? this.createdTime,
  );
}
