import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtalk/model/food_model.dart';
import 'package:foodtalk/view_models/food_provider.dart';
import 'package:foodtalk/widgets/name_text_field.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_button.dart';

class AddFoodSheet extends StatelessWidget {
  final Food? food;
  final bool isEdit;

  const AddFoodSheet({
    Key? key,
    this.food,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, _) {
        return BottomSheet(
          enableDrag: true,
          onClosing: () {},
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      AppBar(
                        leading: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        title: Text(this.food?.name ?? 'Add Food'),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            NameTextField(
                              title: 'Food Name',
                              hintText: 'Rice',
                              controller: foodProvider.foodNameController,
                              onSaved: (val) {
                                foodProvider.setFoodName(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: CustomButton(
                      label: "SAVE",
                      onTap: () {
                        print('Is Edit => $isEdit');
                        if (food != null && isEdit == true) {
                          foodProvider.editFood(context, food!);
                        } else {
                          foodProvider.addFood(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
