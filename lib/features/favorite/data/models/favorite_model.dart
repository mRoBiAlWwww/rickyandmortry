import 'package:robi/features/favorite/domain/entities/favorite.dart';

class FavoriteFields {
  static const String tableName = 'favorites';
  static const String id = '_id';
  static const String name = 'name';
  static const String image = 'image';
  static const String createdTime = 'createdTime';
}

class FavoriteModel {
  FavoriteModel({
    required this.id,
    required this.name,
    required this.image,
    required this.createdTime,
  });

  final int id;
  final String name;
  final String image;
  final DateTime createdTime;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    id: json[FavoriteFields.id] as int,
    name: json[FavoriteFields.name] as String,
    image: json[FavoriteFields.image] as String,
    createdTime: DateTime.parse(json[FavoriteFields.createdTime] as String),
  );

  Map<String, dynamic> toJson() => {
    FavoriteFields.id: id,
    FavoriteFields.name: name,
    FavoriteFields.image: image,
    FavoriteFields.createdTime: createdTime.toIso8601String(),
  };

  Favorite toEntity() {
    return Favorite(id: id, name: name, image: image, createdTime: createdTime);
  }

  factory FavoriteModel.fromEntity(Favorite entity) {
    return FavoriteModel(
      id: entity.id,
      name: entity.name,
      image: entity.image,
      createdTime: entity.createdTime,
    );
  }
}
