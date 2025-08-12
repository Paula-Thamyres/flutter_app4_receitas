import 'package:app4_receitas/data/di/service_locator.dart';
import 'package:app4_receitas/data/models/recipe.dart';
import 'package:app4_receitas/data/services/recipe_service.dart';

class RecipeRepository {
  final _service = getIt<RecipeService>();

  Future<List<Recipe>> getRecipes() async {
    try {
      final rawData = await _service.fetchRecipes();
      return rawData.map((data) => Recipe.fromJson(data)).toList();
    } catch (e) {
      throw Exception('falha ao carregar receitas:  ${e.toString()}');
    }
  }

  Future<Recipe?> getRecipeById(String id) async {
    final rawData = await _service.fetchRecipeById(id);
    return rawData != null ? Recipe.fromJson(rawData) : null;
  }

  Future<List<Recipe>> getFavRecipes(String userId) async {
    final rawData = await _service.fetchFavRecipes(userId);
    return rawData
        .where((data) => data['recipes'] != null)
        .map((data) => Recipe.fromJson(data['recipes'] as Map<String, dynamic>))
        .toList();
  }

  Future<void> addFavorite(String userId, String recipeId) async {
    try {
      await _service.addFavorite(userId: userId, recipeId: recipeId);
    } catch (e) {
      throw Exception('falha ao adicionar favorito ${e.toString()}');
    }
  }

  Future<void> removeFavorite(String userId, String recipeId) async {
    try {
      await _service.removeFavorite(userId: userId, recipeId: recipeId);
    } catch (e) {
      throw Exception('falha ao remover favorito ${e.toString()}');
    }
  }
}
