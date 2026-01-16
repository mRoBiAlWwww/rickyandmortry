import 'package:dio/dio.dart';
import 'package:robi/core/config/api/api_config.dart';
import 'package:robi/core/config/api/info.dart';
import 'package:robi/core/domain/models/character_model.dart';

abstract class SearchService {
  Future<List<CharacterModel>> getSearchCharacter(String keyword);
}

class SearchServiceImpl extends SearchService {
  static final Dio _dio = Dio();
  @override
  Future<List<CharacterModel>> getSearchCharacter(String keyword) async {
    String url =
        '${ApiConstants.baseURL}${ApiConstants.characterEndpoint}?name=$keyword';
    try {
      List<Map<String, dynamic>> characters = [];
      String? nextUrl = url;
      while (nextUrl != null) {
        var response = await _dio.get(nextUrl);
        try {
          var dataInfo = response.data["info"];
          Info info = Info.fromJson(dataInfo);
          nextUrl = info.next;
          characters.addAll(
            List<Map<String, dynamic>>.from(response.data["results"]),
          );
        } catch (e) {
          characters.addAll(List<Map<String, dynamic>>.from(response.data));
          nextUrl = null;
        }
      }

      return characters.map((e) => CharacterModel.fromJson(e)).toList();
    } on DioException {
      rethrow;
    } catch (e) {
      throw Exception("Error fetching details character: $e");
    }
  }
}
