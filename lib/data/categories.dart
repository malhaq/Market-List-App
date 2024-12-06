import 'package:flutter/material.dart';

import 'package:market_list/models/category.dart';

const categories = {
  Categories.vegetables: Category(
    'Vegetables',
    Color.fromARGB(255, 0, 255, 128),
  ),
  Categories.fruit: Category(
    'Fruit',
    Color.fromARGB(255, 145, 255, 0),
  ),
  Categories.meat: Category(
    'Meat',
    Color.fromARGB(255, 255, 102, 0),
  ),
  Categories.dairy: Category(
    'Dairy',
    Color.fromARGB(255, 0, 208, 255),
  ),
  Categories.beverages: Category(
    'Beverages',
    Color.fromARGB(255, 0, 60, 255),
  ),
  Categories.snacks: Category(
    'Snacks',
    Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.frozen: Category(
    'Frozen',
    Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.cleaning: Category(
    'Cleaning',
    Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: Category(
    'Hygiene',
    Color.fromARGB(255, 149, 0, 255),
  ),
  Categories.other: Category(
    'Other',
    Color.fromARGB(255, 0, 225, 255),
  ),
};