import 'package:dio/dio.dart';
import 'package:robi/core/config/api/api_config.dart';
import 'package:robi/core/config/api/info.dart';
import 'package:robi/core/domain/models/character_model.dart';

abstract class HomeService {
  Future<List<CharacterModel>> getAllCharacters();
}

class HomeServiceImpl extends HomeService {
  static final Dio _dio = Dio();

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    String url = '${ApiConstants.baseURL}${ApiConstants.characterEndpoint}';
    try {
      List<Map<String, dynamic>> allEntities = [];
      String? nextUrl = url;
      while (nextUrl != null) {
        var response = await _dio.get(nextUrl);
        try {
          var dataInfo = response.data["info"];
          Info info = Info.fromJson(dataInfo);
          nextUrl = info.next;
          allEntities.addAll(
            List<Map<String, dynamic>>.from(response.data["results"]),
          );
        } catch (e) {
          allEntities.addAll(List<Map<String, dynamic>>.from(response.data));
          nextUrl = null;
        }
      }

      return allEntities.map((e) => CharacterModel.fromJson(e)).toList();
    } on DioException {
      rethrow;
    } catch (e) {
      throw Exception("Error fetching details characters: $e");
    }
  }
}
