import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the Flutter SVG package

import 'login_page.dart';

class SignOut extends StatelessWidget {
  static String routeName = 'SignOut';
  const SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Wrap the ElevatedButton in a Container to set the background color
      color: Colors.white, // Set the background color to white
      child: ElevatedButton(
        onPressed: () async {
          await _signOut(context);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // Set the button color to white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //A----------------------------
            SvgPicture.asset(
              'assets/icons/logout.svg', // Replace 'assets/logout.svg' with the path to your logout.svg file
              color: Colors.teal, // Set the icon color to teal
              width: 24, // Adjust the width as needed
              height: 70, // Adjust the height as needed
            ),
            //B----------------------------
            const SizedBox(
                height: 17), // Add some space between the icon and the text
            const Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 30,
                color: Colors.teal, // Set the text color to teal
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } catch (error) {
      // Handle any errors during sign-out (e.g., display an error message)
      debugPrint(error.toString());
    }
  }
}
