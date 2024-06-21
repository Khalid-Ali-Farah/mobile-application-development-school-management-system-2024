import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myschool/constants.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static String routeName = 'ResultScreen';

  @override
  _ResultScreenState createState() => _ResultScreenState();
}
//B-------------------------------
class _ResultScreenState extends State<ResultScreen> {
  String selectedCollection = 'results';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //A-------------------------------
    appBar: AppBar(
        title: Text('Results'),
      ),
      body: Column(
        children: [
          Container(
            //B-------------------------------
          child: SvgPicture.asset(
              'assets/icons/result.svg',
              height: 90.0,
              color: Colors.white,
            ),
            height: 15.h,
          ),
          //C-------------------------------
          Text(
            'Selecte Year of Result',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          // DropdownButton to select between collections
          DropdownButton<String>(
            value: selectedCollection,
            items: [
              DropdownMenuItem(
                //D-------------------------------

              child: Text('Result Year 2023/2024',style: TextStyle(color: Colors.orange),),
                value: 'results',
              ),
              DropdownMenuItem(
                child: Text('Result Year 2024/2025',style: TextStyle(color: Colors.orange),),
                value: 'result_term_two',
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedCollection = value!;
              });
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kTopBorderRadius,
                color: kOtherColor,
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(selectedCollection)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                  if (snapshots.hasData) {
                    return ListView.builder(
                      padding: EdgeInsets.all(kDefaultPadding),
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        var resultData = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                        return Container(
                          margin: EdgeInsets.only(bottom: kDefaultPadding),
                          padding: EdgeInsets.all(kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            color: Colors.teal[800],
                            borderRadius:
                            BorderRadius.circular(kDefaultPadding),
                            boxShadow: [
                              BoxShadow(
                                color: kTextLightColor,
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //E-------------------------------
                                      Text(
                                        resultData['subjectName'].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                          color: kTextWhiteColor,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      //F-------------------------------
                                      Text(
                                        'Score: ${resultData['score']}',
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //G-------------------------------
                                      Text(
                                        'Grade: ${resultData['grade']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                          color: kTextWhiteColor,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      //H-------------------------------
                                      Text(
                                        'Date: ${resultData['date']}',
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
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
          ),
        ],
      ),
    );
  }
}
