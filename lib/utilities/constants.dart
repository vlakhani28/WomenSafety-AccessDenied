import 'package:flutter/material.dart';

const placeHolderColor = Color(0xffa5a1ad);
const primaryColor = Color(0xffb9375e);
const Color white = Colors.white;
const labelColor = Color(0xff6c757d);
const Color black = Colors.black;

const kTitleStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
    color: white);

const kLabelStyle = TextStyle(
  fontFamily: 'OpenSans',
  color: primaryColor,
  fontWeight: FontWeight.w400,
  fontSize: 16.0,
);

const kSubTitleStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: black);

const kTextFieldTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 18.0,
    color: white);

const kPlaceHolderStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w300,
    fontSize: 18.0,
    color: placeHolderColor);

const kBoxDecorationStyle = BoxDecoration(
  color: white,
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
