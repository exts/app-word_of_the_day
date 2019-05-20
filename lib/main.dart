import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_of_the_day/model/wotd_model.dart';
import 'package:word_of_the_day/presenter/wotd_presenter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<WotdModel>(
        builder: (_) => WotdModel(),
        child: WotdPresenter(),
      ),
    );
  }
}
