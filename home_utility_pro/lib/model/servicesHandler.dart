import 'dart:collection';

import 'services.dart';

class ServiceHandler {
  final List<HomeServices> _homeServices = [
    // HomeServices('Home Cleaning', 'Maid'),
    HomeServices('Maid', 'Maid'),
    HomeServices('House Painting', 'Painter'),
    HomeServices('Electrical Services', 'Electrician'),
    HomeServices('Plumbing', 'Plumber'),
    HomeServices('Goods Transport', 'Driver'),
    // HomeServices('Chef', 'Chef'),
    HomeServices('Carpentry', 'Carpenter'),
    HomeServices('Gardening', 'Gardener'),
    HomeServices('Babysitting', 'Baby Sitter'),
    HomeServices('Tuition', 'Tution Teacher'),
    HomeServices('Construction', 'Construction Worker'),
    // HomeServices('Laundary', 'Maid'),
  ];

  UnmodifiableListView<HomeServices> getServices() {
    return UnmodifiableListView(_homeServices);
  }

  int totalServicesCount() {
    return _homeServices.length;
  }
}
