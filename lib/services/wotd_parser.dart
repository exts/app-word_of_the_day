import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:word_of_the_day/model/wotd_model.dart';

class WotdParser {
  static WotdModel parseWotdData(String data) {
    try {
      var doc = parse(data);
      var element = doc.querySelector("li.wotd-item");
      if (element != null) {
        return _getValidWotd(element);
      }
    } catch (e) {}
    return null;
  }

  static WotdModel _getValidWotd(Element element) {
    var date = getDate(element) ?? "";
    var word = getWord(element) ?? "";
    var audioFile = getAudioFile(element) ?? "";
    var definition = getDefinition(element) ?? "";
    var nounciation = getPronounciation(element) ?? "";
    var definitionLink = getDefinitionLink(element) ?? "";

    if (word.isEmpty || definition.isEmpty) {
      return null;
    }

    return WotdModel(
        date, word, nounciation, definition, audioFile, definitionLink);
  }

  static String getDate(Element elm) {
    if (!elm.attributes.containsKey("data-name")) {
      return null;
    }
    var elmList = elm.attributes["data-name"].split("-");
    if (elmList.length > 1) {
      elmList.removeAt(0);
    }
    return elmList.join("-");
  }

  static String getWord(Element elm) {
    var wordElm = elm.querySelector(".wotd-item__definition h1");
    if (wordElm != null) {
      return wordElm.text.trim();
    }
    return null;
  }

  static String getPronounciation(Element elm) {
    var nounceElm = elm.querySelector(
        ".wotd-item__definition .wotd-item__definition__pronunciation");
    if (nounceElm != null) {
      return nounceElm.text.trim();
    }
    return null;
  }

  static String getDefinition(Element elm) {
    var defElm = elm
        .querySelector(".wotd-item__definition .wotd-item__definition__text");
    if (defElm != null) {
      return defElm.text.trim();
    }
    return null;
  }

  static String getAudioFile(Element elm) {
    var audioElm = elm.querySelector("a.wotd-item__definition__listen");
    if (audioElm != null) {
      return audioElm.attributes["href"];
    }
    return null;
  }

  static String getDefinitionLink(Element elm) {
    var linkELm = elm.querySelector(".wotd-item__definition a.wotd-item__link");
    if (linkELm != null) {
      return linkELm.attributes["href"];
    }
    return null;
  }
}
