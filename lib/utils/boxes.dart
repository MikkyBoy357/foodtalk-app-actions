import 'package:hive/hive.dart';

import '../model/food_model.dart';

class Boxes {
  static Box<Food> getFoods() => Hive.box<Food>('foodBox');
}
