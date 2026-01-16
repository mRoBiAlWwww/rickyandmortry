import 'package:robi/core/database/app_database.dart';
import 'package:robi/features/favorite/data/models/favorite_model.dart';

abstract class FavoriteService {
  Future<String> create(FavoriteModel note);
  Future<List<FavoriteModel>> readAll();
  Future<String> delete(int id);
}

class FavoriteServiceImpl implements FavoriteService {
  @override
  Future<String> create(FavoriteModel model) async {
    final db = await AppDatabase.database;
    await db.insert(FavoriteFields.tableName, model.toJson());

    return "Berhasil ditambahkan ke Favorite";
  }

  @override
  Future<List<FavoriteModel>> readAll() async {
    const orderBy = '${FavoriteFields.createdTime} ASC';
    final db = await AppDatabase.database;
    final result = await db.query(FavoriteFields.tableName, orderBy: orderBy);

    return result.map((json) => FavoriteModel.fromJson(json)).toList();
  }

  @override
  Future<String> delete(int id) async {
    final db = await AppDatabase.database;
    await db.delete(
      FavoriteFields.tableName,
      where: '${FavoriteFields.id} = ?',
      whereArgs: [id],
    );
    return "Berhasil dihapus dari Favorite";
  }
}
