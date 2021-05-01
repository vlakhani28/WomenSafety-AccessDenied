import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  static const NAME = "name";
  static const RELATION = 'relation';
  static const MOBILENUMBER = "mobileNumber";
  static const ID = "id";

  String _name;
  String _relation;
  String _mobileNumber;
  String _id;

  String get name => _name;
  String get relation => _relation;
  String get mobileNumber => _mobileNumber;
  String get id => _id;

  ContactModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot[NAME];
    _relation = snapshot[RELATION];
    _mobileNumber = snapshot[MOBILENUMBER];
    _id = snapshot[ID];
  }
}