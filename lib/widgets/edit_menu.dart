import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/game_list.dart';
import '../models/game.dart';

class EditMenu extends StatefulWidget {
  @override
  _EditMenuState createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _imageUrl = '';
  String _price = '';
  String _description = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newGame = Game(
        id: Uuid().v4(),
        title: _title,
        imageUrl: _imageUrl,
        price: double.parse(_price),
        description: _description,
      );
      Provider.of<GameList>(context, listen: false).addGame(newGame);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final games = Provider.of<GameList>(context).games;
    return Scaffold(
      resizeToAvoidBottomInset: false,  // Prevents resizing when keyboard appears
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          'Добавить игру',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Добавление игры',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      label: 'Название',
                      onSaved: (value) => _title = value!,
                      validator: (value) => value!.isEmpty ? 'Введите название' : null,
                    ),
                    _buildTextField(
                      label: 'URL изображения',
                      onSaved: (value) => _imageUrl = value!,
                      validator: (value) => value!.isEmpty ? 'Введите URL изображения' : null,
                    ),
                    _buildTextField(
                      label: 'Цена',
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onSaved: (value) => _price = value!,
                      validator: (value) {
                        if (value!.isEmpty || double.tryParse(value) == null) {
                          return 'Введите корректную цену';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      label: 'Описание',
                      maxLines: 3,
                      onSaved: (value) => _description = value ?? '',
                      validator: (value) => value!.isEmpty ? 'Введите описание' : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text('Добавить',style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,  // Updated color
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Divider(color: Colors.grey),
              SizedBox(height: 20),
              Text(
                'Удалить игру',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            SizedBox(height: 10),
            ...games.map(
            (game) => Padding(
      padding: const EdgeInsets.only(bottom: 10.0), // Adds margin between ListTile items
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        title: Text(
          game.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),

                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _confirmDelete(context, game.id);
                    },
                  ),
                  tileColor: Colors.grey[850],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String> onSaved,
    required String? Function(String?) validator,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[700],
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        onSaved: onSaved,
        textInputAction: TextInputAction.next,  // Ensures smooth navigation between text fields
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Подтвердите удаление'),
        content: Text('Вы уверены, что хотите удалить эту игру?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Отмена', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Provider.of<GameList>(context, listen: false).removeGame(id);
              Navigator.of(ctx).pop();
            },
            child: Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}


