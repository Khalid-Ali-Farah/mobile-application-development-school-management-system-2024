import 'package:myschool/screens/attendance_screen/attendanceScreen.dart';

import 'package:myschool/screens/leave_application/leave_application_screen.dart';
import 'package:myschool/screens/login_screen/login_page.dart';
import 'package:myschool/screens/login_screen/sign_up_page.dart';
import 'package:myschool/screens/login_screen/signOut.dart';
import 'package:myschool/screens/result_screen/result_screen.dart';
import 'package:myschool/screens/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'screens/assignment_screen/assignment_screen.dart';
import 'screens/datesheet_screen/datesheet_screen.dart';
import 'screens/fee_screen/fee_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/my_profile/my_profile.dart';

Map<String, WidgetBuilder> routes = {
  //all screens will be registered here like manifest in android
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginPage.routeName: (context) => LoginPage(),
  SignUpPage.routeName: (context) => SignUpPage(),
  HomeScreen.routeName: (context) => HomeScreen(),
  MyProfileScreen.routeName: (context) => MyProfileScreen(),
  FeeScreen.routeName: (context) => FeeScreen(),
  AssignmentScreen.routeName: (context) => AssignmentScreen(),
  DateSheetScreen.routeName: (context) => DateSheetScreen(),
  AttendanceScreen.routeName: (context) => AttendanceScreen(),
  LeaveApplicationScreen.routeName: (context) => LeaveApplicationScreen(),
  ResultScreen.routeName: (context) => ResultScreen(),
  SignOut.routeName: (context) => SignOut(),










};
