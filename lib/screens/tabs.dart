import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeal = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeal.remove(meal);
      });
      _showInfoMessage('Unmarked as Favorite');
    } else {
      setState(() {
        _favoriteMeal.add(meal);
      });
      _showInfoMessage('Marked as Favorite');
    }
  }

  void _selectpage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final availablemeals =
        dummyMeals.where((item) {
          if (_selectedFilters[Filter.glutenFree]! && !item.isGlutenFree) {
            return false;
          }
          if (_selectedFilters[Filter.lactoseFree]! && !item.isLactoseFree) {
            return false;
          }
          if (_selectedFilters[Filter.vegetarian]! && !item.isVegetarian) {
            return false;
          }
          if (_selectedFilters[Filter.vegan]! && !item.isVegan) {
            return false;
          }

          return true;
        }).toList();

    Widget activePage = CategoriesScreen(
      availablemeals: availablemeals,
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitile = 'Category';
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeal,
        onToggleFavorite: _toggleMealFavoriteStatus,
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
