import 'package:app4_receitas/data/di/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipeService {
  final SupabaseClient _supabaseClient = getIt<SupabaseClient>();

  // Adicionar favoritos
  Future<void> addFavorite({
    required String userId,
    required String recipeId,
  }) async {
    await _supabaseClient.from('favorites').insert({
      'user_id': userId,
      'recipe_id': recipeId,
    });
  }

  // Remover favoritos
  Future<void> removeFavorite({
    required String userId,
    required String recipeId,
  }) async {
    await _supabaseClient
        .from('favorites')
        .delete()
        .eq('user_id', userId)
        .eq('recipe_id', recipeId);
  }

  Future<List<Map<String, dynamic>>> fetchRecipes() async {
    return await _supabaseClient
        .from('recipes')
        .select()
        .order('id', ascending: true);
  }

  Future<Map<String, dynamic>?> fetchRecipeById(String id) async {
    return await _supabaseClient.from('recipes').select().eq('id', id).single();
  }

  Future<List<Map<String, dynamic>>> fetchFavRecipes(String userId) async {
    return await _supabaseClient
        .from('favorites')
        .select(''' 
        recipes(
        id,
        name,
        ingredients,
        instructions,
        prep_time_minutes,
        cook_time_minutes,
        servings,
        difficulty,
        cuisine,
        calories_per_serving,
        tags,
        user_id,
        image,
        rating,
        review_count,
        meal_type
        )
        ''')
        .eq('user_id', userId);
  }
}
