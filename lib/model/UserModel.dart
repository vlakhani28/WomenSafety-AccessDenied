import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const ADDRESS = "address";
  static const MOBILENUMBER = "mobileNumber";

  String _name;
  String _email;
  String _address;
  String _mobileNumber;
  String _id;

  String get name => _name;
  String get email => _email;
  String get address => _address;
  String get mobileNumber => _mobileNumber;
  String get id => _id;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot[NAME];
    _email = snapshot[EMAIL];
    _address = snapshot[ADDRESS];
    _mobileNumber = snapshot[MOBILENUMBER];
    _id = snapshot[ID];
  }
}