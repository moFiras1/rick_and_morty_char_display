import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/modules/home/model/character_model.dart';

class HomeService {

  Future<CharactersDataModel> fetchCharData(int? page) async {
      final charData =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'));
    if(charData.statusCode ==200){
      return CharactersDataModel.fromJson(jsonDecode(charData.body) as Map<String,dynamic>);

    }
    else{
      return throw Exception('Failed to load  character');
    }
  }

  Future<CharactersDataModel> searchChar(String searchedChar) async {
      final filteredChar =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character/?name=$searchedChar'));
    if(filteredChar.statusCode ==200){
      return CharactersDataModel.fromJson(jsonDecode(filteredChar.body) as Map<String,dynamic>);

    }
    else{
      return throw Exception('Failed to load  character');
    }
  }

}
