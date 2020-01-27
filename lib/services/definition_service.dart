import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:word_of_the_day/components/wotd_parser.dart';
import 'package:word_of_the_day/domain/wotd/wotd_model.dart';

class DefinitionService {
  final String websiteUrl;

  DefinitionService(this.websiteUrl);

  Future<WotdModel> loadWordOfTheDay() async {
    var response = await http.get(websiteUrl);
    if (response.statusCode == 200) {
      return WotdParser(response.body).build();
    }
    return null;
  }
}
