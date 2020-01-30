// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:word_of_the_day/domain/wotd/widgets/wotd_default_view.dart';
import 'package:word_of_the_day/domain/wotd/wotd_model.dart';
import 'package:word_of_the_day/main.dart';
import 'package:word_of_the_day/services/definition_service.dart';

class DefinitionServiceMock extends Mock implements DefinitionService {}

void main() {
  group("group tests using mocked definition service", () {
    var definitionService = DefinitionServiceMock();

    test("test empty definition service is null", () async {
      when(definitionService.loadWordOfTheDay()).thenReturn(null);

      expect(await definitionService.loadWordOfTheDay(), null);
    });

    testWidgets("test correct value when you couldn't load the data",
        (WidgetTester tester) async {
      when(definitionService.loadWordOfTheDay()).thenAnswer((_) => null);

      await tester.pumpWidget(MyApp(definitionService));
      await tester.pump();

      expect(find.text('Invalid Word of the Day'), findsOneWidget);
    });

    testWidgets("test return of wotd view w/ word & definition set",
        (WidgetTester tester) async {
      var wotd = Future.value(
          WotdModel(word: "example", definition: "example definition"));

      when(definitionService.loadWordOfTheDay()).thenAnswer((_) => wotd);

      await tester.pumpWidget(MyApp(definitionService));
      await tester.pump();

      expect(find.byType(WotdDefaultView), findsOneWidget);
      expect(find.text("example"), findsOneWidget);
      expect(find.text("example definition"), findsOneWidget);
    });
  });
}
