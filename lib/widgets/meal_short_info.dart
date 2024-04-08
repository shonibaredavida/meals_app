import 'package:flutter/material.dart';

class MealShortInfo extends StatelessWidget {
  const MealShortInfo({
    super.key,
    required this.header,
    required this.detail,
  });

  final String detail;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          header,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          detail,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
