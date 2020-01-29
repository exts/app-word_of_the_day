// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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

    testWidgets("test empty response view", (WidgetTester tester) async {
      Future<WotdModel> test;

      when(definitionService.loadWordOfTheDay()).thenReturn(test);

      await tester.pumpWidget(MyApp(definitionService));
      await tester.pump();

      var w = find.byType(CircularProgressIndicator);
      expect(w, findsOneWidget);
//      w.expect(find.text('Invalid Word'), findsOneWidget);
//      expect(find.text('Word of the Day!'), findsOneWidget);
    });
  });

//  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
////    // Build our app and trigger a frame.
////    await tester.pumpWidget(MyApp());
////
////    // Verify that our counter starts at 0.
////    expect(find.text('0'), findsOneWidget);
////    expect(find.text('1'), findsNothing);
////
////    // Tap the '+' icon and trigger a frame.
////    await tester.tap(find.byIcon(Icons.add));
////    await tester.pump();
////
////    // Verify that our counter has incremented.
////    expect(find.text('0'), findsNothing);
////    expect(find.text('1'), findsOneWidget);
//  });
}
