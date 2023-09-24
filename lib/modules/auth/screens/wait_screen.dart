import 'package:feedmeback/modules/auth/screens/signin_screen.dart';
import 'package:flutter/services.dart';
import '../../../widgets/Buttons/colored_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class waitScreen extends StatelessWidget {
  const waitScreen({Key? key}) : super(key: key);

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
    return OrientationBuilder(builder: (context, orientation) {
      return WillPopScope(
        onWillPop: () => onWillPop(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  Brightness.dark, // For Android (dark icons)
            ),
          ),
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
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 165.h,
                      ),
                      Image.asset(
                        'assets/images/email1.gif',
                        fit: BoxFit.contain,
                        width:
                            orientation == Orientation.portrait ? 182.w : 230.w,
                        height:
                            orientation == Orientation.portrait ? 182.h : 270.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("Your request has been received",
                          style: TextStyle(
                              fontSize: orientation == Orientation.portrait
                                  ? 17.sp
                                  : 30.sp)),
                      Text(" successfully. You will be contacted",
                          style: TextStyle(
                              fontSize: orientation == Orientation.portrait
                                  ? 17.sp
                                  : 30.sp)),
                      Text(" for further proceedings.",
                          style: TextStyle(
                              fontSize: orientation == Orientation.portrait
                                  ? 17.sp
                                  : 30.sp)),
                      SizedBox(
                        height:
                            orientation == Orientation.portrait ? 24.h : 50.h,
                      ),
                      colored_Button(
                          orientation,
                          orientation == Orientation.portrait ? 160.w : 90.w,
                          "Go Back", () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                        // Navigator.pop(context);
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
