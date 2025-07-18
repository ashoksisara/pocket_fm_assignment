import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/data/models/cart_item.dart';
import 'package:pocket_fm_assignment/data/models/product.dart';
import 'package:pocket_fm_assignment/data/services/storage_service.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  bool _isLoading = false;

  int get itemCount => _items.length;
  bool get isLoading => _isLoading;

  List<CartItem> get items => List.unmodifiable(_items);

  // Total price of all items in cart
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  // Constructor - load cart items from storage
  CartProvider() {
    _loadCartFromStorage();
  }

  // Load cart items from storage
  Future<void> _loadCartFromStorage() async {
    _isLoading = true;
    notifyListeners();

    try {
      final storedItems = await StorageService.loadCartItems();
      _items.clear();
      _items.addAll(storedItems);
    } catch (e) {
      // Handle error silently to not affect UI
      debugPrint('Error loading cart from storage: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Save cart items to storage
  Future<void> _saveCartToStorage() async {
    try {
      await StorageService.saveCartItems(_items);
    } catch (e) {
      // Handle error silently to not affect UI
      debugPrint('Error saving cart to storage: $e');
    }
  }

  // Add product to cart
  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
    _saveCartToStorage();
  }

  // Remove product from cart
  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
    _saveCartToStorage();
  }

  // Clear cart
  void clearCart() {
    _items.clear();
    notifyListeners();
    _saveCartToStorage();
  }

  // Update item quantity
  void updateQuantity(Product product, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
      _saveCartToStorage();
    }
  }

  // Get item quantity
  int getQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    return index >= 0 ? _items[index].quantity : 0;
  }
}
