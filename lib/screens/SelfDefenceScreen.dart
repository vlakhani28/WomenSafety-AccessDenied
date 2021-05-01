import 'package:flutter/material.dart';
import 'package:women_safety/utilities/constants.dart';

class SelfDefenceScreen extends StatefulWidget {
  @override
  _SelfDefenceScreenState createState() => _SelfDefenceScreenState();
}

class _SelfDefenceScreenState extends State<SelfDefenceScreen> {
  List<String> images = [
    "https://wl-brightside.cf.tsp.li/resize/728x/jpg/b0f/def/a1a2a051c29e86d340c251b69e.jpg",
    "https://wl-brightside.cf.tsp.li/resize/728x/jpg/e17/4b6/f37c3058c389fdd723577d3894.jpg",
    "https://wl-brightside.cf.tsp.li/resize/728x/jpg/acb/66c/ae5f5257f59ad3c8c9128c090e.jpg",
    "https://wl-brightside.cf.tsp.li/resize/728x/jpg/6f2/827/2621055f00ba909acf187b08e3.jpg",
    "https://wl-brightside.cf.tsp.li/resize/728x/jpg/688/bc9/c9777352a8951625ebaf6bf919.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            "Self Defence Techniques",
            style: kTitleStyle,
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var i in images)
                    Image.network(
                      i,
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
