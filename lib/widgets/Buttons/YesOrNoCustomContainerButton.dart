import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomYesOrNoButton extends StatelessWidget {
  final BoxShadow boxShadow;
  final double myWidth;
  final double myHeight;
  final Color textColour;
  final String btnText;
  final LinearGradient myGradient;
  final Function() onTapFunc;

  const CustomYesOrNoButton({
    Key? key,
    required this.boxShadow,
    required this.myWidth,
    required this.myHeight,
    required this.textColour,
    required this.btnText,
    required this.myGradient,
    required this.onTapFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunc,
      child: Container(
        height: myHeight.h,
        width: myWidth.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: containerColour,
          borderRadius: BorderRadius.all(
            Radius.circular(27.r),
          ),
          gradient: myGradient,

          boxShadow: [boxShadow],
        ),
        child: Text(
          btnText,
          style: TextStyle(
            color: textColour,
            fontFamily: 'Gilroy-Bold',
            fontSize: 20.66.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
