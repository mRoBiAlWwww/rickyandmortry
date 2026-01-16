import 'package:dartz/dartz.dart';
import 'package:robi/features/favorite/data/datasources/favorite_service.dart';
import 'package:robi/features/favorite/data/models/favorite_model.dart';
import 'package:robi/features/favorite/domain/entities/favorite.dart';
import 'package:robi/features/favorite/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteService service;

  FavoriteRepositoryImpl({required this.service});

  @override
  Future<Either> addFavorite(Favorite favorite) async {
    try {
      // Ubah entity ke model
      final favoriteModel = FavoriteModel.fromEntity(favorite);

      // Simpan ke sqlite
      final result = await service.create(favoriteModel);

      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getFavorites() async {
    try {
      final resultModels = await service.readAll();

      final resultEntities = resultModels
          .map((model) => model.toEntity())
          .toList();

      return Right(resultEntities);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> removeFavorite(int id) async {
    try {
      final result = await service.delete(id);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
