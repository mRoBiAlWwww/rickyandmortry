import 'package:dartz/dartz.dart';
import 'package:robi/features/home/domain/repositories/home_repository.dart';

class GetAllCharactersUseCase {
  final HomeRepository repository;
  GetAllCharactersUseCase({required this.repository});

  Future<Either> call() async {
    return await repository.getAllCharacters();
  }
}
