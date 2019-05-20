import 'package:test_api/test_api.dart';
import 'package:word_of_the_day/services/wotd_parser.dart';

void main() {
  test("Testing invalid parser data returns null", () {
    var data = "<div>random data<ol><li>item</li></ol></div>";
    var emptyData = "";

    expect(null, WotdParser.parseWotdData(data));
    expect(null, WotdParser.parseWotdData(emptyData));
  });

  test("test parser gets at least the word & definition", () {
    var item =
        "<div class='wotd-item__definition'><h1>Example Title</h1><div class='wotd-item__definition__text'>Example Description</div></div>";
    var html = "<ol><li class='wotd-item'>$item</li></ol>";
    var parsed = WotdParser.parseWotdData(html);

    expect("Example Title", parsed.word);
    expect("Example Description", parsed.definition);
  });
}
