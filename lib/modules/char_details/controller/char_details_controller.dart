import 'package:flutter/material.dart';
import 'package:rick_and_morty/modules/char_details/service/char_details_service.dart';

import '../model/char_details_model.dart';

class CharDetailsController with ChangeNotifier {
  final CharDetailsService myService = CharDetailsService();
  CharDetailsModel? _charDetailsModel;
  bool _isLoading = false;
  String? _errorMessage;

  CharDetailsModel? get charDetails => _charDetailsModel;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchCharDetails( ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _charDetailsModel = await myService.fetchDetailsChar();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners(); // Notify UI to update data
  }
}
