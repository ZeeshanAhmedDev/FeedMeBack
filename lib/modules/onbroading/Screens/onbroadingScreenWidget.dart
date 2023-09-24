import 'package:feedmeback/modules/auth/screens/signin_screen.dart';
import 'package:feedmeback/utils/string_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/themes/theme.dart';
import '../../../utils/constant.dart';

class onbroadingScreenWidget extends StatelessWidget {
  final VoidCallback increment;
  final String image;
  final String bar;
  final String title;
  final String text;
  const onbroadingScreenWidget(
      {Key? key,
      required this.image,
      required this.bar,
      required this.title,
      required this.text,
      required this.increment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? potraitView(
              orientation, bar, image, title, text, context, increment)
          : lanscapeView(
              orientation, bar, image, title, text, context, increment);
    });
  }
}

Widget potraitView(Orientation orientation, String bar, String image,
    String title, String text, BuildContext context, VoidCallback increment) {
  return Container(
    height: 1.sh,
    width: 1.sw,
    child: Center(
      child: Column(
        children: [
          SizedBox(height: bar != Constants.kRectangleBar3 ? 229.h : 269.h),
          SvgPicture.asset(
            image,
            height: bar == Constants.kRectangleBar3 ? 180.h : 226.h,
            width: orientation == Orientation.portrait ? 374.w : 255.w,
          ),
          SizedBox(
            height: 30.h,
          ),
          SvgPicture.asset(bar),
          SizedBox(
            height: 35.h,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(110.h),
                ),
                color: Color(AppColor.lightgreen),
              ),
              height: 365.h,
              width: 1.sw,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 46.w, right: 46.w, top: 76.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.sp,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Text(
                          text,
                          maxLines: 4,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 55.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignInScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: bar != Constants.kRectangleBar3
                                ? Text(StringResource.skipNow,
                                    style: TextStyle(
                                        fontSize: 17.sp, color: Colors.white))
                                : SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                          ),
                        ),
                        InkWell(
                          onTap: bar != Constants.kRectangleBar3
                              ? increment
                              : () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SignInScreen()));
                                },
                          child: SvgPicture.asset(
                            Constants.kArrowImageSvg,
                            fit: BoxFit.contain,
                            height: 100.h,
                            width: 110.w,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget lanscapeView(Orientation orientation, String bar, String image,
    String title, String text, BuildContext context, VoidCallback increment) {
  return Container(
    height: 1.sh,
    width: 1.sw,
    child: Center(
      child: Column(
        children: [
          SizedBox(height: bar != Constants.kRectangleBar3 ? 90.h : 165.h),
          SvgPicture.asset(
            image,
            height: bar == Constants.kRectangleBar3 ? 240.h : 330.h,
            width: 255.w,
          ),
          SizedBox(
            height: 30.h,
          ),
          SvgPicture.asset(bar),
          SizedBox(
            height: 35.h,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(110.h),
                ),
                color: Color(AppColor.lightgreen),
              ),
              width: 1.sw,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 60.w, right: 60.w, top: 70.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.sp,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Text(
                          text,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 28.sp, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 55.w, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignInScreen()));
                          },
                          child: bar != Constants.kRectangleBar3
                              ? Text(StringResource.skipNow,
                                  style: TextStyle(
                                      fontSize: 31.sp, color: Colors.white))
                              : SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                        ),
                        InkWell(
                          onTap: bar != Constants.kRectangleBar3
                              ? increment
                              : () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SignInScreen()));
                                },
                          child: SvgPicture.asset(
                            Constants.kArrowImageSvg,
                            fit: BoxFit.contain,
                            height: 145.h,
                            width: 110.w,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
