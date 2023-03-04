import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../enums/delivery_status.dart';
import '../model/food_model.dart';

class AppDataBaseService {
  bool _isInitialized = false;
  static const String dbName = 'foodBox';
  static Future<void> startService() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    Hive.registerAdapter(FoodAdapter());
    Hive.registerAdapter(DeliveryStatusAdapter());
    await Hive.openBox<Food>('foodBox');
  }

  Future<void> init() async {
    try {
      await Hive.openBox<Food>(dbName);
      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
    }
  }

  List<Food> getMikeList() {
    return Hive.box<Food>('foodBox').values.toList();
  }

  Future<void> ensureInitialized() async {
    if (!_isInitialized) {
      await init();
    }
  }

  Future<void> closeDB() async {
    await Hive.close();
  }

  static Future<void> clearDB() async {
    await Hive.box(dbName).clear();
  }
}
