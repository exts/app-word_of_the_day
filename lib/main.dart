import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_of_the_day/domain/wotd/wotd_provider.dart';
import 'package:word_of_the_day/screens/wotd_screen.dart';
import 'package:word_of_the_day/services/definition_service.dart';

final apiUrl = "https://www.dictionary.com/e/word-of-the-day";
final definitionService = DefinitionService(apiUrl);

void main() {
  runApp(MyApp(definitionService));
}

class MyApp extends StatelessWidget {
  final DefinitionService definitionService;

  MyApp(this.definitionService);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<WotdProvider>(
        create: (_) => WotdProvider(definitionService),
        child: WotdScreen(),
      ),
    );
  }
}
