import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../enums/delivery_status.dart';

part 'food_model.g.dart';

@HiveType(typeId: 0)
class Food extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? ingredients;
  @HiveField(2)
  DeliveryStatus? deliveryStatus;

  Food({
    this.name,
    this.ingredients,
    this.deliveryStatus,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json["name"],
      ingredients: json["ingredients"],
      deliveryStatus: json["deliveryStatus"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "ingredients": ingredients,
      "deliveryStatus": deliveryStatus.toString(),
    };
  }
}

List<Food> foodItems = [
  Food(
    name: 'Rice and Stew',
    deliveryStatus: DeliveryStatus.delivered,
  ),
  Food(
    name: 'Bread and Beans',
    deliveryStatus: DeliveryStatus.delivered,
  ),
  Food(
    name: 'Yam and Stew',
    deliveryStatus: DeliveryStatus.delivered,
  ),
  Food(
    name: 'Bread and Tea',
    deliveryStatus: DeliveryStatus.delivered,
  ),
];
