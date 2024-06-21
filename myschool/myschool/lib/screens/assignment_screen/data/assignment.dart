import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

import '../../attendance_screen/data/attendance_data.dart';
import 'assignmentDetailRow.dart';


class Assignment extends StatelessWidget {
  const Assignment({Key? key}) : super(key: key);
  static String routeName = 'Assignment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: kTopBorderRadius,
              ),
              child: ListView.builder(
                  padding: EdgeInsets.all(kDefaultPadding),
                  itemCount: assignment.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: kDefaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(kDefaultPadding),
                              color: kOtherColor,

                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor.withOpacity(0.4),
                                    borderRadius:
                                    BorderRadius.circular(kDefaultPadding),
                                  ),
                                //E------------------------------------
                                  child: Center(
                                    child: Text(
                                      assignment[index].subjectName,
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                                //F------------------------------------
                                kHalfSizedBox,
                                Text(
                                  assignment[index].topicName,
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kTextBlackColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                //G------------------------------------
                                kHalfSizedBox,
                                AssignmentDetailRow(
                                  title: 'Assign Date',
                                  statusValue: assignment[index].assignDate,
                                ),
                                //H------------------------------------
                                kHalfSizedBox,
                                AssignmentDetailRow(
                                  title: 'Last Date',
                                  statusValue: assignment[index].lastDate,
                                ),
                                //I------------------------------------
                                kHalfSizedBox,
                                AssignmentDetailRow(
                                  title: 'Status',
                                  statusValue: assignment[index].status,
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}