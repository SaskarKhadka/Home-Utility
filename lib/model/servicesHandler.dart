import 'dart:collection';

import 'services.dart';

class ServiceHandler {
  final List<HomeServices> _homeServices = [
    HomeServices('Home Cleaning', 'images/img-1.jpg'),
    HomeServices('Electrical Services', 'images/img-3.jpg'),
    HomeServices('Plumbing', 'images/img-2.jpg'),
    HomeServices('Home Painting', 'images/img-4.jpeg'),
  ];
  UnmodifiableListView<HomeServices> getServices() {
    return UnmodifiableListView(_homeServices);
  }

  int totalServicesCount() {
    return _homeServices.length;
  }
}
