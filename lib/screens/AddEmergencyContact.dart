import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:women_safety/providers/UserProvider.dart';
import 'package:women_safety/utilities/constants.dart';
import 'package:women_safety/widgets/CustomSnackBar.dart';

class AddEmergencyContact extends StatefulWidget {
  final String appBarTitle;
  AddEmergencyContact(this.appBarTitle);
  @override
  _AddEmergencyContactState createState() =>
      _AddEmergencyContactState(this.appBarTitle);
}

class _AddEmergencyContactState extends State<AddEmergencyContact> {
  String appBarTitle;
  _AddEmergencyContactState(this.appBarTitle);
  final _addContactformKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _mobileNumber = TextEditingController();
  TextEditingController _relation = TextEditingController();

  Widget _buildAddButton() {
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          'Add',
          style: kTitleStyle,
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            primary: primaryColor,
            padding: EdgeInsets.all(10.0)),
        onPressed: () async {
          var uuid = Uuid();
          var id = uuid.v4();

          bool success = await userProvider.addSingleContact(
              _name.text, _relation.text, _mobileNumber.text, id);
          if (success) {
            CustomSnackbar.show(context, 'Contact Added');
            Navigator.pop(context);
            userProvider.reloadContacts();
          } else {
            CustomSnackbar.show(context, 'Contact Not Added');
          }
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
            key: _addContactformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Name',
                  style: kLabelStyle,
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: kBoxDecorationStyle,
                  child: TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.name,
                    style: kTextFieldTextStyle.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your Name",
                      hintStyle: kPlaceHolderStyle,
                      prefixIcon: Icon(
                        Icons.person,
                        color: labelColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Mobile Number',
                  style: kLabelStyle,
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: kBoxDecorationStyle,
                  child: TextFormField(
                    controller: _mobileNumber,
                    keyboardType: TextInputType.number,
                    style: kTextFieldTextStyle.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your Mobile Number",
                      hintStyle: kPlaceHolderStyle,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: labelColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Relation',
                  style: kLabelStyle,
                ),
                SizedBox(height: 10.0),
                Container(
                  decoration: kBoxDecorationStyle,
                  child: TextFormField(
                    controller: _relation,
                    keyboardType: TextInputType.name,
                    style: kTextFieldTextStyle.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Relation",
                      hintStyle: kPlaceHolderStyle,
                      prefixIcon: Icon(
                        Icons.assignment_ind,
                        color: labelColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _buildAddButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
