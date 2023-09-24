import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:feedmeback/Stepper/Stepper_questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Provider.dart';
import '../../config/themes/theme.dart';
import '../../utils/constant.dart';
import '../../utils/controllers.dart';
import '../../utils/string_resource.dart';
import '../../widgets/Buttons/colored_button.dart';
import '../../widgets/custom_textfields/textFeild.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  ControllersTextFieldsClass _controllersTextFieldsClass =
      ControllersTextFieldsClass();

  @override
  void dispose() {
    _controllersTextFieldsClass.fullNameInformationController.dispose();
    _controllersTextFieldsClass.contactNoInformationController.dispose();
    _controllersTextFieldsClass.emailInformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return ModalProgressHUD(
          inAsyncCall: Provider.of<DataProviders>(context).showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: Color(AppColor.lightgreen),
          ),
          child: DoubleBack(
            message: StringResource.pressAgainToClose,
            child: Scaffold(
              body: Container(
                color: Colors.white,
                child: InformationData(
                    orientation, context, _controllersTextFieldsClass),
              ),
            ),
          ));
    });
  }
}

Widget InformationData(Orientation orientation, BuildContext context,
    _controllersTextFieldsClass) {
  final _formKey = GlobalKey<FormState>();

  return Form(
    key: _formKey,
    child: Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 90.h),
              SvgPicture.asset(
                Constants.kInformationVoteSvg,
                height: 220.6.h,
                width: 223.72.w,
              ),
              SizedBox(height: 22.33.h),
              Text(StringResource.infoScreenHeadingText,
                  style: TextStyle(
                    fontSize: 44.3.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy',
                    color: Color(0xff004D4D),
                  )),
              SizedBox(height: 40.h),
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textField(
                        StringResource.infoScreenHintText,
                        orientation == Orientation.portrait ? 368.w : 200.w,
                        orientation,
                        validatorr: (value) {
                          if (_controllersTextFieldsClass
                                  .fullNameInformationController.text ==
                              "") {
                            return StringResource.enterValidFullNameMessage;
                            //

                          } else if ((!Constants
                              .regExpForOnlyAlphabetsWithGapAndHyphen
                              .hasMatch(_controllersTextFieldsClass
                                  .fullNameInformationController.text))) {
                            return StringResource
                                .enterValidOnlyAlphabetsMessage;
                          }
                          return null;
                        },
                        controller: _controllersTextFieldsClass
                            .fullNameInformationController,
                        maximumLength: 30,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      textField(
                        StringResource.contactNoTxtHint,
                        orientation == Orientation.portrait ? 368.w : 200.w,
                        orientation,
                        validatorr: (value) {
                          if (_controllersTextFieldsClass
                              .contactNoSignUpController.text
                              .toString()
                              .isEmpty) {
                            return StringResource
                                .enterValidContactNumberMessage;
                          }

                          return null;
                        },
                        controller: _controllersTextFieldsClass
                            .contactNoInformationController,
                        maximumLength: 12,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      textField(
                        StringResource.Email_Address,
                        orientation == Orientation.portrait ? 368.w : 200.w,
                        orientation,
                        validatorr: (value) {
                          if (_controllersTextFieldsClass
                                      .fullNameInformationController.text !=
                                  "" &&
                              _controllersTextFieldsClass
                                      .contactNoInformationController.text !=
                                  "" &&
                              _controllersTextFieldsClass
                                  .emailInformationController.text.isNotEmpty) {
                            if ((!Constants.regExpForEmail.hasMatch(
                                _controllersTextFieldsClass
                                    .emailInformationController.text))) {
                              return StringResource.enterValidEmailMessage;
                            }
                          }
                          return null;
                        },
                        controller: _controllersTextFieldsClass
                            .emailInformationController,
                        maximumLength: 60,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 230.w, top: 10.h),
                        child: Row(
                          children: [
                            Text(
                              StringResource.Email_optional_Text,
                              style: TextStyle(
                                color: Color(AppColor.lightgreen),
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 130.h,
              ),
              colored_Button(orientation, 173.w, StringResource.nextButtonTxt,
                  () async {
                if (_formKey.currentState!.validate()) {
                  final fullName = _controllersTextFieldsClass
                      .fullNameInformationController.text;
                  final phoneNumber = _controllersTextFieldsClass
                      .contactNoInformationController.text;
                  final email = _controllersTextFieldsClass
                      .emailInformationController.text;

                  final pref = await SharedPreferences.getInstance();

                  /// -------------------------------------- Save name, number and email in local storage
                  pref.setString('InformationName', fullName);
                  pref.setString('phoneNumber', phoneNumber);
                  pref.setString('email', email);

                  /// -------------------------------------- Save name, number and email in local storage

                  final feedbackId = pref.getString('FeedbackID');
                  final feedbackSpaceId = pref.getString('FeedbackSpaceID');

                  print('feedbackId : ' + feedbackId.toString());
                  print('feedbackSpaceId : ' + feedbackSpaceId.toString());

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const StepperScreen()));

                  /*  dynamic res = await ApiClient.sendInformationFeedback(
                    fullName,
                    phoneNumber,
                    email,
                    email,
                    feedbackId,
                    feedbackSpaceId,
                    context,
                  );

                  if (res['status']) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const StepperScreen()));
                  } else
                    print(res['data']);*/

                }
              })
            ],
          ),
        ),
      ),
    ),
  );
}
