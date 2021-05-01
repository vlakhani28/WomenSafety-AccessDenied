import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/providers/UserProvider.dart';
import 'package:women_safety/utilities/constants.dart';
import 'package:women_safety/widgets/CustomSnackBar.dart';

class ContactListItem extends StatelessWidget {
  final String phoneNumber;
  final String name;
  final String relation;
  final String index;

  const ContactListItem(
      {Key key, this.phoneNumber, this.name, this.relation, this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async {
            bool success = await userProvider.removeSingleContact(index);
            if (success) {
              userProvider.reloadContacts();
              CustomSnackbar.show(context, 'Contact Removed');
            } else {
              CustomSnackbar.show(context, "Contact Didn't Removed");
            }
          },
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.person, color: primaryColor),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    name,
                    style: kTitleStyle.copyWith(color: primaryColor),
                  )
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Icon(Icons.phone, color: primaryColor),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    phoneNumber,
                    style: kLabelStyle.copyWith(fontSize: 18.0),
                  )
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Icon(Icons.assignment_ind, color: primaryColor),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    relation,
                    style: kLabelStyle.copyWith(fontSize: 18.0),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}