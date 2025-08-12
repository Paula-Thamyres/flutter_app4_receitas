import 'package:app4_receitas/data/di/service_locator.dart';
import 'package:app4_receitas/ui/recipedetail/recipe_detail_viewmodel.dart';
import 'package:app4_receitas/ui/widgets/recipe_row_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';

class RecipeDetailView extends StatefulWidget {
  const RecipeDetailView({super.key, required this.id});
  final String? id;

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  final viewModel = getIt<RecipeDetailViewModel>();

  // use o mesmo UUID que a sua rota /favorites
  static const String fixedUserId = 'e9d443fa-ab43-45d7-a52b-44f0300d5ea9';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await viewModel.loadRecipe(widget.id!);
      await viewModel.checkIfFavorite(fixedUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (viewModel.isloading) {
        return const Center(
          child: SizedBox(
            height: 96,
            width: 96,
            child: CircularProgressIndicator(strokeWidth: 12),
          ),
        );
      }

      if (viewModel.errorMessage != '') {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              spacing: 32,
              children: [
                Text(
                  'Erro: ${viewModel.errorMessage}',
                  style: const TextStyle(fontSize: 24),
                ),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('VOLTAR'),
                ),
              ],
            ),
          ),
        );
      }

      final recipe = viewModel.recipe!;
      return SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              recipe.image ?? '',
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null
                  ? child
                  : Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
              errorBuilder: (context, child, stackTrace) => Container(
                height: 400,
                width: double.infinity,
                color: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(recipe.name),
                  const SizedBox(height: 16),
                  RecipeRowDetails(recipe: recipe),
                  const SizedBox(height: 16),
                  recipe.ingredients.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text('Ingredientes:'),
                            const SizedBox(height: 8),
                            Text(recipe.ingredients.join('\n')),
                          ],
                        )
                      : const Text('Nenhum ingrediente listado.'),
                  const SizedBox(height: 16),
                  recipe.instructions.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text('Instruções:'),
                            const SizedBox(height: 8),
                            Text(recipe.instructions.join('\n')),
                          ],
                        )
                      : const Text('Nenhuma instrução listada.'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.go('/'),
                        child: const Text('VOLTAR'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => viewModel.toggleFavorite(fixedUserId),
                        child: Text(
                          viewModel.isFavorite ? 'DESFAVORITAR' : 'FAVORITAR',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
