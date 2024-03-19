import 'package:flutter/material.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/providers/favorite_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen(this.meal, {super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteProvider);
    final isFavortie = favoriteMeals.contains(meal);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            meal.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  final isAdded =
                      ref.read(favoriteProvider.notifier).toggleFavorite(meal);

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        isAdded ? 'Added to favoite' : 'Removed from favorite',
                        style: Theme.of(context).textTheme.bodyLarge),
                    duration: const Duration(seconds: 3),
                  ));
                },
                icon: Icon(isFavortie ? Icons.star : Icons.star_border))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Image.network(meal.imageUrl),
            const SizedBox(
              height: 16,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      "Ingredients",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    ...meal.ingredients.map((el) => Text(
                          el,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Steps",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    ...meal.steps.map((el) => Text(
                          el,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        )),
                  ],
                )),
          ]),
        ));
  }
}
