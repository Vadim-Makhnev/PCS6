import 'package:flutter/material.dart';
import '../models/game.dart';

class GameList with ChangeNotifier {
  List<Game> _games = [
    Game(
      id: '1',
      title: 'The Last Of Us: Part 1',
      imageUrl: 'https://tse4.mm.bing.net/th?id=OIP.zh0HSYXvn1tlspHeNNSjoAHaEK&pid=Api',
      price: 29.39,
      description: 'Survival',
    ),
    Game(
        id: "2",
        title: "Detroit: Become Human",
        imageUrl: "https://tse4.mm.bing.net/th?id=OIP.RIDdcJzEhSQNCGdwYVVT1wHaHa&pid=Api",
        price: 29.99,
        description: "Adventure"
    ),
  ];

  List<Game> get games => [..._games];

  List<Game> get favoriteGames =>
      _games.where((game) => game.isFavorite).toList();

  void addGame(Game game) {
    _games.add(game);
    notifyListeners();
  }

  void removeGame(String id) {
    _games.removeWhere((game) => game.id == id);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _games.indexWhere((game) => game.id == id);
    if (index >= 0) {
      _games[index].isFavorite = !_games[index].isFavorite;
      notifyListeners();
    }
  }
}
