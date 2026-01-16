import 'package:dartz/dartz.dart';
import 'package:robi/features/favorite/domain/entities/favorite.dart';

abstract class FavoriteRepository {
  Future<Either> addFavorite(Favorite favorite);
  Future<Either> getFavorites();
  Future<Either> removeFavorite(int id);
}
