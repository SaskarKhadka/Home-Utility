import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_utility/location/infobox.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:home_utility/location/userLocation.dart';

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
  });

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  double latitude = 27.6641822;
  double longitude = 84.4315124;
  Set<Marker> _markers = {};
  BitmapDescriptor usericon;
  BitmapDescriptor proicon;
  GoogleMapController _mapController;
  var proID = 'id';
  var username = 'username';
  var address = 'address';
  var profession = 'Electrician';
  double rating = 0;
  double pinpillposition = pinned_invisible;

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

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    databaseReference.child("pros").once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> data = snapshot.value;
      data.forEach((key, value) {
        double distance = Location().getDistance(
          latitude + 0.00006,
          longitude,
          value['location']['lat'],
          value['location']['lng'],
        );
        print(distance);

        setState(() {
          _markers.add(Marker(
              markerId: MarkerId(value['proID']),
              position:
                  LatLng(value['location']['lat'], value['location']['lng']),
              icon: proicon,
              onTap: () {
                username = value['prosName'];
                address = value['prosMunicipality'];
                rating = value['avgRating'];
                proID = value['proID'];
                setState(() {
                  pinpillposition = pinned_visible;
                });
              }));
        });
      });
    });

    _setMapStyle();
  }

  @override
  void initState() {
    super.initState();
    setIcon();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(latitude, longitude), zoom: 14),
            mapType: MapType.normal,
            markers: _markers,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onTap: (LatLng) {
              setState(() {
                this.pinpillposition = pinned_invisible;
              });
            },
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
    );
  }
}
