import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/themes/theme.dart';

Widget next_Button(
    Orientation orientation, BuildContext context, VoidCallback onpresseed) {
  return Container(
    height: orientation == Orientation.portrait ? 50.sp : 100.sp,
    width: orientation == Orientation.portrait ? 160.sp : 330.sp,
    child: ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(10.sp),
        backgroundColor:
            MaterialStateProperty.all<Color>(Color(AppColor.white)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                orientation == Orientation.portrait ? 32.sp : 64.sp),
          ),
        ),
      ),
      onPressed: onpresseed,
      child: Text(
        "NEXT",
        style: TextStyle(
            fontSize: orientation == Orientation.portrait ? 21.sp : 40.sp,
            color: Color(AppColor.lightgreen)),
      ),
    ),
  );
}
