import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:robi/features/home/data/datasources/home_service.dart';
import 'package:robi/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeService service;
  HomeRepositoryImpl({required this.service});

  @override
  Future<Either> getAllCharacters() async {
    try {
      final result = await service.getAllCharacters();
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
