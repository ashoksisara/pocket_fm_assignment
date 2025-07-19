import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/cart_item.dart';
import '../../core/constants/app_constants.dart';

class StorageService {
  static Database? _database;
  static const String _tableName = AppConstants.cartTableName;

  // Get database instance
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, AppConstants.databaseName);

    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _createDatabase,
    );
  }

  // Create database tables
  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id TEXT NOT NULL,
        cart_data TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
  }

  // Save cart items to database
  static Future<void> saveCartItems(List<CartItem> items) async {
    try {
      final db = await database;

      // Clear existing cart items
      await db.delete(_tableName);

      // Insert new cart items
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      for (final item in items) {
        await db.insert(_tableName, {
          'product_id': item.product.id,
          'cart_data': jsonEncode(item.toJson()),
          'created_at': timestamp,
          'updated_at': timestamp,
        });
      }
    } catch (e) {
      // Handle error silently to not affect UI
      print('Error saving cart items: $e');
    }
  }

  // Load cart items from database
  static Future<List<CartItem>> loadCartItems() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(_tableName);

      return maps.map((map) {
        final cartData = jsonDecode(map['cart_data']);
        return CartItem.fromJson(cartData);
      }).toList();
    } catch (e) {
      // Handle error silently and return empty list
      print('Error loading cart items: $e');
      return [];
    }
  }

  // Clear all cart items
  static Future<void> clearCart() async {
    try {
      final db = await database;
      await db.delete(_tableName);
    } catch (e) {
      // Handle error silently
      print('Error clearing cart: $e');
    }
  }

  // Close database connection
  static Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
