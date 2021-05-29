import 'package:geolocator/geolocator.dart';

class UserLocation {
  Future<Position> getLocation() async {
    // bool serviceEnabled;
    // LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // permission = await Geolocator.checkPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    return position;
  }
}
