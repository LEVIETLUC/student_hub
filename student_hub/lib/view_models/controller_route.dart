import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/views/auth/chooserole_view.dart';
import 'package:student_hub/views/auth/forgort_password_view.dart';
import 'package:student_hub/views/profile_creation/student/home_view.dart';
import 'package:student_hub/views/profile_creation/student/profile_input_student1.dart';
import 'package:student_hub/views/profile_creation/student/profile_input_student2.dart';
import 'package:student_hub/views/profile_creation/student/profile_student_dragcv.dart';
import 'package:student_hub/views/auth/signup_info_view.dart';
import 'package:student_hub/views/auth/switch_account_view.dart';
import 'package:student_hub/views/auth/login_view.dart';
import 'package:student_hub/views/profile_creation/company/profile_input.dart';
import 'package:student_hub/views/homescreen/welcome-screen.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/views/auth/notify_send_password_view.dart';
import 'package:student_hub/views/auth/change_password_view.dart';

class ControllerRoute {
  final BuildContext context;

  ControllerRoute(this.context);

//authentification
  void navigateToSwitchAccountView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SwitchAccountView()),
    );
  }

  void navigateToLoginView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void navigateToSignupInfoView(int typeUser) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpInfo(typeUser)),
    );
  }

  void navigateToChooseRoleView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseRole()),
    );
  }

  void navigateToProfileInputCompany(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileInput(user)),
    );
  }

  void navigateToProfileInputStudent1(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileInputStudent1(user)),
    );
  }

  void navigateToProfileInputStudent2(User studentUser) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileInputStudent2(studentUser)),
    );
  }

  void navigateToProfileInputStudent3(User studentUser) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StudentProfileDragCv(studentUser)),
    );
  }

  void navigateToWelcomeView(User companyUser) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen(companyUser)),
    );
  }

  void navigateToForgotPasswordView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordView()),
    );
  }

  void navigateToNotifySendPasswordView(String email) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotifySendPassword(email)),
    );
  }

  void navigateToChangePasswordView(String email) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordView(email)),
    );
  }

  void navigateToHomeScreen(bool? showAlert, User? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? role = prefs.getInt('role');
    if (role == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(showAlert: true, user: user)),
      );
    } else if (role == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(showAlert: false, user: user)),
      );
    }
  }
}
