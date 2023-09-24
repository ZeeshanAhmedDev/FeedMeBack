import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/themes/theme.dart';
import '../../../widgets/AppBar/AppBar.dart';
import '../../../widgets/Buttons/colored_button.dart';
import '../../../widgets/ProgressBar/progressBar.dart';
import '../model/questionModel.dart';
import 'choice_question.dart';

class reactionQuestion extends StatefulWidget {
  const reactionQuestion({Key? key}) : super(key: key);

  @override
  _reactionQuestionState createState() => _reactionQuestionState();
}

class _reactionQuestionState extends State<reactionQuestion> {
  @override
  List<bool> mylist = [false, false, false, false, false];
  List<String> choice = ["Wonderful", "Good", "Average", "Not Good", "Worst"];
  bool selected = false;

  void select(int index) {
    print("pressed");
    selected = true;
    for (int i = 0; i < mylist.length; i++) {
      mylist[i] = false;
    }
    mylist[index] = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return SafeArea(
          child: Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  floating: true,
                  centerTitle: true,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  title: Text(
                    "We Are Empowering You",
                    style: TextStyle(
                        color: Color(AppColor.lightgreen),
                        fontSize: orientation == Orientation.portrait
                            ? 23.sp
                            : 39.sp),
                  ),
                  elevation: 0,
                  leading: popup(context),
                  forceElevated: innerBoxIsScrolled,
                ),
              ];
            },
            body: Container(
                alignment: Alignment.topCenter,
                color: Colors.white,
                child: orientation == Orientation.portrait
                    ? potraitView(
                        orientation, context, choice, selected, mylist, select)
                    : landscapeView(orientation, context, choice, selected,
                        mylist, select))),
      ));
    });
  }
}

Widget potraitView(
    Orientation orientation,
    BuildContext context,
    List<String> choice,
    bool selected,
    List<bool> myList,
    Function(int) onClickAction) {
  return Container(
    height: 1.sh,
    width: 1.sw,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          progressBar(index, questions.length),
          SizedBox(height: 50.h),
          Text(
            questions[index].question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30.sp,
            ),
            maxLines: 2,
          ),
          SizedBox(
            height: 50.h,
          ),
          SvgPicture.asset(
            'assets/images/internet.svg',
            height: 300.h,
            width: 300.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            child: Container(
              height: 100.h,
              width: 0.95.sw,
              child: Center(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: choice.length,
                    //  shrinkWrap: true,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            child: Container(
                              height: myList[index] ? 95.h : 75.h,
                              width: 0.15.sw,
                              child: Card(
                                color: myList[index]
                                    ? index == 4
                                        ? Color(0xFFD01515)
                                        : Color(0xFFFF9852)
                                    : Colors.white,
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.01.sw, vertical: 3.h),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/' +
                                            choice[index] +
                                            '.png',
                                      ),
                                      myList[index]
                                          ? Text(choice[index],
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.white,
                                              ))
                                          : SizedBox(
                                              height: 0,
                                              width: 0,
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () => onClickAction(index),
                        ),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          colored_Button(orientation, 168.w, "Next", () {
            if (index < questions.length - 1) {
              index += 1;
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => choiceQuestion()));
            } else {
              index = 0;
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => choiceQuestion()));
            }
          }, active: selected)
        ],
      ),
    ),
  );
}

Widget landscapeView(
    Orientation orientation,
    BuildContext context,
    List<String> choice,
    bool selected,
    List<bool> myList,
    Function(int) onClickAction) {
  return Container(
    height: 1.sh,
    width: 0.9.sw,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          progressBar(index, questions.length),
          SizedBox(height: 50.h),
          Text(
            questions[index].question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 39.sp,
            ),
            maxLines: 2,
          ),
          SizedBox(
            height: 50.h,
          ),
          SvgPicture.asset(
            'assets/images/internet.svg',
            height: 400.h,
            width: 400.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            child: Container(
              height: 200.h,
              width: 0.95.sw,
              child: Center(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: choice.length,
                    //  shrinkWrap: true,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            child: Container(
                              height: myList[index] ? 200.h : 180.h,
                              width: 0.12.sw,
                              child: Card(
                                color: myList[index]
                                    ? index == 4
                                        ? Color(0xFFD01515)
                                        : Color(0xFFFF9852)
                                    : Colors.white,
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.01.sw, vertical: 3.h),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/' +
                                            choice[index] +
                                            '.png',
                                      ),
                                      myList[index]
                                          ? Text(choice[index],
                                              style: TextStyle(
                                                fontSize: 30.sp,
                                                color: Colors.white,
                                              ))
                                          : SizedBox(
                                              height: 0,
                                              width: 0,
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () => onClickAction(index),
                        ),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          colored_Button(orientation, 168.w, "Next", () {
            if (index < questions.length - 1) {
              index += 1;
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => choiceQuestion()));
            } else {
              index = 0;
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => choiceQuestion()));
            }
          }, active: selected),
          SizedBox(height: 50.h),
        ],
      ),
    ),
  );
}
