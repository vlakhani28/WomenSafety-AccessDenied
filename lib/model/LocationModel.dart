import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  static const SLAT = "Source Lat";
  static const SLON = "Source Long";
  static const DLAT = "Dest Lat";
  static const DLON = "Dest Long";
  static const INTENSITY = "Intensity_int";

  double _slat;
  double _slon;
  double _dlat;
  double _dlon;
  int _intensity;

  double get sla => _slat;

  double get slo => _slon;

  double get dla => _dlat;

  double get dlo => _dlon;

  int get slat => _intensity;

  LocationModel.fromSnapshot(DocumentSnapshot snapshot) {
    _slat = snapshot[SLAT];
    _slon = snapshot[SLON];
    _dlat = snapshot[DLAT];
    _slon = snapshot[DLON];
    _intensity = snapshot[INTENSITY];
  }
}