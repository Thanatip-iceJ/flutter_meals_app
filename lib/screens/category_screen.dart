import 'package:flutter/material.dart';
import 'package:flutter_meals/data/dummy_data.dart';
import 'package:flutter_meals/models/category.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/screens/meals_screen.dart';
import 'package:flutter_meals/widgets/category_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.mealList});

  final List<Meal> mealList;

  void navigateHandle(BuildContext context, Category category) {
    final mealsByCategory =
        mealList.where((el) => el.categories.contains(category.id)).toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MealScreen(
                  title: category.title,
                  meals: mealsByCategory,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            ...availableCategories.map((e) => CategoryGridItem(
                  category: e,
                  onTap: () => navigateHandle(context, e),
                ))
            // for (var category in availableCategories)
            //   CategoryGridItem(category: category)
          ],
        ),
      ),
    );
  }
}
