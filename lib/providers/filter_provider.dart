import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });
  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setAllFilters(Map<Filter, bool> filterSet) {
    state = filterSet;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final currentFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (!meal.isGlutenFree && currentFilters[Filter.glutenFree]!) {
      return false;
    }
    if (!meal.isLactoseFree && currentFilters[Filter.lactoseFree]!) {
      return false;
    }
    if (!meal.isVegetarian && currentFilters[Filter.vegetarian]!) {
      return false;
    }
    if (!meal.isVegan && currentFilters[Filter.vegan]!) {
      return false;
    }
    return true;
  }).toList();
});
