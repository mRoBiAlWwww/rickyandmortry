import 'package:robi/features/favorite/data/models/favorite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB('favorites.db');
    return _database!;
  }

  static Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE ${FavoriteFields.tableName} ( 
        ${FavoriteFields.id} $idType, 
        ${FavoriteFields.name} $textType,
        ${FavoriteFields.image} $textType,
        ${FavoriteFields.createdTime} $textType
      )
    ''');
  }
}
