import 'package:app4_receitas/data/di/service_locator.dart';
import 'package:get/get.dart';
import 'package:app4_receitas/data/models/recipe.dart';
import 'package:app4_receitas/data/repositories/recipe_repository.dart';
import 'package:app4_receitas/ui/favorites/fav_recipes_viewmodel.dart';

class RecipeDetailViewModel extends GetxController {
  final _repo = getIt<RecipeRepository>();

  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _isFavorite = false.obs;

  bool _busy = false;
  Recipe? recipe;

  bool get isloading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isFavorite => _isFavorite.value;

  Future<void> loadRecipe(String id) async {
    _isLoading.value = true;
    _errorMessage.value = '';
    try {
      recipe = await _repo.getRecipeById(id);
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> checkIfFavorite(String userId) async {
    if (recipe == null) return;
    try {
      final favs = await _repo.getFavRecipes(userId);
      _isFavorite.value = favs.any((r) => r.id == recipe!.id);
    } catch (_) {
      _isFavorite.value = false;
    }
  }

  Future<void> toggleFavorite(String userId) async {
    if (recipe == null || _busy) return;
    _busy = true;

    final favVm = getIt<FavRecipesViewModel>();
    await favVm.init(userId);

    try {
      if (_isFavorite.value) {
        await _repo.removeFavorite(userId, recipe!.id);
        favVm.removeLocal(recipe!.id);
        _isFavorite.value = false;
      } else {
        await _repo.addFavorite(userId, recipe!.id);
        favVm.addLocal(recipe!);
        _isFavorite.value = true;
      }
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _busy = false;
    }
  }
}
