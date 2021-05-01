import 'package:flutter/material.dart';
import 'package:women_safety/utilities/constants.dart';

class CustomSnackbar {
  final String message;

  const CustomSnackbar({this.message});

  static show(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        content: Text(
          message,
          style: kPlaceHolderStyle.copyWith(color: white, fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
        duration: new Duration(seconds: 5),
      ),
    );
  }
}
