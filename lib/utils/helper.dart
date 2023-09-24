import 'dart:async';
import 'dart:io';
import 'package:feedmeback/UpdatedNewModel/questions_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../Models/getPolarQuestionsModel.dart';
import '../Models/get_emoji_model.dart';

class Helper {
  static Uri? uriTaker;
  static StreamSubscription? sub;

  // --------------------------- This os the id;
  static var getAllQuestionsOfSystemPath_ID;
  static var getBrandID;
  static List<String> getIndustryNameList = [];
  static List<int> getIndustryIDList = [];

  static bool onPressedValue = true;
  static var companyQuestionID;
  static List<int> userID = [];
  static List<int> userIDForFeedBackSpace = [];

  /// Method to Convert DateTime Into *** DAY ***
  static String convertDateTimeDisplay(String date) {
    final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormatter = DateFormat("dd-MM-yyyy");
    final DateTime displayDate = displayFormatter.parse(date);
    final String formatted = serverFormatter.format(displayDate);
    return formatted;
  }

  /// Disabale  emojis from  *** textField ***
  static var disableEmojiFromTextField = FilteringTextInputFormatter.deny(RegExp(
      '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'));

  ///----------bool values to check yes or no btn is clicked or not -----------------

  static bool isTakeFeedbackButtonClicked = false;

  static bool isNoBtnClicked = false;
  static bool isYesBtnClicked = false;
  static String? string;
  static bool showSpinner = false;
  static bool isInternetConnected = false;
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  static var dropDownSignUpID;
  static var dropDownCustomerID;
  static List<dynamic> jsonResponseForCompanyQuestions = [];

  //----------------------------------list for dropdown in signUp

  static List<String> questions = [];
  static List<String> questionsTypesName = [];
  static List<String> getMCQSQuestionsText = [];
  static List<String> FeedBackIDForDropDown = [];
  static List<String> FeedBackTakerIdList = [];

  //Start=============================================Remove Duplicate Values from Dropdown || Prevent Duplicate value to be added in a List
  static var seen = Set<String>();
  static List<String> uniqueListOfFeedbackId =
      FeedBackIDForDropDown.where((feedbackId) => seen.add(feedbackId))
          .toList();
  //End=============================================Remove Duplicate Values from Dropdown || Prevent Duplicate value to be added in a List

  // var _getQuestanionriesAnswers = [];
  static List<String> questionsCompanyQuestionnaireId = [];
  static List<String> questionsCompanyQuestionnaireRowNumber = [];
  static List<int> rowNumber =
      questionsCompanyQuestionnaireRowNumber.map(int.parse).toList();
  static List<String> mCQSOptionList = [];

  static List<QuestionsModel> listFModel = [];
  static List<GetEmojiModel> listOfModelOfEmojis = [];
  static List<getCompanyPolarQuestionnaireModel> listFModelOfPolar = [];
  static List<String> emojiPics = [];
  static List<String> emojiPicsCompanyQuestionnaireId = [];
  static List<String> ratingsImage = [];
  static List<String> vectorTypeRatingsImageNAME = [];
  static List<String> getCompanyPolarQuestionnaireList = [];

/*  static matchCompanyQuestionnaireID(int index) {
    if (Helper.listFModel[index].data![index][index].name == 'Polar') {
      if (Helper.listFModel[index].data.t ==
          Helper.listFModel[index].companyQuestionnaireId) {
        companyQuestionID = Helper.listFModel[index].companyQuestionnaireId;
        return Text(companyQuestionID.toString());
        // return Text("company question id is ---------True------");

      }
    } else {
      if (Helper.listFModel[index].typesName == 'Emoji') {
        if (Helper.listFModelOfPolar[index].companyQuestionnaireId ==
            Helper.listFModel[index].companyQuestionnaireId) {
          companyQuestionID =
              Helper.listFModelOfPolar[index].companyQuestionnaireId;

          return companyQuestionID;
        }
      }
    }
  }*/

  ///----------bool values to check yes or no btn is clicked or not -----------------
  static settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.music_note),
                    title: new Text('msg'),
                    onTap: () => {}),
                new ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('msg'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

  static ToastMessage(
      {required BuildContext context, required String descMessage}) {
    MotionToast.error(
      title: Text(
        "Validation Message",
        style: TextStyle(
          color: CupertinoColors.black,
          fontWeight: FontWeight.w800,
          fontSize: 16.sp,
        ),
      ),
      description: Text(
        descMessage,
        style: TextStyle(
          color: CupertinoColors.black,
          fontWeight: FontWeight.w400,
          fontSize: 15.sp,
        ),
      ),
      position: MOTION_TOAST_POSITION.top,
      animationType: ANIMATION.fromTop,
      toastDuration: const Duration(milliseconds: 3000),
    ).show(context);
  }

  // Navigation  function
  static gotoScreen(BuildContext context, {required dynamic className}) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => className));
  }
}

class ImageSelection extends ChangeNotifier {
  File? image;
  Future getImagefromcamera() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    image = File(selectedImage!.path);
    notifyListeners();
  }

  Future getImagefromGallery() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(selectedImage!.path);
    notifyListeners();
  }
}
