import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/melas_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
      return FiltersNotifier();
    });

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((item) {
    if (activeFilters[Filter.glutenFree]! && !item.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !item.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !item.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !item.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
