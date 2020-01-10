import 'package:word_of_the_day/services/wotd_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Testing invalid parser data returns null", () {
    var data = "<div>random data<ol><li>item</li></ol></div>";
    var emptyData = "";

    expect(null, WotdParser.parseWotdData(data));
    expect(null, WotdParser.parseWotdData(emptyData));
  });

  test("test parser gets at least the word & definition", () {
    var html = """
<div class="wotd-item-wrapper" data-name="beaucoup-2020-01-09" data-url="https://www.dictionary.com/e/word-of-the-day/" data-color="#4C3698" data-title="beaucoup" data-date="Jan 09" data-is-ad-enabled="false" data-is-latest-post="true" data-page-title="Word of the Day - beaucoup | Dictionary.com">
  <div class="wotd-item">
     <div class="wotd-item-headword">
        <div class="wotd-item-headword__date">
           <div>Thursday, January 09, 2020</div>
        </div>
        <div class="wotd-item-headword__word">
           <h1 style="color: #4C3698">beaucoup</h1>
        </div>
        <div class="wotd-item-headword__pronunciation">
           <div>
              [ boh-<span class="bold">koo</span> ]
              <a href="https://static.sfdict.com/audio/B01/B0182300.mp3" class="wotd-item-headword__pronunciation-audio"></a>
           </div>
        </div>
        <div class="wotd-item-headword__pos-blocks">
           <div class="wotd-item-headword__pos">
              <p>
                 <span class="italic">
                 <span class="luna-pos">adjective</span>                  </span>
              </p>
              <p> <span class="luna-labset"><span class="luna-label italic">Informal</span>: <span class="luna-label italic">Usually Facetious</span></span>.</p>
              <p>many; numerous; much: <span class="luna-example italic">It's a hard job, but it pays beaucoup money.</span></p>
           </div>
        </div>
        <div class="wotd-item-headword__anchors">
           <ul>
              <li>
                 <a href="#wotd-origin-143705">Origin</a>
              </li>
              <li>
                 <a href="#wotd-examples-143705">examples</a>
              </li>
           </ul>
           <a href="https://www.dictionary.com/browse/beaucoup" class="wotd-item-headword__anchors-link" data-linkid="cks7jy">
           Look it up          </a>
          
        </div>
     </div>
  </div>
</div>
    """;

    var parsed = WotdParser.parseWotdData(html);

    expect(true, parsed != null);
    expect("beaucoup", parsed.word);
    expect("many; numerous; much: It's a hard job, but it pays beaucoup money.",
        parsed.definition);
  });
}
