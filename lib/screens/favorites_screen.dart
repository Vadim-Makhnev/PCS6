import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_list.dart';
import '../widgets/game_design.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteGames = Provider.of<GameList>(context).favoriteGames;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Game Store',
            style: TextStyle(fontSize: 30),
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),

      body: favoriteGames.isEmpty
          ? Center(
        child: Text(
          'Нет избранных игр',
          style: TextStyle(color: Colors.white, fontSize: 21),

        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: favoriteGames.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, index) =>
              GameCard(game: favoriteGames[index]),
        ),
      ),
    );
  }
}
