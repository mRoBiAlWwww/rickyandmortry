import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either> getSearchCharacter(String keyword);
}
