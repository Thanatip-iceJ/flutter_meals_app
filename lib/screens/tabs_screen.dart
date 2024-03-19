import 'package:flutter/material.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/providers/favorite_provider.dart';
import 'package:flutter_meals/providers/filters_provider.dart';
import 'package:flutter_meals/screens/category_screen.dart';
import 'package:flutter_meals/screens/filters_screen.dart';
import 'package:flutter_meals/screens/meals_screen.dart';
import 'package:flutter_meals/widgets/main_drawer.dart';
import 'package:flutter_meals/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Map<Filter, bool> initialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedPageIndex = 0;
  Map<Filter, bool> selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false
  };

  void selectPage(index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (context) => FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> filteredMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoryScreen(
      mealList: filteredMeals,
    );
    var activePageTitle = 'Category';

    if (selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteProvider);
      activePage = MealScreen(
        meals: favoriteMeals,
      );
      activePageTitle = "Your Favorites";
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(
        onSelectedScreen: setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: selectPage,
          currentIndex: selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites")
          ]),
    );
  }
}
