import 'package:feedmeback/modules/auth/screens/signin_screen.dart';
import 'package:feedmeback/utils/constant.dart';
import 'package:feedmeback/utils/string_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/Buttons/colored_button.dart';

class emailScreen extends StatelessWidget {
  const emailScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    //===================================Start
    DateTime? currentBackPressTime;
    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
        currentBackPressTime = now;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(),
            ));
        return Future.value(false);
      }
      return Future.value(true);
    }
    //===================================END

    return OrientationBuilder(
      builder: (context, orientation) {
        return SafeArea(
          child: WillPopScope(
            onWillPop: () => onWillPop(),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: 1.sh,
                  width: 1.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Constants.kEmailSenTGif,
                            fit: BoxFit.contain,
                            width: orientation == Orientation.portrait
                                ? 182.w
                                : 230.w,
                            height: orientation == Orientation.portrait
                                ? 182.h
                                : 270.h,
                          ),
                          SizedBox(
                            height: 37.h,
                          ),
                          Text(
                            StringResource.emailSentTxt,
                            style: TextStyle(
                                fontSize: orientation == Orientation.portrait
                                    ? 23.sp
                                    : 35.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(StringResource.emailSentTxtSubtext1,
                              style: TextStyle(
                                  fontSize: orientation == Orientation.portrait
                                      ? 17.sp
                                      : 30.sp)),
                          Text(StringResource.emailSentTxtSubtext2,
                              style: TextStyle(
                                  fontSize: orientation == Orientation.portrait
                                      ? 17.sp
                                      : 30.sp)),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? 24.h
                                : 50.h,
                          ),
                          colored_Button(
                              orientation,
                              orientation == Orientation.portrait
                                  ? 160.w
                                  : 90.w,
                              StringResource.goBackBtnTxt, () {
                            // Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ));
                          }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
