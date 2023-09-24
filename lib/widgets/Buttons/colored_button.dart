import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/themes/theme.dart';

Widget colored_Button(
    Orientation orientation, double width, String text, VoidCallback onpressed,
    {bool active = true}) {
  return Container(
    height: orientation == Orientation.portrait ? 50.sp : 100.sp,
    width: width,
    child: ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(10.sp),
        shadowColor: active
            ? MaterialStateProperty.all<Color>(Color(AppColor.lightgreen))
            : MaterialStateProperty.all<Color>(Color(AppColor.inactive)),
        backgroundColor: active
            ? MaterialStateProperty.all<Color>(Color(AppColor.lightgreen))
            : MaterialStateProperty.all<Color>(Color(AppColor.inactive)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                orientation == Orientation.portrait ? 32.sp : 64.sp),
          ),
        ),
      ),
      onPressed: active ? onpressed : () {},
      child: Text(
        text,
        style: TextStyle(
            fontSize: orientation == Orientation.portrait ? 21.sp : 40.sp),
      ),
    ),
  );
}
