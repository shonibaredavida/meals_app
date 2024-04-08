import 'package:flutter/material.dart';

class MealInfo extends StatelessWidget {
  const MealInfo({super.key, required this.header, required this.details});

  final List details;
  final String header;

  @override
  Widget build(BuildContext context) {
    double spacing = 8;
    if (header == "Steps") {
      spacing = 18;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              header,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          for (int i = 0; i < details.length; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: spacing),
              child: Column(
                children: [
                  Text(
                    details[i],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
