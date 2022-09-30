import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'delivery_status.g.dart';

@HiveType(typeId: 1)
enum DeliveryStatus {
  @HiveField(0)
  delivered,
  @HiveField(1)
  pending,
  @HiveField(2)
  lost,
}
