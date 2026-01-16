import 'package:dartz/dartz.dart';

abstract class DetailsRepository {
  Future<Either> getDetailsCharacter(int id);
}
