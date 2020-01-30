import 'package:flutter/material.dart';

class WotdModel with ChangeNotifier {
  String date;
  String word;
  String pronounced;
  String definition;
  String audiofile;
  String weblink;

  WotdModel(
      {this.date,
      this.word,
      this.pronounced,
      this.definition,
      this.audiofile,
      this.weblink});

  void updateFrom(WotdModel model) {
    this.date = model.date;
    this.word = model.word;
    this.weblink = model.weblink;
    this.audiofile = model.audiofile;
    this.pronounced = model.pronounced;
    this.definition = model.definition;
  }

  void reload() {
    notifyListeners();
  }
}
