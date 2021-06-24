import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:home_utility_pro/location/userLocation.dart';
import 'package:home_utility_pro/main.dart';

const double pinned_visible = 0;
const double pinned_invisible = -250;

class GoogleMapScreen extends StatefulWidget {
  //
  final Position position;
//
  GoogleMapScreen({this.position});
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  double latitude = 27.6641822;
  double longitude = 84.4315124;
  List<Marker> _markers = [];
  BitmapDescriptor usericon;
  BitmapDescriptor proicon;
  GoogleMapController _mapController;

  var username = 'username';
  var address = 'address';
  var profession = 'Electrician';
  double rating = 0.0;
  double pinpillposition = pinned_invisible;

  // UserLocation location = UserLocation();
  // Stream myPositionStream;
  StreamSubscription myStreamSubscription;

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
    // _mapCompleter.futu
  }

  void _onMapCreated(GoogleMapController controller) {
    // setState(() {
    _mapController = controller;
    // _mapCompleter.future.then((value) => null)

    // databaseReference.child("pros").once().then((DataSnapshot snapshot) {
    //   Map<dynamic, dynamic> data = snapshot.value;
    //   data.forEach((key, value) {
    //     // if (!mounted) return;
    //     setState(() {
    // _markers.add(Marker(
    //     markerId: MarkerId(value['proID']),
    //     position:
    //         LatLng(value['location']['lat'], value['location']['lng']),
    //     icon: proicon,
    //     onTap: () {
    //       setState(() {
    //         username = value['prosName'];
    //         address = value['prosMunicipality'];
    //         rating = value['avgRating'];

    //         pinpillposition = pinned_visible;
    //       });
    //           }));
    //     });
    //     // setState(() {});
    //   });
    // });
    _setMapStyle();
    // });
  }

  @override
  void initState() {
    super.initState();
    print('${widget.position} from here');
    // myPositionStream = location.getPositionStream();
    updateMarkers(position: widget.position);
    // prosRefrence
    //     .child(userAuthentication.userID)
    //     .child('location')
    //     .once()
    //     .then((DataSnapshot snapshot) {
    //   Map location = snapshot.value;
    //   _markers.add(Marker(
    //       markerId: MarkerId('userLocation'),
    //       position: LatLng(location['lat'], location['lng']),
    //       icon: usericon,
    //       onTap: () {
    //         // setState(() {
    //         //   username = value['prosName'];
    //         //   address = value['prosMunicipality'];
    //         //   rating = value['avgRating'];

    //         //   pinpillposition = pinned_visible;
    //         // });
    //       }));
    // });
    setIcon();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (myStreamSubscription != null) myStreamSubscription.cancel();
    super.dispose();
  }

  void startJourney() {
    myStreamSubscription =
        UserLocation().getPositionStream().listen((Position position) {
      print(position);
      LatLng latLng = LatLng(position.latitude, position.longitude);
      _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      widget.position.latitude, widget.position.longitude),
                  zoom: 14),
              mapType: MapType.normal,
              markers: Set<Marker>.from(_markers),
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onTap: (LatLng) {}
              //   setState(() {
              //     this.pinpillposition = pinned_invisible;
              //   });
              // },
              ),
          Positioned(
              top: 50,
              left: 50,
              child: ElevatedButton(
                onPressed: () {
                  startJourney();
                },
                child: Text('Start Journey'),
              )),
          // StreamBuilder(
          //     stream: UserLocation().getPositionStream(),
          //     builder: (context, snapshot) {
          // LatLng latLng =
          //     LatLng(snapshot.data.latitude, snapshot.data.longitude);

          //       // _mapCompleter.

          //       _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
          //       return Container();
          //     }),
          // AnimatedPositioned(
          //   duration: Duration(milliseconds: 500),
          //   curve: Curves.easeOut,
          //   bottom: this.pinpillposition,
          //   child: null,
          //   // child: RatingCard(username, address, profession, rating))
          // ),
        ],
      ),
      // }),
    );
  }

  void updateMarkers({Position position}) {
    // _markers.clear();
    print(position);
    // setState(() {
    _markers.add(
      Marker(
        markerId: MarkerId('prosLocation'),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(position.latitude, position.longitude),
      ),
    );
    // });

    // print(markers);
  }

  // void updateMarkers(double lat, double lng) {
  //   _markers.clear();
  //   if (lat == null && lng == null)
  //     prosRefrence
  //         .child(userAuthentication.userID)
  //         .child('location')
  //         .once()
  //         .then((DataSnapshot snapshot) {
  //       Map location = snapshot.value;
  //       print(location);
  //       setState(() {
  //         _markers.add(Marker(
  //             markerId: MarkerId('userLocation'),
  //             position: LatLng(location['lat'], location['lng']),
  //             icon: proicon,
  //             onTap: () {}));
  //       });
  //     });
  //   else {}
  //   // print(markers);
  // }

}
