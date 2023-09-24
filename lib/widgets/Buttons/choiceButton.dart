import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/themes/theme.dart';

Widget choice_Button(Orientation orientation, double width, String text,
    bool selected, bool iselected, VoidCallback onpressed) {
  return Container(
    height: orientation == Orientation.portrait ? 60.sp : 100.sp,
    width: width,
    child: ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0.sp),
          backgroundColor: selected
              ? !iselected
                  ? MaterialStateProperty.all<Color>(Color(AppColor.inactive))
                  : MaterialStateProperty.all<Color>(Color(0xFF49B3B3))
              : MaterialStateProperty.all<Color>(Colors.white),
          side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Color(AppColor.lightgreen))),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                orientation == Orientation.portrait ? 32.sp : 64.sp),
          ))),
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStyle(
            fontSize: orientation == Orientation.portrait ? 21.sp : 40.sp,
            fontWeight: FontWeight.w400,
            color: selected
                ? iselected
                    ? Colors.white
                    : Color(0xFF3F7A7A)
                : Color(AppColor.lightgreen)),
      ),
    ),
  );
}
