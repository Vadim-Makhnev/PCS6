import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_list.dart';
import '../models/cart.dart';
import '../widgets/game_design.dart';
import '../widgets/edit_menu.dart';

class HomeScreen extends StatelessWidget {
  void _showEditMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return EditMenu();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final games = Provider.of<GameList>(context).games;
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Game Store',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _showEditMenu(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: games.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, index) => Stack(
            children: [
              GameCard(game: games[index]),
              Positioned(
                bottom: 0,
                right: 8,
                child: ElevatedButton(
                  onPressed: () {
                    cart.addToCart(games[index]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${games[index].title} добавлен в корзину!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                      minimumSize: Size(20, 30)
                  ),
                  child: Icon(Icons.add_shopping_cart, color: Colors.white, size: 20,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

