import 'package:feedmeback/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/themes/theme.dart';

Widget textField(
  String hint,
  double width,
  Orientation orientation, {
  isCenter = false,
  required validatorr,
  required final controller,
  var keyboardType,
  required final maximumLength,
  var suffixtextt,
  var focusNode,
}) {
  return SizedBox(
    width: width,
    child: TextFormField(
      inputFormatters: [
        Constants.disableEmojiFromTextField,
      ],
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLength: maximumLength,
      controller: controller,
      validator: validatorr,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Color(AppColor.lightgreen),
      style: TextStyle(
          fontSize: orientation == Orientation.portrait ? 17.sp : 27.sp,
          color: Color(AppColor.lightgreen)),
      decoration: InputDecoration(
        counterText: '',
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          borderSide: BorderSide(
            width: 1.w,
            color: Colors.red,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          borderSide: BorderSide(
            width: 1.w,
            color: Colors.red,
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(
            color: Color(AppColor.lightgreen),
            textBaseline: TextBaseline.alphabetic,
            fontSize: orientation == Orientation.portrait ? 17.sp : 27.sp),
        fillColor: Color(AppColor.feildColor),
        filled: true,

        // isDense: true,
        contentPadding: isCenter == false
            ? EdgeInsets.only(
                top: orientation == Orientation.portrait ? 18.h : 0,
                bottom: orientation == Orientation.portrait ? 18.h : 0,
                left: orientation == Orientation.portrait ? 27.w : 15.w,
              )
            : EdgeInsets.only(top: 0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(AppColor.lightgreen)),
          borderRadius: BorderRadius.circular(
              orientation == Orientation.portrait ? 15.sp : 25.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Color(AppColor.lightgreen)),
          borderRadius: BorderRadius.circular(
              orientation == Orientation.portrait ? 15.sp : 25.sp),
        ),
      ),
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
    ),
  );
}
