import 'dart:async';
import 'dart:math';
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:women_safety/services/HeatMaps.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flashlight/flashlight.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:women_safety/services/place.dart';
import 'package:women_safety/services/search_model.dart';
import 'package:shake/shake.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:women_safety/widgets/drawer.dart';
import 'package:women_safety/utilities/constants.dart';
import 'package:women_safety/widgets/CustomBottomBar.dart';
import 'package:women_safety/providers/UserProvider.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);
  _MapScreen createState() => _MapScreen();
}
class _MapScreen extends State<MapScreen> {
  final actions = [
    FloatingSearchBarAction.searchToClear(),
  ];
  final controller = FloatingSearchBarController();
  Set<Marker> _marker = HashSet<Marker>();
  Set<Polyline> _poly = HashSet<Polyline>();
  Map1 ob = new Map1();
  LocationData _currentPosition;
  String _address, _dateTime;
  Marker marker;
  Location location = Location();
  Completer<GoogleMapController> _cont = Completer();
  GoogleMapController _controller;
  LatLng _initialcameraposition =  LatLng(19.2797976,72.8702947);
  final _auth = FirebaseAuth.instance;
  bool isturnon = false;
  IconData flashicon = Icons.flash_off;
  String sos = 'tel:+91 7977083785';
  List<String> recipents = ["+91 7977083785", "+91 9136897339"];
  var _control = FloatingSearchBarController();
  double latt,lntt;
  Future<void> callnow() async {
    if (await canLaunch(sos)) {
      await launch(sos);
    } else {
      throw 'call not possible';
    }
  }

  Future<void> _sendSMS(List<String> recipents) async {
    _currentPosition = await location.getLocation();
    String message = "SOS! HELP! I am in danger! Here is my Location! https://google.com/maps/place/"+_currentPosition.latitude.toString()+" "+_currentPosition.longitude.toString();
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  void _setDirection(double dlat, dlong) async {
    _poly.add(
        await ob.direction(_currentPosition.latitude, _currentPosition.longitude, dlat, dlong)
    );
  }
  void _setCircles() async {
    _poly = await ob.markers();
  }
  void _setMarker(double lat,double lnt) async {
    _marker = await ob.marker(lat,lnt);
  }

  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      _sendSMS(recipents);
    });
    _setCircles();
    getLoc();
  }

  void _onMapCreated(GoogleMapController _cntlr) async{
    getLoc();
    _controller = await _controller;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
    setState(() {
      _setCircles();
    });
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        _getAddress(_currentPosition.latitude, _currentPosition.longitude)
            .then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
          });
        });
      });
    });
  }
  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }
  int _index = 0;
  int get index => _index;
  set index(int value) {
    _index = min(value, 2);
    _index == 2 ? controller.hide() : controller.show();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return ChangeNotifierProvider(
      create: (_) => SearchModel(),
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Text(
                "W-Safety",
                style: kTitleStyle,
              ),
              elevation: 0.0,
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: white,
                    ),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: CustomBottomBar(),
            endDrawer: CustomDrawer(),
            resizeToAvoidBottomInset: false,
            body: Consumer<SearchModel>(
              builder: (context, model, _) => FloatingSearchBar(
                automaticallyImplyBackButton: false,
                controller: controller,
                clearQueryOnClose: true,
                hint: 'Search',
                iconColor: Colors.grey,
                transitionDuration: const Duration(milliseconds: 800),
                transitionCurve: Curves.easeInOutCubic,
                physics: const BouncingScrollPhysics(),
                axisAlignment: isPortrait ? 0.0 : -1.0,
                openAxisAlignment: 0.0,
                automaticallyImplyDrawerHamburger: false,
                actions: actions,
                progress: model.isLoading,
                debounceDelay: const Duration(milliseconds: 500),
                onQueryChanged: model.onQueryChanged,
                scrollPadding: EdgeInsets.zero,
                transition: CircularFloatingSearchBarTransition(spacing: 16),
                builder: (context, _) => Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Material(
                    color: Colors.white,
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8),
                    child: ImplicitlyAnimatedList<Place>(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      items: model.suggestions.take(6).toList(),
                      areItemsTheSame: (a, b) => a == b,
                      itemBuilder: (context, animation, place, i) {
                        return SizeFadeTransition(
                          animation: animation,
                          child: buildItem(context, place),
                        );
                      },
                      updateItemBuilder: (context, animation, place) {
                        return FadeTransition(
                          opacity: animation,
                          child: buildItem(context, place),
                        );
                      },
                    ),
                  ),
                ),
                body: Center(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: _initialcameraposition,
                        zoom: 15),
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    markers: _marker,
                    polylines: _poly,
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, Place place) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final model = Provider.of<SearchModel>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            FloatingSearchBar.of(context).close();
            Future.delayed(
              const Duration(milliseconds: 500),
                  () => model.clear(),
            );
            latt = place.lat;
            lntt = place.lnt;
            setState(() {
              _poly.clear();
              _setCircles();
              _marker.clear();
              _setMarker(latt, lntt);
              _setDirection(latt, lntt);
              // _controller.animateCamera(CameraUpdate.newLatLng(LatLng(latt, lntt)));
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: model.suggestions == history
                        ? const Icon(Icons.history, key: Key('history'))
                        : const Icon(Icons.place, key: Key('place')),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: textTheme.subtitle1,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        place.countys,
                        style: textTheme.bodyText2.copyWith(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        place.level2Address,
                        style: textTheme.bodyText2.copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (model.suggestions.isNotEmpty && place != model.suggestions.last)
          const Divider(height: 0),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}
