import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
    // required this.currentFilters
  });

  // final Map<Filter, bool> currentFilters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          // ref.read(filtersProvider.notifier).setFilters({
          //   Filter.glutenFree: _guletinFreeMeal,
          //   Filter.lactoseFree: _lactoseFreeMeal,
          //   Filter.vegetarian: _vegetarianFilterSet,
          //   Filter.vegan: _veganFilterSet,
          // });
          Navigator.of(context).pop();
          // Navigator.of(context).pop({
          //   Filter.glutenFree: _guletinFreeMeal,
          //   Filter.lactoseFree: _lactoseFreeMeal,
          //   Filter.vegetarian: _vegetarianFilterSet,
          //   Filter.vegan: _veganFilterSet,
          // });
        },
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: activeFilter[Filter.glutenFree]!,
              onChanged: (isChecked) {
                // setState(() {
                //   _guletinFreeMeal = isChecked;
                // });
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.glutenFree, isChecked);
              },
            ),
            SwitchListTile(
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: activeFilter[Filter.lactoseFree]!,
              onChanged: (isChecked) {
                // setState(() {
                //   _guletinFreeMeal = isChecked;
                // });
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.lactoseFree, isChecked);
              },
            ),
            SwitchListTile(
              title: Text(
                'Vegaterian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: activeFilter[Filter.vegetarian]!,
              onChanged: (isChecked) {
                // setState(() {
                //   _guletinFreeMeal = isChecked;
                // });
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegetarian, isChecked);
              },
            ),
            SwitchListTile(
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: activeFilter[Filter.vegan]!,
              onChanged: (isChecked) {
                // setState(() {
                //   _guletinFreeMeal = isChecked;
                // });
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegan, isChecked);
              },
            ),
          ],
        ),
      ),
    );
  }
}
