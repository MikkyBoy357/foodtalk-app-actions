import 'package:hive/hive.dart';

import '../model/food_model.dart';

class Const {
  static Box foodBox = Hive.box<Food>('foodBox');
  // static List<dynamic> foodList = Const.foodBox.get('foodList');

  static void initDummyFoods() async {
    if (foodBox.isEmpty) {
      print('====> initDummyFoods <====');

      // List<Map<String, dynamic>> tempFoodList = [];

      for (Food food in foodItems) {
        foodBox.add(food);
        food.save();
      }

      // await foodBox.put('foodList', tempFoodList);
    } else {
      print('FoodBox is not Empty');
    }
  }
}
