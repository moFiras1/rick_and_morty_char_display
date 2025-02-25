import 'package:flutter/material.dart';
import 'package:rick_and_morty/modules/home/services/home_service.dart';
import '../model/character_model.dart';

class HomeController extends ChangeNotifier {
  final HomeService homeService = HomeService();
  final TextEditingController searchBarController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  CharactersDataModel? _charactersData;
  List<Results> charactersList = [];
  List<Results> searchedChar = [];
  int page = 1;
  int? totalPages;
  bool _isLoading = false;
  bool isResetPage = false;
  String? _errorMessage;

  CharactersDataModel? get charactersData => _charactersData;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  HomeController() {
    fetchCharacters();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(addScrollListener);
    });
  }

  Future<void> fetchCharacters() async {
    if (_isLoading || searchedChar.isNotEmpty) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _charactersData = await homeService.fetchCharData(page);
      if (_charactersData != null) {
        charactersList.addAll(_charactersData!.results ?? []);
        totalPages = _charactersData!.info?.pages ?? 1;
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchChar() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    print('search char called');
    try {
      searchedChar.clear();
      _charactersData = await homeService.searchChar(searchBarController.text);
      searchedChar.addAll(_charactersData?.results ?? []);
      if (_charactersData != null) {
        searchedChar.clear();
        searchedChar.addAll(_charactersData!.results ?? []);
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  void loadMore() {
    if (page < (totalPages ?? 1) && !_isLoading && isResetPage == false) {
      print('page  before $page');
      print('am called');
      page++;
      print('page  after add $page');

      fetchCharacters();
    }
  }
  void addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100 &&
          !_isLoading &&
          searchedChar.isEmpty &&
          !isResetPage) {
        loadMore();
      }
    });
  }


  void resetPages() {
    isResetPage = true;
    page = 1;
    charactersList.clear();
    print(charactersList);
    print('from reset page $page');
    fetchCharacters();
    isResetPage = false;
  }
}
