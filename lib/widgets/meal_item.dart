import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorite_meal_provider.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends ConsumerWidget {
  const MealItem({
    required this.meal,
    super.key,
  });
  final Meal meal;
  String get capitalizedComplexity {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get capitalizedAfforadability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFavoriteMeals = ref.watch(favoriteMealProvider);
    final bool isFavMeal = currentFavoriteMeals.contains(meal);
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => MealDetailsScreen(
                      meal: meal,
                    ))),
        child: Stack(
          children: [
            FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                image: NetworkImage(meal.imageUrl)),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                color: Colors.black45,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: "${meal.duration} mins"),
                        const SizedBox(
                          width: 10,
                        ),
                        MealItemTrait(
                            icon: Icons.work, label: capitalizedComplexity),
                        const SizedBox(
                          width: 10,
                        ),
                        MealItemTrait(
                            icon: Icons.attach_money_sharp,
                            label: capitalizedAfforadability),
                        isFavMeal
                            ? Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    size: 30,
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
