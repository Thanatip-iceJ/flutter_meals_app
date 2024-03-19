import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setAllFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
        (ref) => FilterNotifier());

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filtersProvider);
  return meals.where((el) {
    if (selectedFilters[Filter.glutenFree]! && !el.isGlutenFree) {
      return false;
    }
    if (selectedFilters[Filter.lactoseFree]! && !el.isLactoseFree) {
      return false;
    }
    if (selectedFilters[Filter.vegetarian]! && !el.isVegetarian) {
      return false;
    }
    if (selectedFilters[Filter.vegan]! && !el.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
