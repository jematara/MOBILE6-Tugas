import 'package:flutter/material.dart';

class Product {
  final String nama, deskripsi, gambar;

  Product(this.nama, this.deskripsi, this.gambar);
}

class CartModel extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  int get totalItem => _items.length;

  void add(Product product) {
  _items.add(product);
  notifyListeners();
  }

  void remove(Product product) {
  _items.remove(product);
  notifyListeners();
  }
}