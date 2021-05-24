import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../model/servicesHandler.dart';
import '../detailsScreen.dart';

class ServicesPage extends StatefulWidget {
  static const id = '/mainScreen';

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final ServiceHandler serviceHandler = ServiceHandler();

  @override
  void initState() {
    // TODO: implement initState
    print(requestKeysForThisSession);

    requestKeysForThisSession.clear();

    usersRefrence
        .child(userAuthentication.userID)
        .child('requests')
        .once()
        .then((value) {
      if (value.value != null) {
        Map.from(value.value).forEach((key, value) {
          requestKeysForThisSession.add(key);
        });
      }
    });

    print(requestKeysForThisSession);
    database.totalUsersRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.red[200],
      appBar: AppBar(
        title: Text('Our Services'),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: serviceHandler.totalServicesCount(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          var imgPath = serviceHandler.getServices()[index].getImagePath();
          var service = serviceHandler.getServices()[index].getService();
          return GestureDetector(
            onTap: () => Get.toNamed(
              DetailsScreen.id,
              parameters: {
                'imgPath': imgPath,
                'service': service,
              },
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              margin: EdgeInsets.only(
                top: size.height * 0.015,
                bottom: size.height * 0.015,
                left: size.width * 0.025,
                right: size.width * 0.025,
              ),
              elevation: 10.0,
              child: Container(
                height: 150.0,
                // margin: EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.red[100],
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0)),
                        child: Image.asset(
                          // 'images/img-1.jpg',
                          imgPath,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 13.0,
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          service,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
