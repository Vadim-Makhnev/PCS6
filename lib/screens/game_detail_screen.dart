import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_list.dart';

class GameDetailScreen extends StatelessWidget {
  static const routeName = '/game-detail';

  @override
  Widget build(BuildContext context) {
    final gameId = ModalRoute.of(context)!.settings.arguments as String;
    final game = Provider.of<GameList>(context, listen: false)
        .games
        .firstWhere((game) => game.id == gameId);

    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(game.imageUrl),
            SizedBox(height: 20),
            Text(
              game.title,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              '\$${game.price.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white60, fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              game.description,
              style: TextStyle(color: Colors.white, fontSize: 21),
            ),
          ],
        ),
      ),
    );
  }
}
