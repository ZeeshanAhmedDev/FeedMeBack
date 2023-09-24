import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:feedmeback/UpdatedNewModel/questions_model.dart';
import 'package:feedmeback/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../Provider.dart';
import '../../../Screens/InformationScreen/information_screen.dart';
import '../../../Services/auth_services.dart';
import '../../../utils/string_resource.dart';
import '../../../widgets/Buttons/colored_button.dart';

var companyID;
QuestionsModel _questionsModel = new QuestionsModel();

class welcomeView extends StatefulWidget {
  const welcomeView({Key? key}) : super(key: key);

  @override
  State<welcomeView> createState() => _welcomeViewState();
}

class _welcomeViewState extends State<welcomeView> {
  @override
  void initState() {
    getAllQuestions(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return DoubleBack(
          message: StringResource.pressAgainToClose,
          child: Scaffold(
              extendBodyBehindAppBar: true,
              body: Container(
                color: Colors.white,
                child: orientation == Orientation.portrait
                    ? potraitView(orientation, context)
                    : lanscapeView(orientation, context),
              )));
    });
  }
}

Widget potraitView(Orientation orientation, BuildContext context) {
  return Container(
    height: 1.sh,
    width: 1.sw,
    child: Column(
      children: [
        SizedBox(height: 180.h),
        SvgPicture.asset(
          Constants.kPizzaWelcomeSvg,
          height: 107.h,
          width: 215.w,
        ),
        SizedBox(height: 20.h),
        Text(StringResource.welcomeScreenHeadingText,
            style: TextStyle(fontSize: 28.sp)),
        SizedBox(height: 40.h),
        SvgPicture.asset(
          Constants.kJustWelcomeSvg,
          height: 105.h,
          width: 360.w,
        ),
        SizedBox(height: 30.h),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  Constants.kWelcomeComma1Svg,
                  height: 14.h,
                  width: 18.w,
                ),
                Text(
                  " We value your opinion. Please ",
                  style: TextStyle(fontSize: 22.sp, color: Colors.grey),
                ),
              ],
            ),
            Text(
              "give us 1-2 minutes. Your opinion",
              style: TextStyle(fontSize: 22.sp, color: Colors.grey),
            ),
            Text(
              "will help us in improving so that",
              style: TextStyle(fontSize: 22.sp, color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "we may serve you better. ",
                  style: TextStyle(fontSize: 22.sp, color: Colors.grey),
                ),
                SvgPicture.asset(
                  Constants.kWelcomeComma2Svg,
                  height: 14.h,
                  width: 18.w,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 160.h),
        colored_Button(
          orientation,
          173.w,
          StringResource.welcomeScreenBtnText,
          () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const InformationScreen()));
            // print(_questionsModel.data![index].first.questions[index].name);
          },
        )
      ],
    ),
  );
}

Widget lanscapeView(Orientation orientation, BuildContext context) {
  return Container(
    height: 1.sh,
    width: 1.sw,
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50.h),
          SvgPicture.asset(
            'assets/images/pizza.svg',
            height: 230.h,
            width: 253.w,
          ),
          SizedBox(height: 25.h),
          Text("Welcome to our outlet", style: TextStyle(fontSize: 43.sp)),
          SizedBox(height: 60.h),
          SvgPicture.asset(
            'assets/images/welcome.svg',
            height: 200.h,
            width: 360.w,
          ),
          SizedBox(height: 30.h),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/comma1.svg',
                    height: 14.h,
                    width: 18.w,
                  ),
                  Text(
                    " We value your opinion. Please ",
                    style: TextStyle(fontSize: 40.sp, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                "give us 1-2 minutes. Your opinion",
                style: TextStyle(fontSize: 40.sp, color: Colors.grey),
              ),
              Text(
                "will help us in improving so that",
                style: TextStyle(fontSize: 40.sp, color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "we may serve you better. ",
                    style: TextStyle(fontSize: 40.sp, color: Colors.grey),
                  ),
                  SvgPicture.asset(
                    'assets/images/comma2.svg',
                    height: 14.h,
                    width: 18.w,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 60.h),
          colored_Button(orientation, 123.w, "Start", () {}),
          SizedBox(height: 60.h),
        ],
      ),
    ),
  );
}

Future<void> getAllQuestions(BuildContext context) async {
  dynamic res = await ApiClient.getAllQuestionsOfSystem(context);

  if (res['status']) {
    print(res);

    _questionsModel = QuestionsModel.fromJson(res);
    Provider.of<DataProviders>(context, listen: false)
        .updateQuestionObject(_questionsModel);
  }
}
