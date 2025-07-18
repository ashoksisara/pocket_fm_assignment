import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/data/models/product.dart';
import '../core/constants/app_constants.dart';
import '../data/services/json_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _allProducts = [];
  List<Product> _products = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _error;

  static const int _pageSize = 10;
  int _currentPage = 0;
  bool _hasMoreData = true;

  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get error => _error;
  List<Product> get products => List.unmodifiable(_products);
  bool get hasMoreData => _hasMoreData;

  // Load products from JSON file
  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    _currentPage = 0;
    _products.clear();
    notifyListeners();

    try {
      final List<dynamic> data = await JsonService.loadJsonData(
        AppConstants.productsJsonPath,
      );
      _allProducts = data.map((json) => Product.fromJson(json)).toList();
      _loadPage();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load more products for pagination
  Future<void> loadMoreProducts() async {
    if (_isLoadingMore || !_hasMoreData) return;

    _isLoadingMore = true;
    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate network delay

    _currentPage++;
    _loadPage();

    _isLoadingMore = false;
    notifyListeners();
  }

  void _loadPage() {
    final startIndex = _currentPage * _pageSize;
    final endIndex = startIndex + _pageSize;

    if (startIndex >= _allProducts.length) {
      _hasMoreData = false;
      return;
    }

    final pageItems = _allProducts.sublist(
      startIndex,
      endIndex > _allProducts.length ? _allProducts.length : endIndex,
    );

    if (_currentPage == 0) {
      _products = pageItems;
    } else {
      _products.addAll(pageItems);
    }

    _hasMoreData = endIndex < _allProducts.length;
  }
}
