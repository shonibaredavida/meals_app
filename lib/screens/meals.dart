import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {this.title,
      required this.meals,
      super.key,
      required this.toggleFavStatus});
  final String? title;
  final List<Meal> meals;
  final Function(Meal) toggleFavStatus;
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemBuilder: (cxt, index) => MealItem(
        meal: meals[index],
        togglefavStatus: toggleFavStatus,
      ),
      itemCount: meals.length,
    );

    if (meals.isEmpty) {
      content = Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Opps No..... Nothing here!!",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          const SizedBox(
            height: 15,
          ),
          Text("Try clicking other Categories",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          /*    InkWell(
            onTap: () => Navigator.pop(context),
            child: Text("Go Back"),
          ) */
        ],
      ));
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
