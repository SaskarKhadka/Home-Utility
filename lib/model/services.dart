class HomeServices {
  // final List<String> _homeServices = [
  //   'Home Cleaning',
  //   'Electricial Services',
  //   'Plumbing',
  //   'Home Painting',
  //   // 'Goods Transportation',
  //   // 'Furniture Assembly',
  //   // 'Gardening',
  //   // 'Babysitting',
  //   // 'Tuition',
  //   // 'Construction',
  //   // 'Laundary',
  //   // 'Maid',
  // ];
  String _service;
  String _imagePath;
  HomeServices(this._service, this._imagePath);

  String getService() {
    return _service;
  }

  String getImagePath() {
    return _imagePath;
  }
}
