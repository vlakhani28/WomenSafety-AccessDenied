import 'package:flutter/material.dart';
import 'package:women_safety/utilities/constants.dart';
import 'package:flashlight/flashlight.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sms/flutter_sms.dart';

class CustomBottomBar extends StatefulWidget {
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  bool isturnon = false;
  IconData flashicon = Icons.flash_off;
  String sos = 'tel:+91 7977083785';
  String message = "SOS! HELP! I am in danger! Here is my Location!";
  List<String> recipents = ["+91 7977083785", "+91 9136897339"];
  Future<void> callnow() async {
    if (await canLaunch(sos)) {
      await launch(sos);
    } else {
      throw 'call not possible';
    }
  }

  Future<void> _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RawMaterialButton(
            onPressed: () {
              _sendSMS(message, recipents);
            },
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(
              Icons.message,
              size: 25.0,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
          RawMaterialButton(
            onPressed: () {
              print("hello");
              callnow();
            },
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(
              Icons.phone_in_talk,
              size: 25.0,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
          RawMaterialButton(
            onPressed: () {
              if (isturnon) {
                Flashlight.lightOff();
                setState(() {
                  isturnon = false;
                  flashicon = Icons.flash_off;
                });
              } else {
                //if light is off, then turn on.
                Flashlight.lightOn();
                setState(() {
                  isturnon = true;
                  flashicon = Icons.flash_on;
                });
              }
            },
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(
              flashicon,
              size: 25.0,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          )
        ],
      ),
    );
  }
}
