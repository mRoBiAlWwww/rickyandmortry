import 'package:dartz/dartz.dart';
import '../repositories/favorite_repository.dart';

class RemoveFavoriteUseCase {
  final FavoriteRepository repository;

  RemoveFavoriteUseCase({required this.repository});

  Future<Either> call(int id) async {
    return await repository.removeFavorite(id);
  }
}
