import 'package:flutter/material.dart';
import 'package:women_safety/screens/LoginScreen.dart';
import 'package:women_safety/utilities/constants.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String appBarTitle;
  ResetPasswordScreen(this.appBarTitle);
  @override
  _ResetPasswordScreenState createState() =>
      _ResetPasswordScreenState(this.appBarTitle);
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String appBarTitle;
  _ResetPasswordScreenState(this.appBarTitle);
  final _key = GlobalKey<ScaffoldState>();
  final _forgotPasswordKey = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();

  Widget _buildResetButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          'Reset Link',
          style: kTitleStyle,
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            primary: primaryColor,
            padding: EdgeInsets.all(10.0)),
        onPressed: () async {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          appBarTitle,
          style: kTitleStyle,
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
          child: Form(
            key: _forgotPasswordKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Email',
                  style: kLabelStyle.copyWith(fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: kBoxDecorationStyle,
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    style: kTextFieldTextStyle.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your Email Address",
                      hintStyle: kPlaceHolderStyle,
                      prefixIcon: Icon(
                        Icons.email,
                        color: labelColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _buildResetButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
