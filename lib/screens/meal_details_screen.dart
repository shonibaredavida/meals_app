import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_short_info.dart';
import 'package:meals_app/widgets/meal_info.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen(
      {super.key, required this.meal, required this.toggleFavStatus});
  final Meal meal;
  final void Function(Meal) toggleFavStatus;

  String get getLactoseDetail {
    return meal.isLactoseFree ? "Yes" : "No";
  }

  String get getVeganDetail {
    return meal.isVegan ? "Yes" : "No";
  }

  String get getGlutenDetail {
    return meal.isGlutenFree ? "Yes" : "No";
  }

  String get getVegetarianDetail {
    return meal.isVegetarian ? "Yes" : "No";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                toggleFavStatus(meal);
              },
              icon: const Icon(Icons.star_border))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
        child: Column(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MealInfo(
                      details: meal.ingredients,
                      header: "Ingredients",
                    ),
                    MealInfo(
                      details: meal.steps,
                      header: "Steps",
                    ),
                    MealShortInfo(
                      header: "Lactose Free",
                      detail: getLactoseDetail,
                    ),
                    MealShortInfo(
                      header: "Vegetarian",
                      detail: getVegetarianDetail,
                    ),
                    MealShortInfo(
                      header: "Vegan",
                      detail: getVeganDetail,
                    ),
                    MealShortInfo(
                      header: "Gluten Free",
                      detail: getGlutenDetail,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
