import 'dart:convert';
import 'package:flutter/services.dart';

class JsonService {
  static Future<List<dynamic>> loadJsonData(String assetPath) async {
    try {
      final String response = await rootBundle.loadString(assetPath);
      final List<dynamic> data = json.decode(response);
      return data;
    } catch (e) {
      throw Exception('Failed to load JSON from $assetPath: $e');
    }
  }
}
