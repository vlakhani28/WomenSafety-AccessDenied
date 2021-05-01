import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/providers/UserProvider.dart';
import 'package:women_safety/screens/EmergencyContactList.dart';
import 'package:women_safety/screens/LoginScreen.dart';
import 'package:women_safety/screens/ResetPasswordScreen.dart';
import 'package:women_safety/screens/SelfDefenceScreen.dart';
import 'package:women_safety/utilities/constants.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0), bottomLeft: Radius.circular(40.0)),
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Image.asset(
                "assets/images/women_safety_logo.png",
                height: 50.0,
                width: 50.0,
              ),
              accountName: Text(
                user.userModel.name,
                style: kTitleStyle.copyWith(color: black),
              ),
              accountEmail: Text(
                user.userModel.email,
                style: kSubTitleStyle.copyWith(fontSize: 18.0),
              ),
              decoration: BoxDecoration(color: white),
            ),
            ListTile(
              leading: Icon(
                Icons.people_alt_rounded,
                color: primaryColor,
              ),
              title: Text('Emergency Contacts',
                  style: kTitleStyle.copyWith(color: primaryColor)),
              onTap: () async {
                await user.getContacts();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EmergencyContactList(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shield,
                color: primaryColor,
              ),
              title: Text('Defence Techniques',
                  style: kTitleStyle.copyWith(color: primaryColor)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SelfDefenceScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.lock,
                color: primaryColor,
              ),
              title: Text('Change Password',
                  style: kTitleStyle.copyWith(color: primaryColor)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResetPasswordScreen('Reset Password'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: primaryColor,
              ),
              title: Text('Help',
                  style: kTitleStyle.copyWith(color: primaryColor)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.article_rounded,
                color: primaryColor,
              ),
              title: Text('About Us',
                  style: kTitleStyle.copyWith(color: primaryColor)),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: labelColor),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: labelColor,
                ),
                title: Text('Sign Out',
                    style: kTitleStyle.copyWith(color: labelColor)),
                onTap: () {
                  user.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
