import 'package:flutter/material.dart';
import 'package:market_list/models/grocery_items.dart';
import 'package:market_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _groceryItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addItem,
          ),
        ],
      ),
      body: _groceryItems.isEmpty
          ? Center(
              child: Text(
                'Your List is Empty!!',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (ctx, index) => Dismissible(
                onDismissed: (direction) {
                  _deleteItem(index);
                },
                key: ValueKey(_groceryItems[index].id),
                child: ListTile(
                  title: Text(_groceryItems[index].name),
                  leading: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _groceryItems[index].category.color,
                    ),
                  ),
                  trailing: Text(_groceryItems[index].quantity.toString()),
                ),
              ),
            ),
    );
  }
}
