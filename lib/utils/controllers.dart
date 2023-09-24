import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class ControllersTextFieldsClass {
  /// Login Controllers
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  /// Sign Up Controllers
  final nameSignUpController = TextEditingController();
  final organizationSignUpNameController = TextEditingController();
  final contactNoSignUpController = MaskedTextController(mask: '00000000000');
  final emailSignUpController = TextEditingController();

  /// Forgot password Controllers
  final emailForgotPassController = TextEditingController();

  /// Register User with only Email Controllers
  final registerWithEmailController = TextEditingController();

  /// Table ID Controllers
  final tableIdController = TextEditingController();

  /// feedbackTakerID Screen Controllers
  final feedbackTakerIDController = TextEditingController();

  /// Information Screen Controllers
  final fullNameInformationController = TextEditingController();
  final contactNoInformationController =
      MaskedTextController(mask: '00000000000');
  final emailInformationController = TextEditingController();

  /// Description Stepper Screen Controllers
  final descriptionStepperScreenController = TextEditingController();
}
