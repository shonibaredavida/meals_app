import 'package:flutter/material.dart';

enum Filters {
  vegan,
  glutenFree,
  vegetarian,
  lactoseFree,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.selectedFilter});
  //final void Function(String) onSelectPage;

  final Map<Filters, bool> selectedFilter;
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;
  var _lactoseFreeFilterSet = false;
  @override
  void initState() {
    _glutenFreeFilterSet = widget.selectedFilter[Filters.glutenFree]!;
    _vegetarianFilterSet = widget.selectedFilter[Filters.vegetarian]!;
    _veganFilterSet = widget.selectedFilter[Filters.vegan]!;
    _lactoseFreeFilterSet = widget.selectedFilter[Filters.lactoseFree]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      /*  drawer: MainDrawer(identifier: (identifier) {
        Navigator.pop(context);
        if (identifier == "meal") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => const TabScreen()));
        }
      }), */
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filters.glutenFree: _glutenFreeFilterSet,
            Filters.lactoseFree: _lactoseFreeFilterSet,
            Filters.vegan: _veganFilterSet,
            Filters.vegetarian: _vegetarianFilterSet
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              contentPadding: const EdgeInsets.fromLTRB(39, 0, 30, 0),
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              title: Text(
                "Gluten-Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Turn on to view gluten-free Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            SwitchListTile(
              contentPadding: const EdgeInsets.fromLTRB(39, 0, 30, 0),
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                "Lactose-Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Turn on to view lactose-free Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            SwitchListTile(
              contentPadding: const EdgeInsets.fromLTRB(39, 0, 30, 0),
              value: _vegetarianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
              title: Text(
                "Vegetarian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Turn on to view Vegetarian Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            SwitchListTile(
              contentPadding: const EdgeInsets.fromLTRB(39, 0, 30, 0),
              value: _veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Turn on to view Vegan Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            )
          ],
        ),
      ),
    );
  }
}
