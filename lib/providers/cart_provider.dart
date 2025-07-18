import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/data/models/cart_item.dart';
import 'package:pocket_fm_assignment/data/models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  int get itemCount => _items.length;

  List<CartItem> get items => List.unmodifiable(_items);

  // Total price of all items in cart
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  // Add product to cart
  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  // Remove product from cart
  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  // Clear cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
