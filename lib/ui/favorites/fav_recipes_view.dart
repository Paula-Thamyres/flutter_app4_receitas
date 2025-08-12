import 'package:app4_receitas/data/di/service_locator.dart';
import 'package:app4_receitas/ui/favorites/fav_recipes_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:app4_receitas/data/models/recipe.dart';
import 'package:provider/provider.dart';

class FavRecipesView extends StatefulWidget {
  const FavRecipesView({super.key, required this.userId});
  final String userId;

  @override
  State<FavRecipesView> createState() => _FavRecipesViewState();
}

class _FavRecipesViewState extends State<FavRecipesView> {
  final watching = getIt<FavRecipesViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      watching.init(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavRecipesViewModel>.value(
      value: watching,
      child: const _FavBody(),
    );
  }
}

class _FavBody extends StatelessWidget {
  const _FavBody();

  @override
  Widget build(BuildContext context) {
    final watching = context.watch<FavRecipesViewModel>();

    return Scaffold(
      body: () {
        if (watching.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (watching.error != null) {
          return Center(child: Text('Erro: ${watching.error}'));
        }
        if (watching.items.isEmpty) return const _EmptyState();

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: watching.items.length,
          itemBuilder: (_, i) {
            final r = watching.items[i];
            return _RecipeCard(
              recipe: r,
              onRemove: () => watching.remove(r.id),
            );
          },
        );
      }(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('Sem receitas favoritas ainda.'),
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({required this.recipe, required this.onRemove});
  final Recipe recipe;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(recipe.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Theme.of(context).colorScheme.error,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onRemove(),
      child: Card(
        child: ListTile(
          leading: recipe.image == null
              ? const CircleAvatar(child: Icon(Icons.restaurant))
              : CircleAvatar(backgroundImage: NetworkImage(recipe.image!)),
          title: Text(recipe.name),
          subtitle: Text(
            '${recipe.totalTimeMinutes} min • ${recipe.servings ?? '-'} porções',
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: onRemove,
          ),
        ),
      ),
    );
  }
}
