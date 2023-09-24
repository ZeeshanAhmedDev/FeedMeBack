import 'dart:core';
import 'dart:developer';
import 'package:feedmeback/config/themes/theme.dart';
import 'package:feedmeback/modules/ThankYou/screen/thank_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:im_stepper/stepper.dart';
import 'package:shimmer/shimmer.dart';
import '../UpdatedNewModel/questions_model.dart';
import '../modules/welcome/Screens/welcome_screen.dart';
import '../utils/constant.dart';
import '../utils/controllers.dart';
import '../utils/helper.dart';
import '../utils/string_resource.dart';
import '../widgets/Buttons/choiceButton.dart';
import '../widgets/Buttons/colored_button.dart';
import '../widgets/LogoutDialog/logout_dialog.dart';

QuestionsModel _questionsModel = new QuestionsModel();

ControllersTextFieldsClass _controllersTextFieldsClass =
    ControllersTextFieldsClass();

bool isEmojiButtonIsEnabled = false;
bool isRatingsButtonIsEnabled = false;
bool isMCQSButtonIsEnabled = false;

var AnswerIdMcq;
var myIndex;
var showAnswerID;
var temp = 0;

//===================================Start
DateTime? currentBackPressTime;
Future<bool> onWillPop(BuildContext context) {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
    currentBackPressTime = now;
    GlassMorphismDialog.showPromptForTogoBackToFeedBackId(context);

    return Future.value(false);
  }
  return Future.value(true);
}
//===================================END

bool selected = false;

class StepperScreen extends StatefulWidget {
  const StepperScreen({Key? key}) : super(key: key);

  @override
  _StepperScreenState createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  // Create a late instance variable and assign your `Future` to it.
  // late Future? myFuture = getQuestionaries();

  final _formKey = GlobalKey<FormState>();
  List<String> choice = Helper.getMCQSQuestionsText;
  List<bool> mylist = [false, false, false, false];

  void select(int index) {
    print("pressed");
    selected = true;
    for (int i = 0; i < mylist.length; i++) {
      mylist[i] = false;
    }
    mylist[index] = true;
    setState(() {});
  }

  Widget StepperZero() {
    return potraitView(
        Orientation.portrait, context, choice, selected, mylist, select);
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
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 500.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Helper.getMCQSQuestionsText.length,

                  // itemCount: choice.length,
                  // itemCount: myList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 100.h,
                      child: Column(
                        children: [
                          choice_Button(
                            orientation,
                            368.w,
                            choice[index],
                            selected,
                            myList[index],
                            () {
                              onClickAction(index);
                              setState(() {
                                final looh =
                                    myIndex.toString().indexOf(showAnswerID);
                                log(looh.toString());
                              });
                            },
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }

  bool enableStepsTapping = false;

  //======================================
  int activeStep = 0; // Initial step set to 6.
  List<int> _number = [];
  double _currentSliderValue = 1;
  String? checkDescriptionData;
  String? checkYesOrNo;
  String? EmojiReactionName;

  int questionIndex = 0, indexImages = 0, intWidget = 0;
  double? rating;
  double? customSizedBox;

  changeCustomSizedBoxValue({required double value}) {
    Future.delayed(Duration.zero, () async {
      customSizedBox = value;
    });
  }

  bool angry = false;
  bool sad = false;
  bool neutral = false;
  bool happy = false;
  bool exited = false;

  @override
  void initState() {
    setState(() {
      selected = false;
      rating = 0.0;
      EmojiReactionName = "";
    });

    // Assign that variable your Future.
    //----------------------------------------------------------getImagesOfEmoji
    // getImagesOfEmojis();
    //----------------------------------------------------------getImagesOfEmoji
    // myFuture = getQuestionaries();

    Helper.isYesBtnClicked = false;
    Helper.isNoBtnClicked = false;
    angry = false;
    sad = false;
    neutral = false;
    happy = false;
    exited = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              borderRadius: BorderRadius.circular(30.r),
              onLongPress: () =>
                  GlassMorphismDialog.showPromptForTogoBackToFeedBackId(
                      context),
              onTap: () => GlassMorphismDialog.showPromptForLogout(context),
              child: Icon(
                Icons.more_vert,
                color: Colors.black54,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: AnswerIdMcq != null
                ? Text(
                    "ds",
                    style: TextStyle(
                        color: Color(AppColor.lightgreen), fontSize: 23.sp),
                  )
                : SizedBox(
                    width: 200.0.w,
                    height: 100.0.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[400]!,
                      child: Container(
                        width: 100.w,
                      ),
                    ),
                  ),
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Colors.transparent,

              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.dark, // For Android (dark icons)
              // statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
          ),
          body: FutureBuilder(
              future: getAllQuestions(context),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    width: 1.sw,
                    height: 1.sh,
                    color: Colors.transparent,
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: 1.sw,
                        color: Colors.transparent,
                      ),
                    ),
                  );
                } else {
                  return Container(
                      color: Colors.transparent,
                      width: 1.sw,
                      height: 1.sh,
                      child: Column(children: [
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   // log("${Helper.rowNumber.first - 1}");
                            //   if (Helper.rowNumber.first - 1 == 0) {
                            //     log("I am Number 0 Stepper");
                            //
                            //     log("sorry " + activeStep.toString());
                            //   }

                            // if (activeStep >= temp && enableStepsTapping) {
                            //   setState(() {
                            //     temp = activeStep;
                            //     enableStepsTapping = false;
                            //     activeStep = temp + 1;
                            //     questionIndex = temp + 1;
                            //     intWidget = temp + 1;
                            //     log("sorry if second " + activeStep.toString());
                            //   });
                            // } else if (activeStep > 0 && activeStep > temp) {
                            //   enableStepsTapping = true;
                            //   temp = activeStep;
                            //   activeStep = temp - 1;
                            //   questionIndex = temp - 1;
                            //   intWidget = temp - 1;
                            //   log("sorry else if second " +
                            //       activeStep.toString());
                            // } else {
                            //   enableStepsTapping = false;
                            //
                            //   temp = 0;
                            //   activeStep = 0;
                            //   questionIndex = 0;
                            //   intWidget = 0;
                            //   log("sorry if second " + activeStep.toString());
                            // }
                          },
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                            onNotification:
                                (OverscrollIndicatorNotification overScroll) {
                              overScroll.disallowIndicator();
                              return true;
                            },
                            child: NumberStepper(
                              numbers: Helper.rowNumber,
                              activeStep: activeStep,
                              lineDotRadius: 1.2.r,
                              activeStepBorderColor: Constants.kStepperColor,
                              activeStepBorderWidth: 2.w,
                              stepColor: Constants.kStepperColor,
                              stepRadius: 30.r,
                              lineColor: Constants.kStepperColor,
                              enableNextPreviousButtons: false,
                              stepReachedAnimationEffect: Curves.easeOutExpo,
                              activeStepBorderPadding: 3,
                              enableStepTapping: true,
                              numberStyle: TextStyle(
                                fontFamily: 'Gilroy-Bold',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              activeStepColor: Constants.kStepperColor,
                              onStepReached: (index) {
                                setState(
                                  () {
                                    setState(() {
                                      activeStep = index;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: Helper.rowNumber.first,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      SizedBox(height: 15.h),
                                      Container(
                                        width: 1.sw,
                                        child:

                                            /*     Helper.listFModel[questionIndex]
                                                    .question !=
                                                null
                                            ? */

                                            Text(
                                          // '''${Helper.listFModel[questionIndex].question}''',
                                          '''4444''',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 22.sp,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.visible,
                                        ),
                                        // : SizedBox(),
                                        alignment: Alignment.center,
                                      ),
                                      SizedBox(height: 0.02.sh),
                                      Container(
                                        // color: Colors.red,
                                        width: 1.sw,
                                        child: SvgPicture.asset(
                                          'assets/svg/suggestion vector.svg',
                                          fit: BoxFit.contain,
                                          height: 300.h,
                                        ),
                                        // Helper.listFModel[indexImages]
                                        //             .image !=
                                        //         null
                                        //     ?

                                        /*    SvgPicture.network(
                                                '${Api.baseUrl.replaceAll("/api/", '') + Helper.listFModel[indexImages].image.toString()}',
                                                fit: BoxFit.contain,
                                                height: 250.h,
                                              ),*/
                                        /*      : SvgPicture.asset(
                                                'assets/svg/suggestion vector.svg',
                                                fit: BoxFit.contain,
                                                height: 300.h,
                                              ),*/
                                        alignment: Alignment.center,
                                      ),
                                      /* Helper.listFModel[index].typesName ==
                                              'Level Slider'
                                          ? SizedBox(
                                              height: 20.h,
                                            )
                                          : Helper.listFModel[index]
                                                      .typesName ==
                                                  'Discriptive'
                                              ? SizedBox(
                                                  height: 0.h,
                                                )
                                              : SizedBox(
                                                  height: 40.h,
                                                ),*/
                                      // _listOfWidgets(intWidget),
                                      /*   Helper.listFModel[index].typesName ==
                                              'Level Slider'
                                          ? SizedBox(
                                              height: 70.h,
                                            )
                                          : Helper.listFModel[index]
                                                      .typesName ==
                                                  'Discriptive'
                                              ? SizedBox(
                                                  height: 0.h,
                                                )
                                              : SizedBox(height: 80.h),*/
                                      selected == true
                                          ? colored_Button(
                                              Orientation.portrait,
                                              160.w,
                                              StringResource.nextButtonTxt, () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                ///
                                                Helper.isNoBtnClicked = false;
                                                Helper.isYesBtnClicked = false;
                                                _controllersTextFieldsClass
                                                    .descriptionStepperScreenController
                                                    .clear();

                                                Helper.rowNumber.length - 1 ==
                                                        questionIndex
                                                    ? Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ThankYouScreen(),
                                                        ))
                                                    : log("Sorry Error");
                                                // CustomerReplyMethod(index);
                                                setState(() {
                                                  // activeStep++;
                                                  // questionIndex++;
                                                  // indexImages++;
                                                  // intWidget++;
                                                });
                                              }
                                            })
                                          : SizedBox(),
                                      // Helper.listFModel[index].typesName ==
                                      //         'MCQs'
                                      //     ? colored_Button(
                                      //         Orientation.portrait,
                                      //         160.w,
                                      //         StringResource.nextButtonTxt, () {
                                      //         if (_formKey.currentState!
                                      //             .validate()) {
                                      //           ///
                                      //           Helper.isNoBtnClicked = false;
                                      //           Helper.isYesBtnClicked = false;
                                      //           _controllersTextFieldsClass
                                      //               .descriptionStepperScreenController
                                      //               .clear();
                                      //
                                      //           Helper.rowNumber.length - 1 ==
                                      //                   questionIndex
                                      //               ? Navigator.push(
                                      //                   context,
                                      //                   MaterialPageRoute(
                                      //                     builder: (context) =>
                                      //                         ThankYouScreen(),
                                      //                   ))
                                      //               : log("Sorry Error");
                                      //           CustomerReplyMethod(index);
                                      //           setState(() {
                                      //             // activeStep++;
                                      //             // questionIndex++;
                                      //             // indexImages++;
                                      //             // intWidget++;
                                      //           });
                                      //         }
                                      //       })
                                      //     : SizedBox(),
                                      SizedBox(
                                        height: 40.h,
                                      ),
                                    ],
                                  );
                                })),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     // previousButton(),
                        //     // nextButton(),
                        //   ],
                        // ),
                      ]));
                }
              }),
        ),
      ),
    );
  }

  // /// Returns the next button.
  // Widget nextButton() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       // Increment activeStep, when the next button is tapped. However, check for upper bound.
  //       if (activeStep < upperBound) {
  //         // if (activeStep < int.parse(upperBound)){
  //         setState(() {
  //           // enableStepsTapping = true;
  //           activeStep++;
  //           questionIndex++;
  //           intWidget++;
  //           activeStep++;
  //         });
  //       }
  //     },
  //     child: Text('Next'),
  //   );
  // }
  //
  // /// Returns the previous button.
  // Widget previousButton() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
  //       if (activeStep > 1) {
  //         setState(() {
  //           log('kdsjvfj');
  //
  //           activeStep--;
  //           questionIndex--;
  //           intWidget--;
  //           activeStep--;
  //         });
  //       }
  //     },
  //     child: Text('Prev'),
  //   );
  // }

/*  _listOfWidgets<Widget>(int index) {
    if (Helper.listFModel[index].typesName == 'Level Slider') {
      return Container(
        width: 1.sw,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Color(0xff1E6F6F),
            inactiveTrackColor: Color(0xff49B3B3).withOpacity(0.7),
            trackShape: RoundedRectSliderTrackShape(),
            trackHeight: 8.0.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0.r),
            thumbColor: Color(0xff1E6F6F),
            overlayColor: Color(0xff49B3B3).withOpacity(0.7),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0.r),
            tickMarkShape: RoundSliderTickMarkShape(),
            activeTickMarkColor: Color(0xff1E6F6F),
            inactiveTickMarkColor: Colors.transparent,
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Color(0xff1E6F6F),
            valueIndicatorTextStyle: TextStyle(
              color: Color(0xffFFFFFF),
            ),
          ),
          child: Slider(
            value: _currentSliderValue,
            max: 10,
            divisions: 10,
            min: 1,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
                log(_currentSliderValue.toString());
              });
            },
          ),
        ),
      );
    } else if (Helper.listFModel[index].typesName == 'Polar') {
      return Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// No Button
          Padding(
            padding: EdgeInsets.only(left: 50.w),
            child: CustomYesOrNoButton(
              // btnText: StringResource.noButton,
              btnText: Helper.getCompanyPolarQuestionnaireList[1] != null
                  ? Helper.getCompanyPolarQuestionnaireList[1]
                  : "...",
              textColour: Helper.isNoBtnClicked != true
                  ? Constants.kRedColor
                  : Constants.kWhiteColor,
              onTapFunc: () {
                Helper.isNoBtnClicked = true;
                Helper.isYesBtnClicked = false;
                checkYesOrNo = "No";
                setState(() {});
              },
              myGradient: Helper.isNoBtnClicked != true
                  ? LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.red.shade100.withOpacity(0.3),
                        Colors.red.shade100.withOpacity(0.3)
                      ],
                    )
                  : LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xffD43030).withOpacity(0.8),
                        Color(0xffD43030),
                      ],
                    ),
              myHeight: 54.h,
              myWidth: 140.w,
              boxShadow: Helper.isNoBtnClicked == true
                  ? BoxShadow(
                      color: Color(0xffDD7272),
                      blurRadius: 8,
                      offset: Offset(0, 4), // Shadow position
                    )
                  : BoxShadow(
                      color: Colors.transparent,
                    ),
            ),
          ),

          /// YES Button
          Padding(
            padding: EdgeInsets.only(left: 70.w),
            child: CustomYesOrNoButton(
              // btnText: StringResource.yesButton,
              btnText: Helper.getCompanyPolarQuestionnaireList[0],
              textColour: Helper.isYesBtnClicked != true
                  ? Colors.green
                  : Constants.kWhiteColor,
              onTapFunc: () {
                Helper.isYesBtnClicked = true;
                Helper.isNoBtnClicked = false;
                checkYesOrNo = "Yes";
                setState(() {});
              },
              myGradient: Helper.isYesBtnClicked != true
                  ? LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.green.withOpacity(0.1),
                        Colors.green.withOpacity(0.1)
                      ],
                    )
                  : LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff67C081).withOpacity(0.85),
                        Color(0xff67C081),
                      ],
                    ),
              myHeight: 54.h,
              myWidth: 140.w,
              boxShadow: Helper.isYesBtnClicked == true
                  ? BoxShadow(
                      color: Color(0xff34834B),
                      blurRadius: 9,
                      offset: Offset(0, 4), // Shadow position
                    )
                  : BoxShadow(
                      color: Colors.transparent,
                    ),
            ),
          ),
        ],
      );
    } else if (Helper.listFModel[index].typesName == 'Emoji') {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ///worst
              GestureDetector(
                onTap: () {
                  log('angry');
                  EmojiReactionName = "Worst";
                  angry = true;
                  sad = false;
                  neutral = false;
                  happy = false;
                  exited = false;
                  isEmojiButtonIsEnabled = true;
                  setState(() {});
                },
                child: Container(
                    height: angry != true ? 80.h : 90.h,
                    width: 0.15.sw,
                    child: Card(
                      color: angry != true
                          ? Constants.kWhiteColor
                          : Constants.kAngryColor,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0.r),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.01.sw, vertical: 3.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Helper.emojiPics
                            // _emojiPicsNames
                            GestureDetector(
                              // child: CachedNetworkImage(
                              //   imageUrl:
                              //       Api.baseUrl.replaceAll('api/', '') +
                              //           Helper.emojiPics[0],
                              //   placeholder: (context, url) =>
                              //       CircularProgressIndicator(),
                              //   errorWidget: (context, url, error) =>
                              //       Icon(Icons.error),
                              // ),
                              child: Image.network(
                                '${Api.baseUrl.replaceAll("/api/", '') + Helper.emojiPics[0].toString()}',
                                // '/images/vectors/angry1.png',
                                height: 50.h,
                              ),
                              onTap: () {
                                angry = true;
                                sad = false;
                                neutral = false;
                                happy = false;
                                exited = false;
                                log('angry in pic');
                                isEmojiButtonIsEnabled = true;
                                EmojiReactionName = "Worst";
                                setState(() {});
                              },
                            ),
                            angry != true
                                ? SizedBox(
                                    height: 0,
                                    width: 0,
                                  )
                                : Text(
                                    // "Worst",
                                    "",
                                    style: TextStyle(
                                        fontSize: 10.26.sp,
                                        color: Constants.kWhiteColor,
                                        fontWeight: FontWeight.bold),
                                  )
                          ],
                        ),
                      ),
                    )),
              ),

              ///not good
              GestureDetector(
                onTap: () {
                  EmojiReactionName = "Not good";
                  angry = false;
                  sad = true;
                  neutral = false;
                  happy = false;
                  exited = false;
                  isEmojiButtonIsEnabled = true;
                  setState(() {});
                },
                child: Container(
                  height: sad != true ? 80.h : 90.h,
                  width: 0.15.sw,
                  child: Card(
                    color: sad != true
                        ? Colors.white
                        : Constants.kNotOtherEmojiColor,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {
                                EmojiReactionName = "Not good";
                                angry = false;
                                sad = true;
                                neutral = false;
                                happy = false;
                                exited = false;
                                isEmojiButtonIsEnabled = true;
                                setState(() {});
                              },
                              child: Image.network(
                                '${Api.baseUrl.replaceAll("/api/", '') + Helper.emojiPics[1].toString()}',
                              )),
                          sad != true
                              ? SizedBox(
                                  height: 0,
                                  width: 0,
                                )
                              : Text(
                                  // "Not Good",
                                  "",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Constants.kWhiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              ///average
              GestureDetector(
                onTap: () {
                  EmojiReactionName = "Average";
                  angry = false;
                  sad = false;
                  neutral = true;
                  happy = false;
                  exited = false;
                  isEmojiButtonIsEnabled = true;
                  setState(() {});
                },
                child: Container(
                  height: neutral != true ? 80.h : 90.h,
                  width: 0.15.sw,
                  child: Card(
                    color: neutral != true
                        ? Colors.white
                        : Constants.kNotOtherEmojiColor,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0.r),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.01.sw, vertical: 3.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              EmojiReactionName = "Average";
                              angry = false;
                              sad = false;
                              neutral = true;
                              happy = false;
                              exited = false;
                              isEmojiButtonIsEnabled = true;
                              setState(() {});
                            },
                            child: Image.network(
                              '${Api.baseUrl.replaceAll("/api/", '') + Helper.emojiPics[2].toString()}',
                            ),
                          ),
                          neutral != true
                              ? SizedBox(
                                  height: 0,
                                  width: 0,
                                )
                              : Text(
                                  // "Average",
                                  "",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Constants.kWhiteColor,
                                      fontWeight: FontWeight.bold),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              ///good
              GestureDetector(
                onTap: () {
                  EmojiReactionName = "Good";
                  angry = false;
                  sad = false;
                  neutral = false;
                  happy = true;
                  exited = false;
                  isEmojiButtonIsEnabled = true;
                  setState(() {});
                },
                child: Container(
                  height: happy != true ? 80.h : 90.h,
                  width: 0.15.sw,
                  child: Card(
                    color: happy != true
                        ? Colors.white
                        : Constants.kNotOtherEmojiColor,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              EmojiReactionName = "Good";
                              angry = false;
                              sad = false;
                              neutral = false;
                              happy = true;
                              exited = false;
                              isEmojiButtonIsEnabled = true;
                              setState(() {});
                            },
                            child: Image.network(
                              '${Api.baseUrl.replaceAll("/api/", '') + Helper.emojiPics[3].toString()}',
                            ),
                          ),
                          happy != true
                              ? SizedBox(
                                  height: 0,
                                  width: 0,
                                )
                              : Text(
                                  // "Good",
                                  "",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Constants.kWhiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              ///wonderful
              GestureDetector(
                onTap: () {
                  EmojiReactionName = "Wonderful";
                  angry = false;
                  sad = false;
                  neutral = false;
                  happy = false;
                  exited = true;
                  isEmojiButtonIsEnabled = true;
                  setState(() {});
                },
                child: Container(
                  height: exited != true ? 80.h : 90.h,
                  width: 0.15.sw,
                  child: Card(
                    color: exited != true
                        ? Colors.white
                        : Constants.kNotOtherEmojiColor,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              EmojiReactionName = "Wonderful";
                              angry = false;
                              sad = false;
                              neutral = false;
                              happy = false;
                              exited = true;
                              isEmojiButtonIsEnabled = true;

                              setState(() {});
                            },
                            child: Image.network(
                              '${Api.baseUrl.replaceAll("/api/", '') + Helper.emojiPics[4].toString()}',
                            ),
                          ),
                          exited != true
                              ? SizedBox(
                                  height: 0,
                                  width: 0,
                                )
                              : Text(
                                  // "Wonderful",
                                  "",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Constants.kWhiteColor,
                                      fontWeight: FontWeight.bold),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 60.h),
          // colored_Button(
          //     Orientation.portrait, 160.w, StringResource.nextButtonTxt, () {
          //   if (_formKey.currentState!.validate()) {
          //     ///
          //     Helper.isNoBtnClicked = false;
          //     Helper.isYesBtnClicked = false;
          //     _controllersTextFieldsClass.descriptionStepperScreenController
          //         .clear();
          //
          //     Helper.rowNumber.length - 1 == questionIndex
          //         ? Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => ThankYouScreen(),
          //             ))
          //         : log("Sorry Error");
          //     CustomerReplyMethod(index);
          //     setState(() {
          //       isEmojiButtonIsEnabled = false;
          //       // activeStep++;
          //       // questionIndex++;
          //       // indexImages++;
          //       // intWidget++;
          //     });
          //   }
          // }),

          EmojiReactionName != ""
              ? colored_Button(
                  Orientation.portrait, 160.w, StringResource.nextButtonTxt,
                  () {
                  if (_formKey.currentState!.validate()) {
                    ///
                    Helper.isNoBtnClicked = false;
                    Helper.isYesBtnClicked = false;
                    _controllersTextFieldsClass
                        .descriptionStepperScreenController
                        .clear();

                    Helper.rowNumber.length - 1 == questionIndex
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ThankYouScreen(),
                            ))
                        : log("Sorry Error");
                    CustomerReplyMethod(index);
                    setState(() {
                      isEmojiButtonIsEnabled = false;
                      // activeStep++;
                      // questionIndex++;
                      // indexImages++;
                      // intWidget++;
                    });
                  }
                })
              : disableNextButton()
        ],
      );
    } else if (Helper.listFModel[index].typesName == 'Discriptive') {
      return SizedBox(
        width: 368.w,
        child: descriptionTextFormField(
            controllerr:
                _controllersTextFieldsClass.descriptionStepperScreenController,
            onfieldSubmitted: (value) {
              checkDescriptionData = value;
              log(checkDescriptionData.toString());
            }),
      );
    } else if (Helper.listFModel[index].typesName == 'Vector') {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customSmoothStarRating(index),
            ],
          ),
          SizedBox(height: 100.h),
          rating == 0.0
              ? disableNextButton()
              : colored_Button(
                  Orientation.portrait, 160.w, StringResource.nextButtonTxt,
                  () {
                  if (_formKey.currentState!.validate()) {
                    ///
                    Helper.isNoBtnClicked = false;
                    Helper.isYesBtnClicked = false;
                    _controllersTextFieldsClass
                        .descriptionStepperScreenController
                        .clear();

                    Helper.rowNumber.length - 1 == questionIndex
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ThankYouScreen(),
                            ))
                        : log("Sorry Error");
                    CustomerReplyMethod(index);
                    setState(() {
                      isEmojiButtonIsEnabled = false;
                      // activeStep++;
                      // questionIndex++;
                      // indexImages++;
                      // intWidget++;
                    });
                  }
                })
          // : disableNextButton()
        ],
      );
    } else if (Helper.listFModel[index].typesName == 'MCQs') {
      return SizedBox(
        height: 400.h,
        child: StepperZero(),
      );
    }
    return;
  }*/
/*
  Future<List<QuestionsModel>> getQuestionaries() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? myToken = sharedPreferences.getString('token');
    companyID = sharedPreferences.getString('companyId');
    log("COMPANY ID IS ================== $companyID");

    final response =
        await http.get(Uri.parse(Api.baseUrl + 'system/1/edit'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    });
    var data = jsonDecode(response.body.toString());
    log("${response.body}");
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        Helper.listFModel.add(QuestionsModel.fromJson(i));
      }
      return Helper.listFModel;
    } else
      return Helper.listFModel;
  }*/

  //----------------------------------------------------AnswerAPI-Method
/*  Future<AnswerMcqModel> getAnswerMcqModel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? myToken = sharedPreferences.getString('token');
    String? myCompanyQuestionnaireIdForEmoji =
        sharedPreferences.getString('mainCompanyQuestionIDForEmoji');
    final response = await http.get(
        Uri.parse(Api.baseUrl +
            'getCompanyQuestionnaireImages/$myCompanyQuestionnaireIdForEmoji'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $myToken',
        });
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return AnswerMcqModel.fromJson(data);
    } else
      return AnswerMcqModel.fromJson(data);
  }*/

/*  Future<void> getEmojis() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? myToken = sharedPreferences.getString('token');
    String? myCompanyQuestionnaireIdForEmoji =
        sharedPreferences.getString('mainCompanyQuestionIDForEmoji');
    final response = await http.get(
        Uri.parse(Api.baseUrl +
            'getCompanyQuestionnaireImages/$myCompanyQuestionnaireIdForEmoji'),
        // 'getCompanyQuestionnaireImages/4'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $myToken',
        });
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      log("${response.body}");
      data.forEach((value) {
        Helper.emojiPics.add(value['image']);
        Helper.emojiPicsCompanyQuestionnaireId
            .add(value['company_questionnaire_id']);
        log("Emojis-----------API--------------" + value['image']);
      });
    } else {
      log("error");
      log(data);
      log(response.statusCode.toString());
    }
    //   return Helper.emojiPics;
  }*/

/*  getCompanyQuotes() async {
    ///----------------Fetching data from shared preference=================================
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? myToken = sharedPreferences.getString('token');
    String? companyID = sharedPreferences.getString('companyId');

    ///================= User ===========================
    log("----------------User----------------------");
    log("User token --- >  $myToken");
    log("User company id --- >  $companyID");
    log("----------------get Company Quotes ----------------------");

    Map<String, String> myHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };
    final response = await http.get(
      Uri.parse(Api.baseUrl + 'getCompanyQuotes/$companyID'),
      headers: myHeader,
    );

    try {
      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log('response ---Quotes API--------------200');
        jsonResponse.forEach((value) {

          log(value['quote'].toString());
        });

        log("----------------200 response ----------------------");
        // log("======QUOTES========>${jsonResponse['quote'].toString()}");
        log("DATA in 200 code ${response.body}");
        log("status code ${response.statusCode}");
      } else {
        log("DATA ${response.body}");
      }
    } catch (e) {
      log("DATA $e");
    }
  }*/
/*
  showValuesOfReplyParam(int index) {
    if (_currentSliderValue > 1) {
      return _currentSliderValue.toStringAsFixed(2);
    } else if (_controllersTextFieldsClass
            .descriptionStepperScreenController.text !=
        null) {
      return _controllersTextFieldsClass
          .descriptionStepperScreenController.text;
    } else if (rating != null) {
      return rating;
    } else if (checkYesOrNo != null) {
      return checkYesOrNo;
    } else if (EmojiReactionName != null) {
      return EmojiReactionName;
    } else if (choice[index] != null) {
      return choice[index];
    }
  }*/

/*  validateNextButton() {
    if (_currentSliderValue > 1) {
      _currentSliderValue = 0;
    }
  }*/

/*  CustomerReplyMethod(int index) async {
    Provider.of<DataProviderss>(context, listen: false)
        .isTrueOrFalseFunctionProgressHUD(true);

    ///----------------Fetching data from shared preference=================================
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? myToken = sharedPreferences.getString('token');
    String? companyID = sharedPreferences.getString('companyId');
    int? FeedbackID = sharedPreferences.getInt('FeedbackID');
    int? CustomerId = sharedPreferences.getInt('CustomerId');
    int? FeedbackTakerId = sharedPreferences.getInt('FeedbackTakerId');

    ///================= User ===========================
    log("----------------User----------------------");
    log("User token --- >  $myToken");
    log("User company id --- >  $companyID");
    log("User FeedBack id --- >  $FeedbackID");
    log(" Helper.dropDownCustomerID id --- >  ${Helper.dropDownCustomerID}");
    log("--------------------------------------");
    Map<String, dynamic> bodyData = {
      'company_id': companyID!,
      'company_feedback_id': Helper.dropDownCustomerID == null
          ? FeedbackID
          : Helper.dropDownCustomerID,
      'customer_id': CustomerId,
      'company_questionnaire_id': 4,
      'type_id': Helper.listFModel[questionIndex].typeID.toString(),
      'company_answer_id': 22,
      'reply': showValuesOfReplyParam(index)
    };

    Map<String, String> myHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };
    final response = await http.post(Uri.parse(Api.createCustomerReply),
        body: json.encode(bodyData), headers: myHeader);

    // log(response.body);

    try {
      // var jsonResponse = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        log("========== _currentSliderValue ===========> ${_currentSliderValue.toStringAsFixed(2)}");
        log("========== descriptionStepperScreenController ===========> ${_controllersTextFieldsClass.descriptionStepperScreenController.text.toString()}");
        log("========== rating ===========> $rating");
        log("========== YES OR NO ===========> $checkYesOrNo");
        log("========== Emoji Reaction Name ===========> $EmojiReactionName");
        log("========== choice[index] Name ===========> ${choice[index]}");

        ///-----------------------------------

        activeStep++;
        questionIndex++;
        indexImages++;
        intWidget++;

        setState(() {});

        ///-----------------------------------

        Provider.of<DataProviderss>(context, listen: false)
            .isTrueOrFalseFunctionProgressHUD(false);

        log("----------------200 response ------------information----------");
        log("DATA in 200 code ${response.body}");
        log("status code ${response.statusCode}");
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => const StepperScreen()));
      } else {
        Provider.of<DataProviderss>(context, listen: false)
            .isTrueOrFalseFunctionProgressHUD(false);
        log("DATA ${response.body}");
      }
    } catch (e) {
      Provider.of<DataProviderss>(context, listen: false)
          .isTrueOrFalseFunctionProgressHUD(false);
      log("DATA $e");
    }

    ///----------------Fetching data from shared preference=================================
    // var url = Uri.parse(Api.createFeedbackIDs);
    // http.Response response = await http.post(
    //   url,
    //
    //   body: {
    //     'company_id': 1,
    //     // 'input_type': _dropdown != "dropdown" ? 'text' : 'dropdown',
    //     'input_type': 'text',
    //     'feedback_no': 'dfdfsdx'
    //   },
    // );
  }*/

  /// ---------------- Rating Bar Method --------------------
/*  customSmoothStarRating(int index) {
    return RatingBar(
      glowColor: Colors.orange,
      itemSize: 60.w,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: SvgPicture.network(Helper.vectorTypeRatingsImageNAME == "Glow"
            ? Api.baseUrl.replaceAll('api/', '') + Helper.ratingsImage[0]
            : Api.baseUrl.replaceAll('api/', '') + Helper.ratingsImage[0]),
        empty: SvgPicture.network(Helper.vectorTypeRatingsImageNAME == "Dim"
            ? Api.baseUrl.replaceAll('api/', '') + Helper.ratingsImage[1]
            : Api.baseUrl.replaceAll('api/', '') + Helper.ratingsImage[1]),
        half: SvgPicture.network(
            Helper.vectorTypeRatingsImageNAME == "Half-Filled"
                ? Api.baseUrl.replaceAll('api/', '') + Helper.ratingsImage[2]
                : Api.baseUrl.replaceAll('api/', '') + Helper.ratingsImage[2]),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
      onRatingUpdate: (updateRating) {
        rating = updateRating;
        rating != 0.0 ? isEmojiButtonIsEnabled = true : Text("ff");
        log(rating.toString());
        setState(() {});
      },
    );
  }*/

/*  Future<void> getRatingPictures() async {
    ///----------------Fetching data from shared preference================getRatingPictures=================
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? myToken = sharedPreferences.getString('token');

    String? myCompanyQuestionnaireIdForVector =
        sharedPreferences.getString('mainCompanyQuestionIDForVector');

    String? companyID = sharedPreferences.getString('companyId');

    ///================= User ===========================
    log("----------------User----------------------");
    log("User token --- >  $myToken");
    log("User company id --- >  $companyID");
    log("----------------get Company Quotes ----------------------");

    Map<String, String> myHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    final response = await http.get(
      Uri.parse(Api.baseUrl +
          "getCompanyQuestionnaireVectors/$myCompanyQuestionnaireIdForVector"),
      // "getCompanyQuestionnaireVectors/5"),
      headers: myHeader,
    );

    var data = json.decode(response.body);
    // RatingImagesModel.fromJson(data);

    if (response.statusCode == 200) {
      // RatingImagesModel _ratingModel = RatingImagesModel();
      setState(() {
        log('response -----------------200');
        data.forEach((value) {
          Helper.ratingsImage.add(value['image']);
          Helper.vectorTypeRatingsImageNAME.add(value["vector_type"]);

          log("if condition ----------- ${value['image']} ---------------------");
        });
      });
    } else {
      log('response -----------NOT------200');
      log(response.body.toString());
    }
  }*/

  // Future<void> getQuestionsByForEachLoop() async {
  //   ///----------------Fetching data from shared preference================getRatingPictures=================
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? myToken = sharedPreferences.getString('token');
  //   String? companyID = sharedPreferences.getString('companyId');
  //
  //   ///================= User ===========================
  //   log("----------------User----------------------");
  //   log("User token --- >  $myToken");
  //   log("User company id --- >  $companyID");
  //   log("----------------get Company Quotes ----------------------");
  //
  //   Map<String, String> myHeader = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $myToken',
  //   };
  //
  //   final response = await http.get(
  //     Uri.parse(Api.baseUrl +
  //         "getCompanyQuestionnaireVectors/${Helper.mainCompanyQuestionIDForVector}"),
  //     headers: myHeader,
  //   );
  //
  //   var data = json.decode(response.body);
  //   // RatingImagesModel.fromJson(data);
  //
  //   if (response.statusCode == 200) {
  //     // RatingImagesModel _ratingModel = RatingImagesModel();
  //     setState(() {
  //       log('response -----------------200');
  //       data.forEach((value) {
  //         Helper.ratingsImage.add(value['image']);
  //         Helper.vectorTypeRatingsImageNAME.add(value["vector_type"]);
  //
  //         log("if condition ----------- ${value['image']} ---------------------");
  //       });
  //     });
  //   } else {
  //     log('response -----------NOT------200');
  //     log(response.body.toString());
  //   }
  // }

/*  Future<void> getCompanyPolarQuestionnaireFunc() async {
    ///----------------Fetching data from shared preference=============================POLAR====
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? myToken = sharedPreferences.getString('token');
    String? companyID = sharedPreferences.getString('companyId');
    String? mainCompanyQuestionIDForPolarID =
        sharedPreferences.getString('mainCompanyQuestionIDForPolar');

    ///================= User ===========================
    log("----------------User----------------------");
    log("User token --- >  $myToken");
    log("User company id --- >  $companyID");
    log("----------------get Company Quotes ----------------------");

    Map<String, String> myHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    final response = await http.get(
      Uri.parse(Api.baseUrl +
          "getCompanyPolarQuestionnaire/$mainCompanyQuestionIDForPolarID"),
      headers: myHeader,
    );

    var data = json.decode(response.body);
    // RatingImagesModel.fromJson(data);

    if (response.statusCode == 200) {
      // RatingImagesModel _ratingModel = RatingImagesModel();
      setState(() {
        log('response -------company_questionnaire_id----------200');
        data.forEach((value) {
          Helper.getCompanyPolarQuestionnaireList.add(value['name']);
          // Helper.listFModelOfPolar.add(value['company_questionnaire_id']);
          // Helper.getCompanyPolarQuestionnaireList.add(value["vector_type"]);

          log("if condition ----------- ${value['name']} ---------------------");
          log("if condition ----company_questionnaire_id------- ${value['company_questionnaire_id']} ---------------------");
          // log("if condition ----company_questionnaire_id------- ${Helper.listFModelOfPolar[2]} ---------------------");
        });
      });
    } else {
      log('response -----------NOT------200');
      log(response.body.toString());
    }
  }*/

/*  Future<void> getQuestinariesAnswers() async {
    ///----------------Fetching data from shared preference=======getQuestinariesAnswers==========================
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? myToken = sharedPreferences.getString('token');
    String? companyID = sharedPreferences.getString('companyId');

    String? myCompanyQuestionnaireIdForMCQS =
        sharedPreferences.getString('mainCompanyQuestionIDForMCQS');

    ///================= User ===========================
    log("----------------User----------------------");
    log("User token --- >  $myToken");
    log("User company id --- >  $companyID");
    log("----------------get Company Quotes ----------------------");

    Map<String, String> myHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    final response = await http.get(
      Uri.parse(Api.baseUrl +
          "getCompanyQuestionnaireAnswers/$myCompanyQuestionnaireIdForMCQS"),
      headers: myHeader,
    );

    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        log('response ------Answers-------MCQS----200');
        data['data'].forEach((value) {
          Helper.getMCQSQuestionsText.add(value['answer']);
          // ===================================================================
          AnswerIdMcq =
              sharedPreferences.setString('AnswerIdMcq', value['answer_id']);

          myIndex = value.toString().length;
          showAnswerID = value['answer_id'];
          setState(() {});
          log("index of answer ID -> " + showAnswerID.toString());
          // ===================================================================
          log("answer_id => " + value['answer_id']);
        });
      });
    } else {
      log('response -----------NOT------200');
      log(response.body.toString());
    }
  }*/
}
