import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:robi/features/search/data/datasources/search_service.dart';
import 'package:robi/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchService service;
  SearchRepositoryImpl({required this.service});

  @override
  Future<Either> getSearchCharacter(String keyword) async {
    try {
      final result = await service.getSearchCharacter(keyword);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      String errorMessage = "";

      if (e is DioException) {
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.receiveTimeout:
            errorMessage = "Koneksi habis waktu. Cek internet Anda";
            break;
          case DioExceptionType.badResponse:
            errorMessage = "Data tidak ditemukan atau Server Error (404/500)";
            break;
          case DioExceptionType.connectionError:
            errorMessage = "Tidak ada koneksi internet";
            break;
          default:
            errorMessage = "Terjadi kesalahan jaringan: ${e.message}";
        }
      } else {
        errorMessage = e.toString().replaceFirst("Exception: ", "");
      }

      return Left(errorMessage);
    }
  }
}
