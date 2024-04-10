import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealNotifier() : super([]);
  bool toggleFavoriteMealSatus(Meal meal) {
    final isInMealFavoriteList = state.contains(meal);
    if (isInMealFavoriteList) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }

  /*  bool isMealFav(Meal meal) {
    final isInMealFavoriteList = state.contains(meal);

    return isInMealFavoriteList ? true : false;
  } */
}

final favoriteMealProvider =
    StateNotifierProvider<FavoriteMealNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealNotifier();
  },
);
