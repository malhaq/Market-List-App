import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market_list/data/categories.dart';
import 'package:market_list/models/grocery_items.dart';
import 'package:market_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _screenLoading = true;
  String? _err;

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  void _loadList() async {
    final url = Uri.https(
        'markit-list-default-rtdb.firebaseio.com', 'grocery-list.json');
    final res = await http.get(url);
    if (res.statusCode >= 400) {
      setState(() {
        _err = 'failed to load data please try again';
      });
    }
    final Map<String, dynamic> listItems = json.decode(res.body);
    final List<GroceryItem> loadList = [];
    for (final item in listItems.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadList.add(
        GroceryItem(
          category: category,
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
        ),
      );
    }
    setState(() {
      _groceryItems = loadList;
      _screenLoading = false;
    });
    // print(res.body);
  }

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
    Widget screenContent = Center(
      child: Text(
        'Your List is Empty!!',
        style: Theme.of(context).textTheme.displayLarge,
        textAlign: TextAlign.center,
      ),
    );
    if (_screenLoading) {
      screenContent = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_groceryItems.isNotEmpty) {
      screenContent = ListView.builder(
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
      );
    }
    if (_err != null) {
      screenContent = Center(
        child: Text(
          _err!,
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
      );
    }

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
      body: screenContent,
    );
  }
}
