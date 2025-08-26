import 'package:app4_receitas/ui/recipes/recipes_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
// import 'package:integration_test/integration_test.dart';
import 'package:app4_receitas/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Auth E2E Test', () {
    testWidgets('deve realizar um cadastro', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final emailField = find.byKey(ValueKey('emailField'));
      final passwordField = find.byKey(ValueKey('passwordField'));
      final submitButton = find.byKey(ValueKey('submitButton'));

      // colocar os dados no supabase
      await tester.enterText(emailField, 'paula.arthamys@gmail.com');
      await tester.enterText(passwordField, 'Pr220917');
      await tester.pump();

      await tester.ensureVisible(submitButton);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.byType(RecipesView), findsOneWidget);
    });
  });
}
