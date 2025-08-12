import 'package:app4_receitas/data/di/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:app4_receitas/data/models/recipe.dart';
import 'package:app4_receitas/data/repositories/recipe_repository.dart';

class FavRecipesViewModel extends ChangeNotifier {
  final _repo = getIt<RecipeRepository>();

  final List<Recipe> _items = [];
  List<Recipe> get items => List.unmodifiable(_items);

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  late String _userId;

  Future<void> init(String userId, {bool forceReload = false}) async {
    _userId = userId;
    if (_items.isNotEmpty && !forceReload) return;
    await load();
  }

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await _repo.getFavRecipes(_userId);
      _items
        ..clear()
        ..addAll(data);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addById(String recipeId) async {
    try {
      await _repo.addFavorite(_userId, recipeId);
      await load();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> remove(String recipeId) async {
    try {
      await _repo.removeFavorite(_userId, recipeId);
      _items.removeWhere((r) => r.id == recipeId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Helpers locais (sem tocar no DB)
  void addLocal(Recipe r) {
    if (_items.any((e) => e.id == r.id)) return;
    _items.add(r);
    notifyListeners();
  }

  void removeLocal(String recipeId) {
    _items.removeWhere((r) => r.id == recipeId);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    _error = null;
    _loading = false;
    notifyListeners();
  }
}
