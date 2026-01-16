import 'package:dartz/dartz.dart';
import 'package:robi/features/search/domain/repositories/search_repository.dart';

class GetSearchCharactersUseCase {
  final SearchRepository repository;
  GetSearchCharactersUseCase({required this.repository});

  Future<Either> call(String keyword) async {
    return await repository.getSearchCharacter(keyword);
  }
}
