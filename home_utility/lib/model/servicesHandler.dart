import 'dart:collection';

import 'services.dart';

class ServiceHandler {
  final List<HomeServices> _homeServices = [
    HomeServices('Home Cleaning', 'images/img-1.jpg'),
    HomeServices('Electrical Services', 'images/img-3.jpg'),
    HomeServices('Plumbing', 'images/img-2.jpg'),
    HomeServices('Goods Transport', 'images/img-4.jpeg'),
    HomeServices('Furniture Assembly', 'images/img-4.jpeg'),
    HomeServices('Gardening', 'images/img-4.jpeg'),
    HomeServices('Babysitting', 'images/img-4.jpeg'),
    HomeServices('Tuition', 'images/img-4.jpeg'),
    HomeServices('Construction', 'images/img-4.jpeg'),
    HomeServices('Laundary', 'images/img-4.jpeg'),
    HomeServices('Maid', 'images/img-4.jpeg'),
  ];

  UnmodifiableListView<HomeServices> getServices() {
    return UnmodifiableListView(_homeServices);
  }

  int totalServicesCount() {
    return _homeServices.length;
  }
}
