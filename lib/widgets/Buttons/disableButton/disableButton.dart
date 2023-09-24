import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/themes/theme.dart';

class disableNextButton extends StatelessWidget {
  const disableNextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        height: 50.sp,
        width: 160.w,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(10.sp),
            shadowColor:
                MaterialStateProperty.all<Color>(Color(AppColor.inactive)),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(AppColor.inactive)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.sp),
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            'Next',
            style: TextStyle(fontSize: 21.sp),
          ),
        ),
      ),
    );
  }
}
