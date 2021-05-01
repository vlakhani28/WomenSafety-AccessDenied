import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety/model/ContactModel.dart';
import 'package:women_safety/model/UserModel.dart';

class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "users";
  String contactCollection = "contacts";

  createUser(Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(data["id"]).set(data);
      print("User Created");
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then(
            (doc) {
          print("==========id is $id=============");
          print(doc);
          return UserModel.fromSnapshot(doc);
        },
      );

  void addContact(Map<String, dynamic> data, String id) async {
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .collection(contactCollection)
          .doc(data['id'])
          .set(data);
      print('Contact Added');
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }

  void removeContact(String contactId, String id) async {
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .collection(contactCollection)
          .doc(contactId)
          .delete();
      print('Contact Removed');
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }

  Future<List<ContactModel>> getEmergencyContacs({String userId}) async =>
      _firestore
          .collection(collection)
          .doc(userId)
          .collection(contactCollection)
          .get()
          .then(
            (result) {
          List<ContactModel> contacts = [];
          for (DocumentSnapshot contact in result.docs) {
            contacts.add(ContactModel.fromSnapshot(contact));
          }
          return contacts;
        },
      );
}