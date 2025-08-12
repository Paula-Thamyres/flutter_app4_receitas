import 'package:app4_receitas/data/services/recipe_service.dart';
import 'package:app4_receitas/ui/favorites/fav_recipes_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app4_receitas/data/repositories/recipe_repository.dart';
import 'package:app4_receitas/ui/recipes/recipes_viewmodel.dart';
import 'package:app4_receitas/ui/recipedetail/recipe_detail_viewmodel.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Supabase client
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // Services
  getIt.registerLazySingleton<RecipeService>(() => RecipeService());

  // Repositories
  getIt.registerLazySingleton<RecipeRepository>(() => RecipeRepository());

  // ViewModels
  getIt.registerLazySingleton<RecipesViewmodel>(() => RecipesViewmodel());
  getIt.registerLazySingleton<RecipeDetailViewModel>(
    () => RecipeDetailViewModel(),
  );

  // Favoritos (ESSENCIAL)
  getIt.registerLazySingleton<FavRecipesViewModel>(() => FavRecipesViewModel());
}
