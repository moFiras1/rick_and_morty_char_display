import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/modules/home/services/home_service.dart';
import '../model/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ChangeNotifier {
  final HomeService homeService = HomeService();
  final TextEditingController searchBarController = TextEditingController();
  List<String> statusList = ['Alive', 'Dead', 'Unknown'];
  List<String> genderList = ['Male', 'Female', 'Genderless', 'Unknown'];

  String? selectedStatus;
  String? selectedGender;

  CharactersDataModel? _charactersData;
  List<Results> charactersList = [];
  int page = 1;
  int? totalPages;
  bool _isLoading = false;
  bool isResetPage = false;
  String? _errorMessage;

  /// fav ////////////////////////////////bb
  List<Results> favCharList = [];

  CharactersDataModel? get charactersData => _charactersData;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;
  List<int> favCharIds = [];

  HomeController() {
    fetchCharacters();
    loadFav();
  }

  Future<void> fetchCharacters() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _charactersData = await homeService.fetchCharData(
        page,
        name: searchBarController.text,
        status: selectedStatus,
        gender: selectedGender,
      );
      charactersList.addAll(_charactersData?.results ?? []);
      totalPages = _charactersData?.info?.pages ?? 1;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (page < (page + 1 ?? 1) && isResetPage == false) {
      page++;
      await fetchCharacters();
    }
  }

  void resetPages() {
    isResetPage = true;
    page = 1;
    charactersList.clear();
    fetchCharacters();
    isResetPage = false;
  }

  void clearFilter() {
    selectedStatus = null;
    selectedGender = null;
    resetPages();
  }

  void favorite(int charID) {
    Results? character = charactersList.firstWhere(
      (char) => char.id == charID,
      orElse: () => Results(),
    );
    if (isFav(character.id!)) {
      favCharList.removeWhere((element) => element.id == character.id);
    } else {
      favCharList.add(character);
    }
    saveFav();
    notifyListeners();
  }

  bool isFav(int id) {
    bool exists = favCharList.any((element) => element.id == id);
    return exists;
  }
////save data
  Future<void> saveFav() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favCharJsonList =
    favCharList.map((char) => jsonEncode(char.toJson())).toList();

    await prefs.setStringList('favList', favCharJsonList);
  }

  Future<void> loadFav() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? favCharJsonList = prefs.getStringList('favList');

    if (favCharJsonList != null) {
      favCharList = favCharJsonList
          .map((charJson) => Results.fromJson(jsonDecode(charJson)))
          .toList();
    }
    notifyListeners();
  }


}
