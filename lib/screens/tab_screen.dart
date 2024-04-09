import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorite_meal_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarian: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});
  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
    ));
  }

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  var _selectedFilter = kInitialFilters;
  void selectDrawerPage(String identifier) async {
    Navigator.pop(context);
    if (identifier == "filter") {
      var result = await Navigator.push<Map<Filters, bool>>(
        context,
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(
            selectedFilter: _selectedFilter,
          ),
        ),
      );

      setState(() {
        _selectedFilter = result ?? kInitialFilters;
      });
      // print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider);
    List<Meal> availableMeals = meals.where((meal) {
      if (!meal.isGlutenFree && _selectedFilter[Filters.glutenFree]!) {
        return false;
      }
      if (!meal.isLactoseFree && _selectedFilter[Filters.lactoseFree]!) {
        return false;
      }
      if (!meal.isVegetarian && _selectedFilter[Filters.vegetarian]!) {
        return false;
      }
      if (!meal.isVegan && _selectedFilter[Filters.vegan]!) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var pageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      final favMeals = ref.watch(favoriteMealProvider);
      activePage = MealsScreen(
        meals: favMeals,
      );
      pageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(pageTitle),
      ),
      drawer: MainDrawer(
        identifier: selectDrawerPage,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
              ),
              label: "Favorites"),
        ],
      ),
    );
  }
}
