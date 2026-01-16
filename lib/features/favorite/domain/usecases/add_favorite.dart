import 'package:dartz/dartz.dart';
import '../repositories/favorite_repository.dart';
import '../entities/favorite.dart';

class AddFavoriteUseCase {
  final FavoriteRepository repository;

  AddFavoriteUseCase({required this.repository});

  Future<Either> call(Favorite favorite) async {
    return await repository.addFavorite(favorite);
  }
}
