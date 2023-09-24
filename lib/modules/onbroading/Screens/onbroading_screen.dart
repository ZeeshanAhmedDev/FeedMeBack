import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:feedmeback/utils/constant.dart';
import 'package:feedmeback/utils/string_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'onbroadingScreenWidget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController? controller;

  @override
  void initState() {
    super.initState();
    controller = new PageController();
  }

  int slideIndex = 0;

  void increment() {
    controller!.animateToPage(slideIndex + 1,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  void decrement() {
    controller!.animateToPage(slideIndex - 1,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: DoubleBack(
        message: StringResource.pressAgainToClose,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: OrientationBuilder(
            builder: (context, orientation) {
              return Container(
                  height: 1.sh,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        slideIndex = index;
                      });
                    },
                    children: <Widget>[
                      onbroadingScreenWidget(
                        image: Constants.kOnBoardingImage1,
                        bar: Constants.kRectangleBar1,
                        title: StringResource.onBoardingTitle1,
                        text: StringResource.onBoardingText1,
                        increment: increment,
                      ),
                      onbroadingScreenWidget(
                        image: Constants.kOnBoardingImage2,
                        bar: Constants.kRectangleBar2,
                        title: StringResource.onBoardingTitle2,
                        text: StringResource.onBoardingText2,
                        increment: increment,
                      ),
                      onbroadingScreenWidget(
                        image: Constants.kOnBoardingImage3,
                        bar: Constants.kRectangleBar3,
                        title: StringResource.onBoardingTitle3,
                        text: StringResource.onBoardingText3,
                        increment: increment,
                      ),
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
