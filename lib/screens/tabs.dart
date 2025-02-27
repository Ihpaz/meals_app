import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/melas_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeal = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeal.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeal.remove(meal);
  //     });
  //     _showInfoMessage('Unmarked as Favorite');
  //   } else {
  //     setState(() {
  //       _favoriteMeal.add(meal);
  //     });
  //     _showInfoMessage('Marked as Favorite');
  //   }
  // }

  void _selectpage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      // final result =
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder:
              (ctx) => const FiltersScreen(
                // currentFilters: _selectedFilters
              ),
        ),
      );

      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final availablemeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availablemeals: availablemeals,
      // onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitile = 'Category';
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activePage = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitile = 'Meal Favorites';
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitile)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectpage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
