import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/model/ContactModel.dart';
import 'package:women_safety/providers/UserProvider.dart';
import 'package:women_safety/screens/AddEmergencyContact.dart';
import 'package:women_safety/utilities/constants.dart';
import 'package:women_safety/widgets/contact_tile.dart';

class EmergencyContactList extends StatefulWidget {
  @override
  _EmergencyContactListState createState() => _EmergencyContactListState();
}

class _EmergencyContactListState extends State<EmergencyContactList> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Emergency Contacts",
          style: kTitleStyle,
        ),
        elevation: 0.0,
      ),
      floatingActionButton: userProvider.contacts.length < 3
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddEmergencyContact("Add Emergency Contact"),
            ),
          );
        },
        child: Icon(Icons.person_add_alt),
        backgroundColor: primaryColor,
      )
          : null,
      body: Container(
        decoration: BoxDecoration(color: Color(0xfff5f3f4)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
              itemCount: userProvider.contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return ContactListItem(
                    name: userProvider.contacts[index].name,
                    phoneNumber: userProvider.contacts[index].mobileNumber,
                    relation: userProvider.contacts[index].relation,
                    index: userProvider.contacts[index].id);
              }),
        ),
      ),
    );
  }
}