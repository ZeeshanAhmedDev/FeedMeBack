import 'package:feedmeback/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/themes/theme.dart';

Widget textFeildPassword(
  String hint,
  double width,
  Orientation orientation, {
  required validatorr,
  required final controller,
  required Function() iconFunc,
  required bool passwordVisible,
  var focusNode,
}) {
  return SizedBox(
      width: width,
      child: TextFormField(
        inputFormatters: [
          Constants.disableEmojiFromTextField,
        ],
        focusNode: focusNode,
        obscuringCharacter: '•',
        obscureText: !passwordVisible,
        cursorColor: Color(AppColor.lightgreen),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validatorr,
        style: TextStyle(
            fontSize: orientation == Orientation.portrait ? 17.sp : 27.sp,
            color: Color(AppColor.lightgreen)),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () => iconFunc,
            child:
                Icon(passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Color(
                      AppColor.lightgreen,
                    )),
          ),

          hintText: hint,
          hintStyle: TextStyle(
              color: Color(AppColor.lightgreen),
              textBaseline: TextBaseline.alphabetic,
              fontSize: orientation == Orientation.portrait ? 17.sp : 27.sp),
          fillColor: Color(AppColor.feildColor),
          filled: true,
          // isDense: true,
          contentPadding: EdgeInsets.only(
            top: orientation == Orientation.portrait ? 18.h : 0,
            bottom: orientation == Orientation.portrait ? 18.h : 0,
            left: orientation == Orientation.portrait ? 27.w : 15.w,
          ),
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

          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              borderSide: BorderSide(
                width: 1.w,
                color: Colors.red,
              )),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            borderSide: BorderSide(
              width: 1.w,
              color: Colors.red,
            ),
          ),
        ),
      ));
}
