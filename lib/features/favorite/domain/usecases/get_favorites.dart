import 'package:dartz/dartz.dart';
import 'package:robi/features/favorite/domain/repositories/favorite_repository.dart';

class GetFavoritesUseCase {
  final FavoriteRepository repository;

  GetFavoritesUseCase({required this.repository});

  Future<Either> call() async {
    return await repository.getFavorites();
  }
}
