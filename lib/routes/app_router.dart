import 'package:app4_receitas/ui/base_screen.dart';
import 'package:app4_receitas/ui/favorites/fav_recipes_view.dart';
import 'package:app4_receitas/ui/recipedetail/recipe_detail_view.dart';
import 'package:app4_receitas/ui/recipes/recipes_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
          builder: (context, state, child) => BaseScreen(child: child),
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const RecipesView(),
            ),
            GoRoute(
              path: '/recipe/:id',
              builder: (context, state) =>
                  RecipeDetailView(id: state.pathParameters['id']!),
            ),
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavRecipesView(
                userId: 'e9d443fa-ab43-45d7-a52b-44f0300d5ea9',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
