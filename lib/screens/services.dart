import 'package:flutter/material.dart';
import 'package:home_utility/model/servicesHandler.dart';

class MainScreen extends StatelessWidget {
  static const id = '/mainScreen';
  final ServiceHandler serviceHandler = ServiceHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Services'),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: serviceHandler.totalServicesCount(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // crossAxisSpacing: 5,
          // mainAxisSpacing: 0.5,
        ),
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              left: 10.0,
              right: 10.0,
            ),
            color: Colors.lightBlue,
            elevation: 5.0,
            child: Container(
              height: 150.0,
              margin: EdgeInsets.all(3.0),
              // padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Image.asset(
                      // 'images/img-1.jpg',
                      serviceHandler.getServices()[index].getImagePath(),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 13.0,
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                        serviceHandler.getServices()[index].getService(),
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ListView.builder(
//         itemCount: services.length,
//         itemBuilder: (context, index) {
//     return Card(
//       margin: EdgeInsets.only(
//         top: 10.0,
//         bottom: 10.0,
//         left: 15.0,
//         right: 15.0,
//       ),
//       color: Colors.lightBlue,
//       elevation: 0.0,
//       child: Container(
//         height: 150.0,
//         margin: EdgeInsets.all(3.0),
//         padding: EdgeInsets.all(15.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           color: Colors.white,
//         ),
//         child: Text('${services[index]}'),
//       ),
//     );
//   },
// ),
