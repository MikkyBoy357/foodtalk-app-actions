import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodtalk/enums/delivery_status.dart';
import 'package:foodtalk/model/food_model.dart';
import 'package:foodtalk/screens/food_list/not_found_screen.dart';
import 'package:foodtalk/utils/boxes.dart';
import 'package:hive/hive.dart';

import '../screens/food_details_screen.dart';

class FoodProvider extends ChangeNotifier {
  MethodChannel batteryChannel = MethodChannel('mikkyboy.com/battery');
  MethodChannel assistantChannel =
      MethodChannel('mikkyboy.com/assistantChannel');
  // MethodChannel foodListChannel =
  //     MethodChannel('mikkyboy.com/mikkyboy.com/foodListChannel');

  bool isInitialized = false;
  TextEditingController foodNameController = TextEditingController();
  List<Food> foodList = [];

  String batterLevel = 'BatteryPercent';
  dynamic intentData = {'key': '', 'name': ''};

  String foodName = '';
  DeliveryStatus deliveryStatus = DeliveryStatus.pending;

  setFoodName(val) {
    foodName = val;
    notifyListeners();
  }

  /// =============> HomeScreen Widget Implementation <=============
  // void initializeAndroidWidgets() {
  //   if (Platform.isAndroid) {
  //     // Intialize flutter
  //     WidgetsFlutterBinding.ensureInitialized();
  //
  //     const MethodChannel channel =
  //         MethodChannel('com.mikkyboy.foodtalk/widget');
  //
  //     final CallbackHandle? callback =
  //         PluginUtilities.getCallbackHandle(onWidgetUpdate);
  //     final handle = callback?.toRawHandle();
  //
  //     channel.invokeMethod('initialize', handle);
  //   }
  // }

  // void onWidgetUpdate() {
  //   // Intialize flutter
  //   WidgetsFlutterBinding.ensureInitialized();
  //
  //   const MethodChannel channel = MethodChannel('com.mikkyboy.foodtalk/widget');
  //
  //   // If you use dependency injection you will need to inject
  //   // your objects before using them.
  //
  //   channel.setMethodCallHandler(
  //     (call) async {
  //       final id = call.arguments;
  //
  //       print('on Dart ${call.method}!');
  //
  //       // Do your stuff here...
  //       final result = Random().nextDouble();
  //       // final result = "This is the result";
  //
  //       return {
  //         // Pass back the id of the widget so we can
  //         // update it later
  //         'id': id,
  //         // Some data
  //         'value': result,
  //       };
  //     },
  //   );
  // }

  /// =============> HomeScreen Widget Implementation <=============

  /// SEND DATA TO ANDROID
  // void sendFoodList() async {
  //   await getBatteryLevel();
  //
  //   await Future.delayed(Duration(seconds: 10));
  //   print('====> Send Food List To Android <====');
  //
  //   foodListChannel.setMethodCallHandler((call) {
  //     print('===MyCall===> $call');
  //     return loadFoodList2();
  //   });
  //   // notifyListeners();
  // }

  /// MethodChannel
  Future<void> getBatteryLevel() async {
    print('====> Get Battery Level <====');
    final arguments = {'name': 'Michael Olusegun'};
    final int newBatteryLevel =
        await batteryChannel.invokeMethod('getBatteryLevel', arguments);
    batterLevel = '$newBatteryLevel%';
    // notifyListeners();
  }

  /// Intend Data
  Future<void> getIntentData(BuildContext context) async {
    print('==========> Check for Intent <==========');
    intentData = {'key': '', 'name': ''};
    intentData = await assistantChannel.invokeMethod('checkForIntent');
    print("====IntentData====> $intentData");
    print("====IntentData====> ${intentData}");
    // notifyListeners();

    // This is to tell our flutter side of the specific intent that was triggered
    if (intentData['key'] == 'get_thing') {
      print(
          '===============> GET_THING INTENT (${intentData.toString()})<===============');
      // if (!mounted) return;
      searchFoodAndShowDetails(context, keyword: intentData['name']);
    } else if (intentData['key'] == 'open_app') {
      print(
          '===============> OPEN_APP INTENT (${intentData.toString()})<===============');
    } else if (intentData['key'] == 'name') {
      print(
          '===============> EXAMPLE_INTENT (${intentData.toString()})<===============');
    } else {
      print(
          '===============> UNKNOWN INTENT (${intentData.toString()})<===============');
    }

    // Reset IntentData
    intentData = {'key': '', 'name': ''};
  }

  /// Search Food Order
  Food? searchFood({required String keyword}) {
    print('===============> Food Search ($keyword) <===============');
    foodList = Boxes.getFoods().values.toList();
    List<Food?> resultList = foodList.where((element) {
      return element.name?.toLowerCase() == keyword.toLowerCase();
    }).toList();

    Food? result;
    if (resultList.isNotEmpty) {
      result = resultList[0];
    }

    print("RESULT => $result");
    return result;
  }

  void searchFoodAndShowDetails(BuildContext context,
      {required String keyword}) {
    Food? result = searchFood(keyword: keyword);

    if (result != null) {
      print("FOUND");
      print("Food => result");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return FoodDetailsScreen(
              food: result,
            );
          },
        ),
      );
    } else {
      print("NOT FOUND");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return NotFoundScreen();
          },
        ),
      );
    }
  }

  /// Hive CRUD
  void loadFoodList() {
    print('====> Load Food List <====');
    foodList = Boxes.getFoods().values.toList();
    getBatteryLevel();
    // getIntentData();
    // notifyListeners();
  }

  Future<List<Food>> loadFoodList2() async {
    print('====> Load Food List <====');
    foodList = Boxes.getFoods().values.toList();
    getBatteryLevel();
    // getIntentData();
    // notifyListeners();
    return foodList;
  }

  void addFood(BuildContext context) {
    if (foodName.isNotEmpty) {
      final food = Food()
        ..name = foodName
        ..deliveryStatus = deliveryStatus;

      final foodBox = Boxes.getFoods();
      foodBox.add(food);
      Navigator.pop(context);
      food.save();
      print('$foodName added Succesfully');
    } else {
      return print('Invalid Fields');
    }
    notifyListeners();
  }

  void editFood(BuildContext context, Food previousFood) {
    print('====> Edit ${previousFood.name} <====');
    if (foodName.isNotEmpty) {
      final newFood = previousFood
        ..name = foodName
        ..deliveryStatus = deliveryStatus;

      final foodBox = Boxes.getFoods();
      print('KEY => ${newFood.key}');
      newFood.save();
      Navigator.pop(context);
      print('$foodName added Succesfully');
    } else {
      return print('Invalid Fields');
    }
    loadFoodList();
    notifyListeners();
  }

  void deleteFood(Food food) {
    final foodBox = Boxes.getFoods();

    // foodBox.delete(food.key);
    food.delete();
    loadFoodList();
    notifyListeners();
  }
}
