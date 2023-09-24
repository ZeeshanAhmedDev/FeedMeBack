import 'package:feedmeback/modules/questions/screens/reaction_question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/themes/theme.dart';
import '../../../widgets/AppBar/AppBar.dart';
import '../../../widgets/Buttons/choiceButton.dart';
import '../../../widgets/Buttons/colored_button.dart';
import '../../../widgets/ProgressBar/progressBar.dart';
import '../model/questionModel.dart';

class choiceQuestion extends StatefulWidget {
  const choiceQuestion({Key? key}) : super(key: key);

  @override
  _choiceQuestionState createState() => _choiceQuestionState();
}

class _choiceQuestionState extends State<choiceQuestion> {
  @override
  List<bool> mylist = [false, false, false, false];
  List<String> choice = ["Very Late", "Late", "As per time", "Very Quick"];
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
                    "Your Voices are being Heard",
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
    width: 0.9.sw,
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
          SizedBox(
            height: 500.h,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: choice.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 110.h,
                    child: Column(children: [
                      choice_Button(orientation, 368.w, choice[index], selected,
                          myList[index], () => onClickAction(index)),
                      SizedBox(height: 40.h),
                    ]),
                  );
                }),
          ),
          SizedBox(height: 20.h),
          colored_Button(orientation, 168.w, "Next", () {
            if (index < questions.length - 1) {
              index += 1;
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => reactionQuestion()));
            } else {
              index = 0;
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => reactionQuestion()));
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
          SizedBox(height: 50.h),
          SizedBox(
            height: 610.h,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: choice.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 140.h,
                    child: Column(children: [
                      choice_Button(orientation, 360.w, choice[index], selected,
                          myList[index], () => onClickAction(index)),
                      SizedBox(height: 20.h),
                    ]),
                  );
                }),
          ),
          colored_Button(orientation, 168.w, "Next", () {
            if (index < questions.length - 1) {
              index += 1;
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => reactionQuestion()));
            } else {
              index = 0;
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => reactionQuestion()));
            }
          }, active: selected),
          SizedBox(height: 50.h),
        ],
      ),
    ),
  );
}
