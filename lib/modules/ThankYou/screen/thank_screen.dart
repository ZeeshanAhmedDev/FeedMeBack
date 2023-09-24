import 'package:feedmeback/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/Buttons/colored_button.dart';
import '../../customer/Screens/feedback_space.dart';

//===================================Start
DateTime? currentBackPressTime;
Future<bool> onWillPop(BuildContext context) {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
    currentBackPressTime = now;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FeedbackSpaceScreen(),
        ));
    return Future.value(false);
  }
  return Future.value(true);
}
//===================================END

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Scaffold(
          // appBar: AppBar(),
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
                      SizedBox(
                        height: 37.h,
                      ),
                      Text(
                        "THANK YOU",
                        style: TextStyle(
                          fontSize: orientation == Orientation.portrait
                              ? 44.3.sp
                              : 35.sp,
                          fontWeight: FontWeight.w700,
                          color: Constants.kTextColour,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("Thanks for your Feedback. We ",
                          //
                          style: TextStyle(
                              color: Constants.kLightGreyColor,
                              fontSize: orientation == Orientation.portrait
                                  ? 17.sp
                                  : 30.sp)),
                      Text("will respond accordingly to your",
                          style: TextStyle(
                              color: Constants.kLightGreyColor,
                              fontSize: orientation == Orientation.portrait
                                  ? 17.sp
                                  : 30.sp)),
                      Text("Feedback",
                          style: TextStyle(
                              color: Constants.kLightGreyColor,
                              fontSize: orientation == Orientation.portrait
                                  ? 17.sp
                                  : 30.sp)),
                      SizedBox(
                        height: 30.h,
                      ),
                      Image.asset(
                        'assets/images/thank.png',
                        fit: BoxFit.contain,
                        width:
                            orientation == Orientation.portrait ? 368.w : 230.w,
                        height:
                            orientation == Orientation.portrait ? 182.h : 270.h,
                      ),
                      SizedBox(
                        height: orientation == Orientation.portrait
                            ? 190.13.h
                            : 50.h,
                      ),
                      colored_Button(
                          orientation,
                          orientation == Orientation.portrait ? 160.w : 90.w,
                          "Next", () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => FeedbackSpaceScreen()),
                            (Route<dynamic> route) => false);
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
