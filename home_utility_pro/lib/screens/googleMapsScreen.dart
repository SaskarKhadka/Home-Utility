import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_utility_pro/components/info.dart';

const double pinned_visible = 0;
const double pinned_invisible = -250;


class GoogleMapScreen extends StatefulWidget {
  

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

double origin_lat = 27.6641822 ;
 double origin_lng=84.4315124;
 double dest_lat = 27.705373051353;
 double dest_lng = 84.43938626267538;
 String token = "pk.eyJ1IjoiYWRoc2F1Z2F0IiwiYSI6ImNrcWF5NXZiZjAydTMycHA2c2k3eW54dTcifQ.fkljJqBGEnhL8n85c8bGYA";
Set<Marker> _markers = {};
 BitmapDescriptor usericon;
 BitmapDescriptor proicon;
GoogleMapController _mapController ;
var username = 'username';
var address = 'address';
var profession = 'Electrician';
double rating = 0;
double pinpillposition = pinned_invisible;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  

void setIcon() async{
  usericon= await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/blue.png');
  proicon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 0.6), 'images/red.png');
}

void _setMapStyle()async{
  String style = await DefaultAssetBundle.of(context).loadString('images/map_style.json');
  _mapController.setMapStyle(style);
}



void _addPolyLine() {
   print(polylineCoordinates);
    setState(() {
       PolylineId id = PolylineId("poly");
        Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, points: polylineCoordinates,width: 4);
        polylines[id] = polyline;
    });
 }

 void _getPolyline() async {
                     var dio = Dio();
                    final response = await dio.get('https://api.mapbox.com/directions/v5/mapbox/cycling/$origin_lng,$origin_lat;$dest_lng,$dest_lat?geometries=geojson&access_token=$token');
                    
                   List<dynamic> result =    response.data["routes"][0]["geometry"]["coordinates"];
                  result.forEach((element) {
                      polylineCoordinates.add(LatLng(element[1], element[0]));
                  });
    _addPolyLine();
    
}


void _onMapCreated(GoogleMapController controller){
    _mapController = controller;
    setState(() {
      _markers.add(Marker(
                    markerId: MarkerId("0"),
                    position: LatLng(origin_lat, origin_lng),
                    icon: usericon,
                    onTap: (){
                      setState(() {
                        username = 'Saugat Adhikari';
                        address = 'Bharatpur,Chitwan';
                        rating = 0;

                        pinpillposition = pinned_visible;
                      });
                    }
                  ));
       _markers.add(Marker(
                    markerId: MarkerId("1"),
                    position: LatLng(dest_lat,dest_lng),
                    icon: proicon,
                    onTap: (){
                      setState(() {
                        username = 'Professional User';
                        address = 'Bharatpur,Chitwan';
                        rating = 4.5;

                        pinpillposition = pinned_visible;
                      });
                    }
                  ));
    });
            
  
    _setMapStyle();
    _getPolyline();
  
    
}


  void initState() { 
    super.initState();
    setIcon();

  }
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: LatLng(origin_lat, origin_lng),zoom: 13),
            mapType: MapType.normal,
            markers: _markers,
            zoomControlsEnabled: true,
            polylines: Set<Polyline>.of(polylines.values),
          
            onTap: (LatLng){
                setState(() {
                  this.pinpillposition = pinned_invisible;
                });
            },
            
            ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
            bottom: this.pinpillposition,
            
            child: RatingCard(username, address, profession,rating))  
        ],
      ),

    );
}}