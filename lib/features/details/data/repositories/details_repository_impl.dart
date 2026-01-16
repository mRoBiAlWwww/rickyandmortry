import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:robi/features/details/data/datasources/details_service.dart';
import 'package:robi/features/details/domain/repositories/details_repository.dart';

class DetailsRepositoryImpl extends DetailsRepository {
  final DetailsService service;
  DetailsRepositoryImpl({required this.service});

  @override
  Future<Either> getDetailsCharacter(int id) async {
    try {
      final result = await service.getDetailsCharacter([id]);
      return Right(result.first.toEntity());
    } catch (e) {
      String errorMessage = "";

      if (e is DioException) {
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.receiveTimeout:
            errorMessage = "Koneksi habis waktu. Cek internet Anda";
            break;
          case DioExceptionType.badResponse:
            errorMessage = "Data tidak ditemukan";
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
