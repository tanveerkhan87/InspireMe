import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/quote_data.dart';
import '../models/quote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  final Set<Quote> _favorites = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool get isDarkMode => _isDarkMode;
  List<Quote> get favorites => _favorites.toList();

  User? get _user => FirebaseAuth.instance.currentUser;

  Future<void> init() async {
    _favorites.clear(); //  Clear old user's favorites first
    await _loadTheme();
    if (_user != null) {
      await _loadFavoritesFromFirestore();
    }
    notifyListeners();
  }


  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('dark_mode') ?? false;
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', _isDarkMode);
    notifyListeners();
  }


  Future<void> _loadFavoritesFromFirestore() async {
    try {
      // Get the user document from Firestore
      final doc = await _firestore.collection('users').doc(_user!.uid).get();
      // If the document exists and has a 'favorites' list
      if (doc.exists && doc.data()?['favorites'] != null) {
        List<String> favIndexes = List<String>.from(doc['favorites']);
        // Clear old favorites
        _favorites.clear();
        // Add each valid quote to favorites
        for (var index in favIndexes) {
          int i = int.tryParse(index) ?? -1;
          if (i >= 0 && i < quotesList.length) {
            _favorites.add(quotesList[i]);
          }
        }
        notifyListeners(); // Notify UI about changes
      }
    } catch (e) {
      print('Failed to load favorites: $e');
    }
  }



  Future<void> toggleFavorite(Quote quote) async {
    if (_favorites.contains(quote)) {
      _favorites.remove(quote);
    } else {
      _favorites.add(quote);
    }
    await _saveFavoritesToFirestore();
    notifyListeners();
  }

  Future<void> _saveFavoritesToFirestore() async {
    if (_user == null) return;

    try {
      List<String> favIndexes = [];
      for (int i = 0; i < quotesList.length; i++) {
        if (_favorites.contains(quotesList[i])) {
          favIndexes.add(i.toString());
        }
      }

      await _firestore.collection('users').doc(_user!.uid).set({
        'favorites': favIndexes,
      });
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  bool isFavorite(Quote quote) => _favorites.contains(quote);


  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }

}
