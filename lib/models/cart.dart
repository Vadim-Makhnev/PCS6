import 'package:flutter/material.dart';
import '../models/game.dart';
import '../providers/game_list.dart';

class Cart with ChangeNotifier {
  final Map<String, int> _items = {}; // id игры и количество

  Map<String, int> get items => {..._items};

  void addToCart(Game game) {
    if (_items.containsKey(game.id)) {
      _items[game.id] = _items[game.id]! + 1;
    } else {
      _items[game.id] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    if (_items.containsKey(id)) {
      _items.remove(id);
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double get totalPrice => _items.entries.fold(
    0,
        (sum, entry) => sum + entry.value * _findGameById(entry.key).price,
  );

  Game _findGameById(String id) {
    // Важно: используйте ваш список игр
    return GameList().games.firstWhere((game) => game.id == id);
  }
}
