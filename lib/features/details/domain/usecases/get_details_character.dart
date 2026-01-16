import 'package:dartz/dartz.dart';
import 'package:robi/features/details/domain/repositories/details_repository.dart';

class GetDetailsCharacterUseCase {
  final DetailsRepository repository;
  GetDetailsCharacterUseCase({required this.repository});

  Future<Either> call(int id) async {
    return await repository.getDetailsCharacter(id);
  }
}
