import 'package:flutter/material.dart';
import 'package:women_safety/screens/OnBoardingScreen.dart';
import 'package:women_safety/utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/women_safety_logo.png',
                height: 120.0,
                width: 120.0,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'W-Safety',
                  style:
                      kTitleStyle.copyWith(fontSize: 30.0, color: primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    var d = Duration(seconds: 3);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => OnBoardingScreen(),
          ),
          (route) => false);
    });
  }
}
