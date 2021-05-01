import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety/model/LocationModel.dart';

class LocationServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "locations";
  Future<List<LocationModel>> getLocation() async =>
      _firestore
          .collection(collection)
          .get()
          .then(
            (result) {
          List<LocationModel> heatpoints = [];
          for (DocumentSnapshot loc in result.docs) {
            heatpoints.add(LocationModel.fromSnapshot(loc));
          }
          return heatpoints;
        },
      );

}