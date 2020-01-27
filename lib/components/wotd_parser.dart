import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:word_of_the_day/domain/wotd/wotd_model.dart';

class WotdParser {
  String html;
  Document document;

  WotdParser(this.html) {
    document = parse(this.html);
  }

  WotdModel build() {
    var element = document?.querySelector(".wotd-item-wrapper");
    if (element != null) {
      return _buildWotd(element);
    }
    return null;
  }

  WotdModel _buildWotd(Element elm) {
    var word = findWord(elm);
    var definition = findDefinition(elm);

    if (word.isEmpty || definition.isEmpty) {
      return null;
    }

    var date = findDate(elm);
    var audio = findAudioFile(elm);
    var nounce = findPronounciation(elm);
    var defLink = findDefinitionLink(elm);

    return WotdModel(date, word, nounce, definition, audio, defLink);
  }

  String findDate(Element elm) {
    if (!elm.attributes.containsKey("data-name")) {
      return null;
    }
    var elmList = elm.attributes["data-name"].split("-");
    if (elmList.length > 1) {
      elmList.removeAt(0);
    }
    return elmList.join("-");
  }

  String findWord(Element elm) {
    var wordElm = elm.querySelector(".wotd-item-headword__word h1");
    if (wordElm != null) {
      return wordElm.text.trim();
    }
    return null;
  }

  String findPronounciation(Element elm) {
    var nounceElm = elm.querySelector(".wotd-item-headword__pronunciation");
    if (nounceElm != null) {
      return nounceElm.text.trim();
    }
    return null;
  }

  String findDefinition(Element elm) {
    var defElm = elm.querySelector(".wotd-item-headword__pos p:last-child");
    if (defElm != null) {
      var def = defElm.text.trim();
      def = def.replaceAllMapped(RegExp(r'(\s)+'), (m) {
        return ' ';
      });
      return def;
    }
    return null;
  }

  String findAudioFile(Element elm) {
    var audioElm =
        elm.querySelector("a.wotd-item-headword__pronunciation-audio");
    if (audioElm != null) {
      return audioElm.attributes["href"];
    }
    return null;
  }

  String findDefinitionLink(Element elm) {
    var linkELm = elm.querySelector("a.wotd-item-headword__anchors-link");
    if (linkELm != null) {
      return linkELm.attributes["href"];
    }
    return null;
  }
}
