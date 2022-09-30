import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtalk/model/food_model.dart';
import 'package:foodtalk/screens/food_details_screen.dart';
import 'package:foodtalk/utils/boxes.dart';
import 'package:foodtalk/view_models/food_provider.dart';
import 'package:provider/provider.dart';

import 'components/add_food_sheet.dart';
import 'components/food_tile.dart';
import 'package:foodtalk/utils/const.dart';

class FoodlistScreen extends StatefulWidget {
  const FoodlistScreen({Key? key}) : super(key: key);

  @override
  State<FoodlistScreen> createState() => _FoodlistScreenState();
}

class _FoodlistScreenState extends State<FoodlistScreen> {
  @override
  void initState() {
    super.initState();
    FoodProvider foodViewModel =
        Provider.of<FoodProvider>(context, listen: false);
    foodViewModel.loadFoodList();
    foodViewModel.getIntentData(context);
  }

  @override
  Widget build(BuildContext context) {
    print('FoodBox => ${Const.foodBox}');
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Food Manager'),
      ),
      body: Consumer<FoodProvider>(
        builder: (context, food, _) {
          print('Length => ${food.foodList.length}');
          return Builder(
            builder: (context) {
              food.loadFoodList();
              if (food.foodList.isEmpty) {
                return Center(
                  child: Text(
                    "Add new food order",
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        food.batterLevel,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: Boxes.getFoods().length,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          List<Food> foodList =
                              Boxes.getFoods().values.toList();
                          Food currentFood = foodList[index];

                          return FoodTile(
                            food: currentFood,
                            onDelete: () => food.deleteFood(currentFood),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FoodDetailsScreen(food: currentFood);
                                  },
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 15.h,
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return AddFoodSheet();
            },
          );
          Provider.of<FoodProvider>(context, listen: false)
              .foodNameController
              .text = '';
          Provider.of<FoodProvider>(context, listen: false).setFoodName('');
        },
      ),
    );
  }
}
