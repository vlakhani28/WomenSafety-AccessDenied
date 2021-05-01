import 'package:flutter/material.dart';

class Place {
  final String name;
  final String state;
  final String country;
  final String county;
  final String district;
  final double lat;
  final double lnt;
  const Place({
    @required this.name,
    this.state,
    @required this.country,
    this.lat,
    this.lnt,
    this.county,
    this.district,
  })  : assert(name != null),
        assert(country != null);
  bool get hasState => state?.isNotEmpty == true;
  bool get hasCountry => country?.isNotEmpty == true;
  bool get isCountry => hasCountry && name == country;
  bool get isState => hasState && name == state;

  bool get hasDistrict => district?.isNotEmpty == true;
  bool get hasCounty => county?.isNotEmpty == true;
  bool get isCounty => hasCountry && name == county;
  bool get isDistrict => hasState && name == district;

  factory Place.fromJson(Map<String, dynamic> map) {
    final props = map['properties'];
    final coord = map['geometry'];
    return Place(
      name: props['name'] ?? '',
      state: props['state'] ?? '',
      country: props['country'] ?? '',
      county: props['country'] ?? '',
      district: props['district'] ?? '',
      lat: coord['coordinates'][1] ?? 0.0,
      lnt: coord['coordinates'][0] ?? 0.0,
    );
  }

  String get address {
    if (isCountry) return country;
    return '$name, $level2Address';
  }

  String get countys {
    if (isCounty || isDistrict || !hasDistrict) return county;
    if (!hasCounty) return district;
    return '$district, $county';
  }

  String get addressShort {
    if (isCountry) return country;
    return '$name, $country';
  }

  String get level2Address {
    if (isCountry || isState || !hasState) return country;
    if (!hasCountry) return state;
    return '$state, $country';
  }

  @override
  String toString() => 'Place(name: $name, state: $state, country: $country, district: $district , county: )';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Place && o.name == name && o.state == state && o.country == country;
  }

  @override
  int get hashCode => name.hashCode ^ state.hashCode ^ country.hashCode;
}