import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:women_safety/providers/UserProvider.dart';
import 'package:women_safety/screens/LoginScreen.dart';
import 'package:women_safety/screens/Maps.dart';
import 'package:women_safety/screens/SplashScreen.dart';
import 'package:women_safety/utilities/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider.initialize(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryColor));
    return MaterialApp(
      title: 'Women Safety',
      debugShowCheckedModeBanner: false,
      home: ScreenController(),
    );
  }
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return SplashScreen();
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return MapScreen();
      case Status.Unauthenticated:
        return SplashScreen();
      default:
        return LoginScreen();
    }
  }
}
