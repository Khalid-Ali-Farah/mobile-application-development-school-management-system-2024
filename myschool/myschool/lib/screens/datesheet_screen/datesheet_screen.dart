import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:myschool/constants.dart';

class DateSheetScreen extends StatelessWidget {
  const DateSheetScreen({Key? key}) : super(key: key);
  static String routeName = 'DateSheetScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //A--------------------
    appBar: AppBar(
        title: Text('DateSheet'),
      ),
      body: Container(
        width: 100.w,
        decoration: BoxDecoration(
          color: kOtherColor,
          borderRadius: kTopBorderRadius,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('dataSheets').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  var dateData = snapshots.data!.docs[index].data() as Map<String, dynamic>;

                  return Container(
                    margin: EdgeInsets.only(
                      left: kDefaultPadding / 2,
                      right: kDefaultPadding / 2,
                    ),
                    padding: EdgeInsets.all(kDefaultPadding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 3.h,
                          child: Divider(
                            thickness: 1.0,
                          ),
                        ),
                        // Row with 3 columns
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 1st column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              //B--------------------
                              children: [
                                Text(
                                  dateData['date'].toString(),
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kTextBlackColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  dateData['monthName'],
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),

                            // 2nd column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              //C--------------------
                              children: [
                                Text(
                                  dateData['subjectName'],
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kTextBlackColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  dateData['dayName'],
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),

                            // 3rd column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              //D--------------------
                              children: [
                                Text(
                                  '🕒${dateData['time']}',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                          child: Divider(
                            thickness: 1.0,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
