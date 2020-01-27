import 'package:flutter/material.dart';
import 'package:word_of_the_day/domain/wotd/wotd_model.dart';
import 'package:word_of_the_day/services/definition_service.dart';

class WotdProvider with ChangeNotifier {
  DefinitionService definitionService;

  WotdProvider(this.definitionService);

  Future<WotdModel> loadWordOfTheDay() => definitionService.loadWordOfTheDay();

  void reload() => notifyListeners();
}
