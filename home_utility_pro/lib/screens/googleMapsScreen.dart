import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_utility_pro/location/userLocation.dart';

// const double pinned_visible = 0;
// const double pinned_invisible = -250;

class GoogleMapScreen extends StatefulWidget {
  final Position position;
  final Map userPosition;
  GoogleMapScreen({this.position, this.userPosition});

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  double originLat;
  double originLng;
  double destLat;
  double destLng;
  String token =
      "pk.eyJ1IjoiYWRoc2F1Z2F0IiwiYSI6ImNrcWF5NXZiZjAydTMycHA2c2k3eW54dTcifQ.fkljJqBGEnhL8n85c8bGYA";
  Set<Marker> _markers = {};
  // BitmapDescriptor usericon;
  // BitmapDescriptor proicon;
  GoogleMapController _mapController;
  bool onPressed = false;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints = PolylinePoints();
  StreamSubscription myStreamSubscription;
  // Position userPosition;

  // void setIcon() async {
  //   usericon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(), 'images/blue.png');
  //   proicon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(devicePixelRatio: 0.6), 'images/red.png');
  // }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('images/map_style.json');
    _mapController.setMapStyle(style);
  }

  void _addPolyLine() {
    // print(polylineCoordinates);
    if (!mounted) return;
    setState(() {
      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blue,
          points: polylineCoordinates,
          width: 4);
      polylines[id] = polyline;
    });
  }

  void _getPolyline() async {
    var dio = Dio();
    try {
      final response = await dio.get(
          'https://api.mapbox.com/directions/v5/mapbox/driving/$originLng,$originLat;$destLng,$destLat?geometries=geojson&access_token=$token');

      List<dynamic> result =
          response.data["routes"][0]["geometry"]["coordinates"];
      result.forEach((element) {
        polylineCoordinates.add(LatLng(element[1], element[0]));
      });
    } catch (e) {
      print(e);
    }

    _addPolyLine();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _setMapStyle();
    _getPolyline();
  }

  void initState() {
    // database.getUserPosition(widget.proID);
    super.initState();
    originLat = widget.position.latitude;
    originLng = widget.position.longitude;
    destLat = widget.userPosition['lat'];
    destLng = widget.userPosition['lng'];
    print(widget.userPosition['lat']);
    print(widget.userPosition['lng']);
    updateMarkers(position: widget.position, userPosition: widget.userPosition);

    // setIcon();
  }

  void updateMarkers({Position position, Map userPosition}) {
    // _markers.clear();
    print(position);
    // setState(() {
    _markers.add(
      Marker(
        markerId: MarkerId('prosLocation'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(originLat, originLng),
        infoWindow: InfoWindow(title: 'Your location'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('userLocation'),
        icon: BitmapDescriptor.defaultMarkerWithHue(10),
        position: LatLng(destLat, destLng),
        infoWindow: InfoWindow(title: 'Your customer\'s location'),
      ),
    );
    // });
  }

  @override
  void dispose() {
    super.dispose();
    if (myStreamSubscription != null) myStreamSubscription.cancel();
    _mapController.dispose();
  }

  void startJourney() {
    myStreamSubscription =
        UserLocation().getPositionStream().listen((Position position) {
      print(position);
      LatLng latLng = LatLng(position.latitude, position.longitude);
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 19),
        ),
      );
    });
  }

  void endJourney() {
    myStreamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
                target:
                    LatLng(widget.position.latitude, widget.position.longitude),
                zoom: 13),
            mapType: MapType.normal,
            markers: _markers,
            zoomControlsEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            polylines: Set<Polyline>.of(polylines.values),
            onTap: (latLng) {
              // setState(() {
              //   this.pinpillposition = pinned_invisible;
              // });
            },
          ),
          Positioned(
            top: 60,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  onPressed = !onPressed;
                });
                if (onPressed)
                  startJourney();
                else
                  endJourney();
              },
              child: Text(onPressed ? 'End Journey' : 'Start Journey'),
            ),
          ),
        ],
      ),
    );
  }
}
