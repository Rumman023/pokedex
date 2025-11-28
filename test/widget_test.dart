// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:pokedex/app.dart';
import 'package:pokedex/core/constants/string_constants.dart';
import 'package:pokedex/injection_container.dart' as di;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await di.init();
  });

  tearDownAll(() async {
    await di.sl.reset(dispose: true);
  });

  testWidgets('App renders the Pokémon list page title', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Splash screen should appear first.
    expect(find.text(StringConstants.splashTagline), findsOneWidget);

    // Allow the splash animation and navigation to complete.
    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text(StringConstants.pokemonListTitle), findsOneWidget);
  });
}
