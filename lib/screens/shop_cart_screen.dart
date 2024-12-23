import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../providers/game_list.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: Center (child: Text('Game Store', style: TextStyle(fontSize: 30))),
        backgroundColor: Colors.blueGrey,
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          'Ваша корзина пуста',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final gameId = cartItems.keys.elementAt(index);
                final quantity = cartItems[gameId]!;
                final game = Provider.of<GameList>(context, listen: false)
                    .games
                    .firstWhere((game) => game.id == gameId);

                return ListTile(
                  leading: Image.network(game.imageUrl),
                  title: Text(game.title, style: TextStyle(color: Colors.white)),
                  subtitle: Text(
                      'Цена: \$${game.price} × $quantity = \$${(game.price * quantity).toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      cart.removeFromCart(gameId);
                    },
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Итоговая сумма:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '\$${cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
    Container(
      margin: const EdgeInsets.all(16.0),  // Add margin around the button
      child: ElevatedButton(
      onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        content: Text('Оформление заказа...'),
      ),
      );
      },
        style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueGrey,
    ),
    child: Text(
    'Оформить заказ',
    style: TextStyle(fontSize: 18, color: Colors.white),
    ),
    ),
    )

        ],
      ),
    );
  }
}
