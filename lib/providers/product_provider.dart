import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/data/models/product.dart';
import '../data/services/json_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Product> get products => List.unmodifiable(_products);

  // Load products from JSON file
  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final List<dynamic> data = await JsonService.loadJsonData(
        'assets/products.json',
      );
      _products = data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
