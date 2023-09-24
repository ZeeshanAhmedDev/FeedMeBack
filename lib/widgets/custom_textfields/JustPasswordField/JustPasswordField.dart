import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/themes/theme.dart';
import '../../../utils/constant.dart';

class JustPasswordField extends StatefulWidget {
  const JustPasswordField({
    Key? key,
    required this.hint,
    required this.validatorr,
    required this.controller,
  }) : super(key: key);

  final String hint;
  final validatorr;
  final controller;

  @override
  State<JustPasswordField> createState() => _JustPasswordFieldState();
}

class _JustPasswordFieldState extends State<JustPasswordField> {
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        Constants.disableEmojiFromTextField,
      ],
      obscuringCharacter: '•',
      obscureText: passwordVisible,
      cursorColor: Color(AppColor.lightgreen),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      validator: widget.validatorr,
      style: TextStyle(fontSize: 17.sp, color: Color(AppColor.lightgreen)),
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            passwordVisible = !passwordVisible;
            setState(() {});
          },
          child: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility,
              color: Color(
                AppColor.lightgreen,
              )),
        ),

        hintText: widget.hint,
        hintStyle: TextStyle(
            color: Color(AppColor.lightgreen),
            textBaseline: TextBaseline.alphabetic,
            fontSize: 17.sp),
        fillColor: Color(AppColor.feildColor),
        filled: true,
        // isDense: true,
        contentPadding: EdgeInsets.only(
          top: 18.h,
          bottom: 18.h,
          left: 27.w,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(AppColor.lightgreen)),
          borderRadius: BorderRadius.circular(15.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Color(AppColor.lightgreen)),
          borderRadius: BorderRadius.circular(15.sp),
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
    );
  }
}
