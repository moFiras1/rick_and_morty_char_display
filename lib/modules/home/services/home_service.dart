import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/modules/home/model/character_model.dart';

class HomeService {
  final String baseUrl = 'https://rickandmortyapi.com/api/character';

  Future<CharactersDataModel> fetchCharData(int? page,
      {String? name,
      String? status,
      String? species,
      String? type,
      String? gender}) async {
    final Map<String, dynamic> queryParams = {
      'page': page.toString(),
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
    };
    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return CharactersDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
