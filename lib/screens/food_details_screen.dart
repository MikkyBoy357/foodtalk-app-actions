import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtalk/utils/extensions/delivery_status_extension.dart';
import 'package:foodtalk/widgets/custom_button.dart';

import '../model/food_model.dart';

class FoodDetailsScreen extends StatelessWidget {
  final Food food;

  const FoodDetailsScreen({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DETAIL'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Center(
              child: CircleAvatar(
                radius: 70.r,
                backgroundImage: AssetImage('assets/png/duck.png'),
              ),
            ),
            SizedBox(height: 20.h),
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                DetailTile(
                  title: 'NAME',
                  subtitle: food.name.toString(),
                ),
                DetailTile(
                  title: "DELIVERY STATUS",
                  subtitle: food.deliveryStatus != null
                      ? food.deliveryStatus!.valueAsString.toUpperCase()
                      : "UNKNOWN",
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomButton(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        label: 'BACK',
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const DetailTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 5.r,
            backgroundColor: Color(0xFF15FF57),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
