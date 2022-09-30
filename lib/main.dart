import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtalk/screens/food_list/food_list_screen.dart';
import 'package:foodtalk/utils/boxes.dart';
import 'package:foodtalk/utils/extensions/delivery_status_extension.dart';
import 'package:foodtalk/utils/providers_list.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'enums/delivery_status.dart';
import 'model/food_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize HiveDB
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(FoodAdapter());
  Hive.registerAdapter(DeliveryStatusAdapter());
  await Hive.openBox<Food>('foodBox');

  initializeAndroidWidgets();

  runApp(MyApp());
}

void initializeAndroidWidgets() {
  if (Platform.isAndroid) {
    // Initialize flutter
    // WidgetsFlutterBinding.ensureInitialized();

    const MethodChannel channel = MethodChannel('com.mikkyboy.foodtalk/widget');

    final CallbackHandle? callback =
        PluginUtilities.getCallbackHandle(onWidgetUpdate);
    final handle = callback?.toRawHandle();

    channel.invokeMethod('initialize', handle);
  }
}

void onWidgetUpdate() {
  // Initialize flutter
  WidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('com.mikkyboy.foodtalk/widget');

  // If you use dependency injection you will need to inject
  // your objects before using them.

  channel.setMethodCallHandler(
    (call) async {
      final id = call.arguments;
      final String foodName = call.method.toString();

      print('on Dart ${call.method}!');

      // Do your stuff here...
      final result = Random().nextDouble();
      // final result = 33.59;

      // Search food
      Food? food = searchFood(keyword: foodName);

      Map foodData = {
        // Pass back the id of the widget so we can
        // update it later
        'id': id,
        // Some data
        'value': 33.59,
        'name': 'Order NOT FOUND',
        'deliveryStatus': '404'
      };

      if (food != null) {
        foodData['name'] = "${food.name}";
        foodData['deliveryStatus'] = food.deliveryStatus != null
            ? food.deliveryStatus!.valueAsString.toUpperCase()
            : "UNKNOWN";
      }

      return foodData;
    },
  );
}

/// Search Food Order
Food? searchFood({required String keyword}) {
  List<Food> foodList = [
    Food(
      name: "Rice and beans",
      deliveryStatus: DeliveryStatus.pending,
    ),
    Food(
      name: "Yam and Beans",
      deliveryStatus: DeliveryStatus.pending,
    ),
    Food(
      name: "Spaghetti",
      deliveryStatus: DeliveryStatus.pending,
    ),
  ];
  print('===============> Widget Food Search ($keyword) <===============');
  // foodList = Hive.box<Food>('foodBox').values.toList();
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    print('InitState => ${Hive.box<Food>('foodBox').values.toList()}');
    // initializeAndroidWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providersList,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'FoodTalk',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              textTheme: const TextTheme(
                bodyText2: TextStyle(
                  color: Colors.white,
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            home: child,
          );
        },
        child: FoodlistScreen(),
        // child: NotFoundScreen(),
      ),
    );
  }
}
