import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_utility/location/infobox.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:home_utility/location/userLocation.dart';

import '../constants.dart';
import '../main.dart';

const double pinned_visible = 0;
const double pinned_invisible = -250;

class GoogleMapScreen extends StatefulWidget {
  final DateTime dateTime;
  final String description;
  final String category;
  final String service;
  final DateTime date;
  final TimeOfDay time;
  final String municipality;
  final String district;
  final double latitude;
  final double longitude;
  final Map userLocation2;

  GoogleMapScreen({
    this.dateTime,
    this.description,
    this.category,
    this.service,
    this.date,
    this.time,
    this.municipality,
    this.district,
    this.latitude,
    this.longitude,
    this.userLocation2,
  });

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // final databaseReference = FirebaseDatabase.instance.reference();
  // double latitude = 27.6641822;
  // double longitude = 84.4315124;
  // Set<Marker> _markers = {};
  Set<Circle> _circles = HashSet<Circle>();
  List<Marker> _markers = [];
  BitmapDescriptor usericon;
  BitmapDescriptor proicon;
  GoogleMapController _mapController;
  var proID = 'id';
  var username = 'username';
  var address = 'address';
  var profession = 'Electrician';
  double rating = 0;
  double pinpillposition = pinned_invisible;
  // int _circleIdCounter = 1;
  bool sortByMunVDC = true;
  String _distanceValue;
  double _distanceValueNum;
  Map<String, double> _distanceMap = {
    '250 meter': 250,
    '500 meter': 500,
    '1 Kilometer': 1000,
    '1.25 Kilometer': 1250,
    '1.5 Kilometer': 1500,
    '2 Kilometer': 2000,
    '5 Kilometer': 5000,
    '10 Kilometer': 10000,
    '20 Kilometer': 20000,
  };

  void setIcon() async {
    usericon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/blue.png');
    proicon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/red.png');
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('images/map_style.json');
    _mapController.setMapStyle(style);
  }

  // Set<Marker> getMarkers() {
  //   return GetX<MarkersController>(
  //     builder: (markersController) {
  //       return Set.from(markersController.prosMarkers);
  //     },
  //   );
  // }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    prosWithinProximity();
    _setMapStyle();
  }

  StreamSubscription myStreamSubscription;

  void prosWithinProximity() {
    if (myStreamSubscription != null) myStreamSubscription.cancel();
    _markers.clear();
    // String category = professionToCategory(profession)
    myStreamSubscription = prosRefrence
        .orderByChild('profession')
        .equalTo('Electronics Technician')
        .onValue
        .listen((Event event) {
      Map pros = event.snapshot.value;
      pros.forEach((key, value) {
        double lat1 = value['location']['lat'];
        double lng1 = value['location']['lng'];
        double lat2 = widget.userLocation2['lat'];
        double lng2 = widget.userLocation2['lng'];
        double distance = Location().getDistance(lat1, lng1, lat2, lng2);
        // print(distance);
        if (distance <= _distanceValueNum) {
          print(_distanceValueNum);
          // print('hey');
          // print(lat1);
          setState(() {
            _markers.add(
              Marker(
                markerId: MarkerId(key),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
                position: LatLng(lat1, lng1),
                onTap: () {
                  username = value['prosName'];
                  address = value['prosMunicipality'];
                  rating = value['avgRating'];
                  proID = value['proID'];
                  setState(() {
                    pinpillposition = pinned_visible;
                  });
                },
              ),
            );
          });
          _circles.add(
            Circle(
              circleId: CircleId('user'),
              center: LatLng(lat1, lng1),
              radius: _distanceMap[_distanceValue],
              fillColor: Colors.tealAccent.withOpacity(0.2),
              strokeWidth: 3,
              strokeColor: Colors.tealAccent.withOpacity(0.6),
            ),
          );
        }
      });
    });
    _markers.add(
      Marker(
        markerId: MarkerId('user'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position:
            LatLng(widget.userLocation2['lat'], widget.userLocation2['lng']),
      ),
    );
    // myStreamSubscription.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (myStreamSubscription != null) myStreamSubscription.cancel();
    _mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _distanceValue = '250 meter';
    _distanceValueNum = _distanceMap[_distanceValue];
    super.initState();

    _markers.add(
      Marker(
        markerId: MarkerId('user'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position:
            LatLng(widget.userLocation2['lat'], widget.userLocation2['lng']),
      ),
    );
    // _circles.add(
    //   Circle(
    //     circleId: CircleId('pros'),
    //     center:
    //         LatLng(widget.userLocation2['lat'], widget.userLocation2['lng']),
    //     radius: _distanceMap[_distanceValue],
    //     fillColor: Colors.tealAccent.withOpacity(0.2),
    //     strokeWidth: 3,
    //     strokeColor: Colors.tealAccent.withOpacity(0.6),
    //   ),
    // );
    setIcon();
  }

  List<DropdownMenuItem<String>> _getItems() {
    List<DropdownMenuItem<String>> items = [];
    List<String> distances = [];
    _distanceMap.forEach((key, value) {
      distances.add(key);
    });
    for (String distance in distances) {
      items.add(
        DropdownMenuItem(
          child: Text(distance),
          value: distance,
        ),
      );
    }
    return items;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Utility Map',
          style: GoogleFonts.montserrat(),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.refresh),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              tooltip: 'Refresh',
              onPressed: iconButtonPressed,
            ),
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      widget.userLocation2['lat'], widget.userLocation2['lng']),
                  zoom: 14),
              mapType: MapType.normal,
              markers: Set.from(_markers),
              circles: Set.from(_circles),
              zoomControlsEnabled: true,
              // myLocationEnabled: false,
              myLocationButtonEnabled: true,
              onTap: (LatLng) {
                setState(() {
                  this.pinpillposition = pinned_invisible;
                });
              },
            ),
            Positioned(
              top: 20.0,
              left: 10.0,
              right: 10.0,
              child: Container(
                color: kWhiteColour,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Search Radius:  ',
                      style: GoogleFonts.montserrat(
                        color: kBlackColour,
                        fontSize: 20.0,
                      ),
                    ),
                    DropdownButton(
                      style: GoogleFonts.montserrat(
                        color: kBlackColour,
                        fontSize: 20.0,
                      ),
                      items: _getItems(),
                      value: _distanceValue,
                      onChanged: (newValue) {
                        setState(() {
                          _distanceValue = newValue;
                          _distanceValueNum = _distanceMap[_distanceValue];
                          prosWithinProximity();
                          print(_distanceValueNum);
                          // _circles.add('user');
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
                bottom: this.pinpillposition,
                child: RatingCard(
                  username: username,
                  address: address,
                  profession: profession,
                  rating: rating,
                  proID: proID,
                  dateTime: widget.dateTime,
                  description: widget.description,
                  category: widget.category,
                  service: widget.service,
                  date: widget.date,
                  time: widget.time,
                  municipality: widget.municipality,
                  district: widget.district,
                  latitude: widget.latitude,
                  longitude: widget.longitude,
                ))
          ],
        ),
      ),
    );
  }

  void iconButtonPressed() {}
}
