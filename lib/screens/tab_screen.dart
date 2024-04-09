import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarian: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  final List<Meal> _favMeals = [];
  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
    ));
  }

  void _toggleMealFavStatus(Meal meal) {
    final isExisting = _favMeals.contains(meal);
    if (!isExisting) {
      _favMeals.add(meal);
      //  print(_favMeals[0].title);
      showInfoMessage("Meal added to Favorite Meals");
    } else {
      _favMeals.remove(meal);
      //   print(_favMeals);
      showInfoMessage("Meal removed from Favorite Meals");
    }
    setState(() {});
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
    List<Meal> availableMeals = dummyMeals.where((meal) {
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
      toggleFavoriteStatus: _toggleMealFavStatus,
      availableMeals: availableMeals,
    );
    var pageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favMeals,
        toggleFavStatus: _toggleMealFavStatus,
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
