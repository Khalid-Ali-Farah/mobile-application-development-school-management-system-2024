import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveApplicationScreen extends StatefulWidget {
  static String routeName = 'LeaveApplicationScreen';

  const LeaveApplicationScreen({Key? key}) : super(key: key);

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  TextEditingController dateinputfrom = TextEditingController();
  TextEditingController dateinputto = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController totalDaysController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF184D47),
      //A------------------------------
      appBar: AppBar(
        title: const Text('Leave Application'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //B------------------------------
                Icon(
                  Icons.list_alt,
                  size: 90,
                  color: Colors.white,
                ),
                Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      //C------------------------------
                      child: Text(
                        "Leave information:",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please from date';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Color(
                            0xFF184D47), // Set your desired text color here
                      ),
                      controller: dateinputfrom,
                      //D------------------------------
                      decoration: InputDecoration(
                      labelText: "From Date",
                        labelStyle: TextStyle(
                          color: Color(0xFF184D47),
                          fontSize:
                              16, // Replace 0xFF00FF00 with your custom color code
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);

                              setState(() {
                                dateinputfrom.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          //E------------------------------
                          icon: const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF184D47),
                          ),
                        ),
                      ),
                      readOnly: true,
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter to date';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Color(
                            0xFF184D47), // Set your desired text color here
                      ),
                      controller: dateinputto,
                      //F-----------------------------
                      decoration: InputDecoration(
                        labelText: "To Date",
                        labelStyle: TextStyle(
                          color: Color(0xFF184D47),
                          fontSize:
                              20, // Replace 0xFF00FF00 with your custom color code
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);

                              setState(() {
                                dateinputto.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          //G------------------------------
                          icon: const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF184D47),
                          ),
                        ),
                      ),
                      readOnly: true,
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter reason';
                        }
                        return null;
                      },
                      controller: reasonController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      style: TextStyle(
                        color: Color(0xFF184D47),
                      ),
                      decoration: InputDecoration(
                        //H------------------------------
                      prefixIcon: Icon(
                          Icons.edit,
                          color: Color(0xFF184D47),
                        ),
                        //I------------------------------
                        labelText: 'Reason for leave',
                        labelStyle: TextStyle(
                          color: Color(0xFF184D47),
                          fontSize:
                              16, // Replace 0xFF00FF00 with your custom color code
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        width: 350,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.teal),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              showConfirmationDialog();
                            }
                          },
                          //J------------------------------
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showConfirmationDialog() {
    // Calculate the total number of days
    DateTime fromDateTime = DateFormat('dd-MM-yyyy').parse(dateinputfrom.text);
    DateTime toDateTime = DateFormat('dd-MM-yyyy').parse(dateinputto.text);
    int totalDays = toDateTime.difference(fromDateTime).inDays + 1;

    // Update the totalDaysController
    totalDaysController.text = totalDays.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            // title: Text('Leave Application Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  //K------------------------------
                child: Icon(
                    Icons.list_alt,
                    size: 90,
                    color: Colors.teal,
                  ),
                ),
                //L------------------------------
                Text(
                  'Leave Application Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 21),
                ),
                //M------------------------------
                Text(
                  'From Date:  ${dateinputfrom.text}',
                  style: TextStyle(color: Colors.teal, fontSize: 21),
                ),
                //N------------------------------
                Text(
                  'To Date: ${dateinputto.text}',
                  style: TextStyle(color: Colors.teal, fontSize: 21),
                ),
                //O------------------------------
                Text(
                  'Reason: ${reasonController.text}',
                  style: TextStyle(color: Colors.teal, fontSize: 21),
                ),
                //P------------------------------
                Text(
                  'Total Days: ${totalDaysController.text}',
                  style: TextStyle(color: Colors.teal, fontSize: 21),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  saveLeaveApplication();
                },
                //Q------------------------------
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                //U------------------------------
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> saveLeaveApplication() async {
    try {
      String fromDate = dateinputfrom.text;
      String toDate = dateinputto.text;
      String reason = reasonController.text;

      DateTime fromDateTime = DateFormat('dd-MM-yyyy').parse(fromDate);
      DateTime toDateTime = DateFormat('dd-MM-yyyy').parse(toDate);

      // Calculate the total number of days
      int totalDays = toDateTime.difference(fromDateTime).inDays + 1;

      Map<String, dynamic> leaveApplicationData = {
        'fromDate': fromDate,
        'toDate': toDate,
        'totalDays': totalDays.toString(),
        'reason': reason,
      };

      await FirebaseFirestore.instance
          .collection('leaveApplications')
          .doc(user!.uid)
          .set(leaveApplicationData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Leave application submitted successfully'),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pop(context); // Go back to the previous screen
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting leave application'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
