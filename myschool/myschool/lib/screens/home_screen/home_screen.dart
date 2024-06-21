import 'package:firebase_auth/firebase_auth.dart';
import 'package:myschool/constants.dart';
import 'package:myschool/screens/assignment_screen/assignment_screen.dart';
import 'package:myschool/screens/datesheet_screen/datesheet_screen.dart';
import 'package:myschool/screens/fee_screen/fee_screen.dart';
import 'package:myschool/screens/my_profile/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../attendance_screen/attendanceScreen.dart';

import '../leave_application/leave_application_screen.dart';
import '../login_screen/signOut.dart';

import '../result_screen/result_screen.dart';
import 'widgets/student_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //we will divide the screen into two parts
          //fixed height for first half
          Container(
            width: 100.w,
            height: 40.h,
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //A-----------------
                        StudentName(
                          studentName: 'Khalid',
                        ),
                        kHalfSizedBox,
                        //B-------------------
                        StudentClass(
                            studentClass: 'Class X-II A | Roll no: 15'),
                        kHalfSizedBox,
                        //C-------------
                        StudentYear(studentYear: '2023-2024'),
                      ],
                    ),
                    //B----------------------
                    kHalfSizedBox,
                    StudentPicture(
                      //D-------------
                    picAddress: 'assets/images/khalid.jpg',
                        onPress: () {
                          // go to profile detail screen here
                          Navigator.pushNamed(
                              context, MyProfileScreen.routeName);
                        }),
                  ],
                ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StudentDataCard(
                      onPress: () {
                        //go to attendance screen
                      },
                      //E-------------
                      title: 'Attendance',
                      value: '95.02%',
                    ),
                    StudentDataCard(
                      onPress: () {
                        //go to fee due screen
                        Navigator.pushNamed(context, FeeScreen.routeName);
                      },
                      //F-------------
                      title: 'Fees Due',
                      value: '600\RM',
                    ),
                  ],
                )
              ],
            ),
          ),

          //other will use all the remaining height of screen
          Expanded(
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: kOtherColor,
                borderRadius: kTopBorderRadius,
              ),
              child: SingleChildScrollView(
                //for padding
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, ResultScreen.routeName);
                          },
                          //G------------------------------------
                          icon: 'assets/icons/result.svg',
                          title: 'Result',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, LeaveApplicationScreen.routeName);
                          },
                          //H--------------------------
                          icon: 'assets/icons/resume.svg',
                          title: 'Leave\nApplication',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, AttendanceScreen.routeName);
                          },
                          //I--------------
                          icon: 'assets/icons/quiz.svg',
                          title: 'Attendance',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, DateSheetScreen.routeName);
                          },
                          //J-------------------------
                          icon: 'assets/icons/datesheet.svg',
                          title: 'DateSheet',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            //go to assignment screen here
                            Navigator.pushNamed(
                                context, AssignmentScreen.routeName);
                            //K-------------------------
                          },
                          icon: 'assets/icons/assignment.svg',
                          title: 'Assignments',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(context, SignOut.routeName);
                          },
                          //L-------------------------
                          icon: 'assets/icons/logout.svg',
                          title: 'Logout',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
      required this.onPress,
      required this.icon,
      required this.title})
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              width: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              color: kOtherColor,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}
