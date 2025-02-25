import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/char_details_model.dart';

class CharDetailsService {

  Future<CharDetailsModel> fetchDetailsChar() async {
    final charDetails = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character'));
    if (charDetails.statusCode == 200) {
      return CharDetailsModel.fromJson(
          jsonDecode(charDetails.body) as Map<String, dynamic>);
    } else {
      return throw Exception('Failed to load  character');
    }
  }



}
