import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:legendary_pokedex/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('List all Pokemons by default', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ListTile, 'Bulbasaur'), findsOneWidget);
  });

  testWidgets('List only legendary Pokemons when FAB is tapped', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ListTile, 'Articuno'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Bulbasaur'), findsNothing);
  });
}
