import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';


class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);
  static String routeName = 'AttendanceScreen';

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false
        //A--------------------
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Column(
        children: [
      //B--------------------
      Container(
            child: SvgPicture.asset(
              'assets/icons/quiz.svg',
              height: 90.0,
              color: Colors.white,
            ),
            height: 15.h,
          ),
    //C--------------------
          Text(
            'Mark Your Attendance',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  // Form for students to input attendance
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 16.0),
                        Container(
                          margin: EdgeInsets.only(bottom: 8.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF184D47),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              //D--------------------
                              Radio(
                                activeColor: Colors.green,
                                value: 'Present',
                                groupValue: statusController.text,
                                onChanged: (value) {
                                  setState(() {
                                    statusController.text = value.toString();
                                  });
                                },
                              ),
                              //E------------------
                              Text(
                                'Present',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            _submitAttendance();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF184D47),
                            minimumSize: Size(
                              double.infinity,
                              50.0,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                            //F---------------------------
                          child: Text(
                            'Submit Attendance',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Display attendance data using StreamBuilder
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('attendance').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) {
                            var attendanceData = snapshot.data!.docs[index].data() as Map<String, dynamic>;

                            return Container(
                              margin: EdgeInsets.all( 11.0),
                              padding: EdgeInsets.all(1.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF184D47),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: ListTile(
                              //G--------------------------------------------------
                                title: Text(
                                    'Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(attendanceData['date'].toDate())}',
                                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                //F---------------------------------------------
                                subtitle: Text(
                                  'Status: ${attendanceData['status']}',
                                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitAttendance() {
    String status = statusController.text.trim();

    if (status.isNotEmpty) {
      FirebaseFirestore.instance.collection('attendance').add({
        'status': status,
        'date': DateTime.now(),
      });

      statusController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance recorded successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
    }
  }
}