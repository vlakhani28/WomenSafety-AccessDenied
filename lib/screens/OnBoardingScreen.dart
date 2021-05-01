import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:women_safety/model/OnBoardingModel.dart';
import 'package:women_safety/screens/LoginScreen.dart';
import 'package:women_safety/utilities/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : placeHolderColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blueGrey.shade300));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                      ),
                    },
                    child: Text('Skip',
                        style: kTitleStyle.copyWith(
                            fontSize: 18.0, color: labelColor)),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(pages[i].image),
                              height: 300,
                              width: 300,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              pages[i].title,
                              style: kTitleStyle.copyWith(
                                  fontSize: 30.0, color: primaryColor),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              pages[i].description,
                              style: kLabelStyle.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                Container(
                  height: 60,
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      _currentPage == pages.length - 1 ? "Continue" : "Next",
                      style: kTitleStyle.copyWith(color: white),
                    ),
                    onPressed: () {
                      if (_currentPage == pages.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LoginScreen(),
                          ),
                        );
                        print("Continue Tapped");
                      }
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.bounceIn,
                      );
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.all(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
