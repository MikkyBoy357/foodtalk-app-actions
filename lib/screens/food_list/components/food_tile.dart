import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtalk/model/food_model.dart';
import 'package:foodtalk/utils/extensions/delivery_status_extension.dart';
import 'package:provider/provider.dart';

import '../../../view_models/food_provider.dart';
import 'add_food_sheet.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const FoodTile({
    Key? key,
    required this.food,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 65.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: AssetImage('assets/png/duck.png'),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          food.deliveryStatus != null
                              ? food.deliveryStatus!.valueAsString.toUpperCase()
                              : "UNKNOWN",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                InkWell(
                  child: Icon(Icons.edit_outlined),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return AddFoodSheet(
                          food: food,
                          isEdit: true,
                        );
                      },
                    );

                    Provider.of<FoodProvider>(context, listen: false)
                        .foodNameController
                        .text = food.name!;
                    Provider.of<FoodProvider>(context, listen: false)
                        .setFoodName(food.name);
                  },
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: onDelete,
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
