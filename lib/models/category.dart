import 'package:flutter/material.dart';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  beverages,
  snacks,
  frozen,
  cleaning,
  hygiene,
  other,
}

class Category {
  const Category(this.title,this.color);
  final String title;
  final Color color;
}