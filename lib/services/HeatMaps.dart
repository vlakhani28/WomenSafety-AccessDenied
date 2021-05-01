import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:collection';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:women_safety/utilities/Data.dart';
class Map1 {
  Set<Marker> _marker = HashSet<Marker>();
  Set<Polyline> _poly = HashSet<Polyline>();
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  List<LatLng> polylinedistance = [];
  List data = [];

  Future<Set> markers() async{
          for(int i=0;i<locations.length;i++) {
            double slong = locations[i]["Source Long"];
            double dlong = locations[i]["Dest Long"];
            double slat = locations[i]["Source Lat"];
            double dl = locations[i]["Dest Lat"];
            int intensity = locations[i]["Intensity_int"];
            print("Hello");
            print("hello");
            String url = "https://api.mapbox.com/directions/v5/mapbox/driving/" +
                slong.toString() + "%2C" + slat.toString() + "%3B" +
                dlong.toString() + "%2C" + dl.toString() +
                "?alternatives=true&geometries=geojson&steps=true&access_token=pk.eyJ1Ijoidmxha2hhbmkyOCIsImEiOiJja25ybDY2Z20wdTVxMnBuenlnbmswaXUxIn0.c_HoVkK6jd5M0cJasWNJWA";
            print(url);
            http.Response response = await http.get(Uri.parse(url));
            Map values = jsonDecode(response.body);
            var points = values["routes"][0]["geometry"]["coordinates"];
            Color col;
            if (points.isNotEmpty) {
              points.forEach((coo) {
                polylineCoordinates.add(LatLng(coo[1], coo[0]));
              }
              );
            }
            if (intensity == 1)
              col = Colors.green;
            else if (intensity == 2)
              col = Colors.yellow;
            else if (intensity == 3)
              col = Colors.red;
            _poly.add(
              Polyline(
                  polylineId: PolylineId(slong.toString()),
                  patterns: [PatternItem.dot],
                  jointType: JointType.round,
                  color: col,
                  points: polylineCoordinates
              ),
            );
          }
    return _poly;
 }

  Future<Set> marker(double lat, double lnt) async {
    _marker.add(Marker(
      markerId: MarkerId(lat.toString()),
      position: LatLng(lat, lnt),
    ),
    );
    return _marker;
  }

  Future<Polyline> direction(double sl,double slo, double dl, double dlo) async {
    String url = "https://api.mapbox.com/directions/v5/mapbox/driving/"+slo.toString()+"%2C"+sl.toString()+"%3B"+dlo.toString()+"%2C"+dl.toString()+"?alternatives=true&geometries=geojson&steps=true&access_token=pk.eyJ1Ijoidmxha2hhbmkyOCIsImEiOiJja25ybDY2Z20wdTVxMnBuenlnbmswaXUxIn0.c_HoVkK6jd5M0cJasWNJWA";
    polylinedistance.clear();
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);
    var points = values["routes"][0]["geometry"]["coordinates"];
    print(points);
    if (points.isNotEmpty) {
      points.forEach((coo) {
        polylinedistance.add(LatLng(coo[1], coo[0]));
      }
      );
    }
    return  Polyline(
        polylineId: PolylineId("directions"),
        color: Colors.blue.shade600,
        points: polylinedistance,
        width: 3
    );
  }

}