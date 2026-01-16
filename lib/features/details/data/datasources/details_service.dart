import 'package:dio/dio.dart';
import 'package:robi/core/config/api/api_config.dart';
import 'package:robi/core/config/api/info.dart';
import 'package:robi/core/domain/models/character_model.dart';

abstract class DetailsService {
  Future<List<CharacterModel>> getDetailsCharacter(List<int> ids);
}

class DetailsServiceImpl extends DetailsService {
  static final Dio _dio = Dio();
  @override
  Future<List<CharacterModel>> getDetailsCharacter(List<int> ids) async {
    String url =
        '${ApiConstants.baseURL}${ApiConstants.characterEndpoint}/$ids';
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
