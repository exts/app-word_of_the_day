import 'package:flutter_test/flutter_test.dart';
import 'package:word_of_the_day/services/wotd_data.dart';

void main() {
  test("Testing api data loads correctly", () async {
    var data =
        WotdData(websiteUrl: "https://www.dictionary.com/e/word-of-the-day");
    var results = await data.loadWordOfTheDay();

    expect(true, results != null);
  });
}
