import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Widget? child;
  final EdgeInsetsGeometry? margin;

  const CustomButton({
    Key? key,
    required this.onTap,
    this.label = 'Button',
    this.child,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: margin,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: child ??
            Center(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
      ),
    );
  }
}
