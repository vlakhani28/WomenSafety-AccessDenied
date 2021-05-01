// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/providers/UserProvider.dart';
import 'package:women_safety/screens/Maps.dart';
import 'package:women_safety/screens/RegisterScreen.dart';
import 'package:women_safety/utilities/constants.dart';
import 'package:women_safety/widgets/Loading.dart';
import 'package:women_safety/screens/ResetPasswordScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  bool _passwordVisible = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text('Forgot Password?'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ResetPasswordScreen('Forgot Password'),
            ),
          );
        },
        style: TextButton.styleFrom(
            primary: primaryColor, backgroundColor: Colors.transparent),
      ),
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          'LOGIN',
          style: kTitleStyle,
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            primary: primaryColor,
            padding: EdgeInsets.all(10.0)),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            {
              if (!await user.signIn(_email.text, _password.text, context)) {
                return null;
              } else {
                return Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MapScreen(),
                  ),
                );
              }
            }
          }
        },
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => RegisterScreen(),
          ),
        ),
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: kTextFieldTextStyle.copyWith(color: labelColor),
            ),
            TextSpan(
              text: 'Sign Up',
              style: kTitleStyle.copyWith(
                  fontWeight: FontWeight.w500, color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        key: _key,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: user.status == Status.Authenticating
              ? Loading()
              : Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 80.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'Log In',
                                  style: kTitleStyle.copyWith(
                                      fontSize: 30.0, color: primaryColor),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'Email',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: kBoxDecorationStyle,
                                child: TextFormField(
                                  controller: _email,
                                  keyboardType: TextInputType.emailAddress,
                                  style: kTextFieldTextStyle.copyWith(
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: white,
                                    border: InputBorder.none,
                                    hintText: "Enter your Email",
                                    hintStyle: kPlaceHolderStyle,
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: labelColor,
                                    ),
                                  ),
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return 'Please Enter Your Email';
                                  //   }
                                  //   Pattern pattern =
                                  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  //   RegExp regex = new RegExp(pattern);
                                  //   if (!regex.hasMatch(value)) {
                                  //     return CustomSnackbar.show(context,
                                  //         'Please Enter Valid Email Address');
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Password',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: kBoxDecorationStyle,
                                child: TextFormField(
                                  obscureText: !_passwordVisible,
                                  controller: _password,
                                  keyboardType: TextInputType.emailAddress,
                                  style: kTextFieldTextStyle.copyWith(
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter your Password",
                                    hintStyle: kPlaceHolderStyle,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: labelColor,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: labelColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  //
                                ),
                              ),
                              SizedBox(height: 10.0),
                              _buildForgotPasswordBtn(),
                              _buildLoginBtn(context),
                              _buildSignupBtn()
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
