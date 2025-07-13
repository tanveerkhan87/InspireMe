import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/quote_data.dart';
import '../models/quote.dart';

class AppProvider extends ChangeNotifier {


  // The underscore '_' makes it private to this file.
  bool _isDarkMode = false;
  //heree   Set to store the user's favorite quotes.
  final Set<Quote> _favorites = {};

  //                        GETTERS

  // Public getter to safely access the theme mode from outside the class.
  // Widgets will listen to this for theme changes.
  bool get isDarkMode => _isDarkMode;

  // Public getter to provide a list of favorite quotes.
  // It converts the Set to a List for easier use in UI widgets like ListView.
  List<Quote> get favorites => _favorites.toList();

                    // METHODS

  // Initializes the provider's state from saved preferences.
  // This should be called once when the app starts.
  Future<void> init() async {
    // Get an instance of SharedPreferences to access local storage.
    final prefs = await SharedPreferences.getInstance();
    // Load the saved theme preference. If 'dark_mode' is not set, default to 'false' (light mode).
    _isDarkMode = prefs.getBool('dark_mode') ?? false;
    // Load the list of saved favorite quote indexes. If nothing is saved, default to an empty list.
    final savedIndexes = prefs.getStringList('favorite_indexes') ?? [];
    // Reconstruct the `_favorites` Set from the saved indexes.
    for (var index in savedIndexes) {
      // Safely parse the string index into an integer.
      int i = int.tryParse(index) ?? -1;
      // Check if the index is valid and within the bounds of our quotes list.
      if (i >= 0 && i < quotesList.length) {
        _favorites.add(quotesList[i]);
      }
    }
    // After loading the initial state, notify all listening widgets to rebuild with the correct data.
    notifyListeners();
  }


  // Toggles the app's theme between light and dark mode and saves the preference.
  Future<void> toggleTheme() async {
    // Invert the boolean value.
    _isDarkMode = !_isDarkMode;
    // Save the new theme preference to local storage.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', _isDarkMode);
    // Notify listeners (like the main app widget) that the theme has changed so they can rebuild.
    notifyListeners();
  }


  // Adds or removes a quote from the favorites list and saves the changes.
  Future<void> toggleFavorite(Quote quote) async {
    // Check if the quote is already in the favorites Set.
    if (_favorites.contains(quote)) {
      _favorites.remove(quote);
    } else {
      _favorites.add(quote);
    }
    final prefs = await SharedPreferences.getInstance();
// Create an empty list to store indexes of favorite quotes
    List<String> favIndexes = [];
// Loop through all quotes with their index
    for (int i = 0; i < quotesList.length; i++) {
      final quote = quotesList[i];
      // If this quote is in favorites, add its index to the list
      if (_favorites.contains(quote)) {
        favIndexes.add(i.toString()); // Save index as string
      }
    }
// Save the list to SharedPreferences
    await prefs.setStringList('favorite_indexes', favIndexes);
    // Notify listeners (like the QuoteCard and HomeScreen) that the favorites list has changed.
    notifyListeners();
  }



  // A helper method to quickly check if a given quote is a favorite.

  bool isFavorite(Quote quote) => _favorites.contains(quote);
}