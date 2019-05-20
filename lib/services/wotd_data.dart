import 'dart:async';
import 'wotd_parser.dart';
import 'package:http/http.dart' as http;
import 'package:word_of_the_day/model/wotd_model.dart';

class WotdData {
  final String websiteUrl;

  WotdData({this.websiteUrl});

  Future<WotdModel> loadWordOfTheDay() async {
    var response = await http.get(websiteUrl);
    if (response.statusCode == 200) {
      return WotdParser.parseWotdData(response.body);
    }
    return null;
  }
}
