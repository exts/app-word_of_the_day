import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:word_of_the_day/components/wotd_parser.dart';

void main() {
  group("test wotd parser", () {
    var html = fixture("definition.html");
    var wotdParser = WotdParser(html);
    var element = wotdParser.document?.querySelector(".wotd-item-wrapper");

    test("definition fixture loads", () {
      expect(html, isNotEmpty);
    });

    test("definition wrapper exists", () {
      expect(element, isNotNull);
    });

    test("definition word matches", () {
      expect(wotdParser.findWord(element), "mizzle");
    });

    test("definition description matches", () {
      expect(wotdParser.findDefinition(element),
          "to rain in fine drops; drizzle; mist.");
    });

    test("definition link matches", () {
      expect(wotdParser.findDefinitionLink(element),
          "https://www.dictionary.com/browse/mizzle");
    });

    test("definition audio matches", () {
      var mp3 = wotdParser.findAudioFile(element);
      expect(mp3.contains(".mp3"), isTrue);
      expect(mp3.contains("static.sfdict.com"), isTrue);
    });

    test("definition optional pronunciation matches", () {
      expect(wotdParser.findPronounciation(element), "[ miz-uhl ]");
    });

    test("definition optional date matches", () {
      expect(wotdParser.findDate(element), "2020-01-30");
    });
  });
}

String fixture(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/test/fixtures/$name').readAsStringSync();
}
