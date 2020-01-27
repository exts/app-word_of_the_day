import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_of_the_day/domain/wotd/wotd_provider.dart';
import 'package:word_of_the_day/screens/wotd_screen.dart';
import 'package:word_of_the_day/services/definition_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String apiUrl;

  MyApp([this.apiUrl = "https://www.dictionary.com/e/word-of-the-day"]);

  @override
  Widget build(BuildContext context) {
    var definitionService = DefinitionService(this.apiUrl);
    return MaterialApp(
      home: ChangeNotifierProvider<WotdProvider>(
        create: (_) => WotdProvider(definitionService),
        child: WotdScreen(),
      ),
    );
  }
}
