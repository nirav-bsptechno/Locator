import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  GoogleMapController mapController;
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  double latitudeM = 0.0;
  double longitudeM = 0.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    _locationSubscription =
        _location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        _currentLocation = result;
      });
    });
  }

  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();

      error = null;
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    setState(() {
      _startLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 1.2;

    initAppBar(bool isShowRight, String strTitle, String strShareUrl) {
      List<Widget> actionsList = new List<Widget>();
      if (isShowRight) {
        Widget mIconButton = IconButton(
          icon: Icon(Icons.access_alarm),
          onPressed: () {},
        );
        actionsList.add(mIconButton);
      }

      return AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          strTitle,
        ),
        actions: actionsList,
      );
    }

    if (_currentLocation != null) {
      latitudeM = _currentLocation["latitude"];
      longitudeM = _currentLocation["longitude"];
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // appBar: initAppBar(false, "Locator App", ""),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              options: GoogleMapOptions(myLocationEnabled: true),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                startTime();
              },
            ),
          ),
          Container(
            height: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 8.0,bottom: 15.0),
                  child:
                  InkWell(
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        elevation: 1.0,
                        color: Colors.white,
                        child: Padding(padding: EdgeInsets.all(4.0),child: Icon(
                          Icons.my_location,
                          color: Colors.black,
                          size: 18.0,
                        ),),
                      ),
                      onTap: () {
                        startTime();
                      }),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: 1.0, right: 1.0, bottom: 5.0, top: 2.0),
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          elevation: 1.0,
                          child: Icon(
                            Icons.wc,
                            color: Colors.black,
                            size: 28.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 1.0, right: 1.0, bottom: 5.0, top: 2.0),
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          elevation: 1.0,
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.black,
                            size: 28.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 1.0, right: 1.0, bottom: 5.0, top: 2.0),
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          elevation: 1.0,
                          child: Icon(
                            Icons.airport_shuttle,
                            color: Colors.black,
                            size: 28.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 1.0, right: 1.0, bottom: 5.0, top: 2.0),
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          elevation: 1.0,
                          child: Icon(
                            Icons.directions_subway,
                            color: Colors.black,
                            size: 28.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 1.0, right: 1.0, bottom: 5.0, top: 2.0),
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          elevation: 1.0,
                          child: Icon(
                            Icons.wc,
                            color: Colors.black,
                            size: 28.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 1.0, right: 1.0, bottom: 5.0, top: 2.0),
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          elevation: 1.0,
                          child: Icon(
                            Icons.directions_bike,
                            color: Colors.black,
                            size: 28.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 1.0, right: 1.0, bottom: 5.0, top: 2.0),
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          elevation: 1.0,
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 28.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 1.0, right: 1.0, bottom: 5.0, top: 2.0),
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          elevation: 1.0,
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 28.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 1.0, right: 1.0, bottom: 5.0, top: 2.0),
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          elevation: 1.0,
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 28.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 1.0, right: 1.0, bottom: 5.0, top: 2.0),
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          elevation: 1.0,
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 28.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
          child: Icon(Icons.my_location),
          onPressed: () {
            if (_currentLocation != null) {
              double latitudeM = _currentLocation["latitude"];
              double longitudeM = _currentLocation["longitude"];
              //print(currentLocation["longitude"]);

              if (latitudeM != null &&
                  longitudeM.round() != 0 &&
                  longitudeM != null &&
                  longitudeM.round() != 0) {
                mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(latitudeM, longitudeM), zoom: 20.0),
                  ),
                );

                mapController.addMarker(
                  MarkerOptions(
                      position: LatLng(latitudeM, longitudeM),
                      infoWindowText:
                          InfoWindowText("My Location", "My Location")),
                );
              } else {
                initPlatformState();
              }
            } else {
              initPlatformState();
            }
          }),*/
    );
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, gotoMap);
  }

  void gotoMap() {
    if (_currentLocation != null) {
      double latitudeM = _currentLocation["latitude"];
      double longitudeM = _currentLocation["longitude"];
      //print(currentLocation["longitude"]);

      if (latitudeM != null &&
          longitudeM.round() != 0 &&
          longitudeM != null &&
          longitudeM.round() != 0) {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(latitudeM, longitudeM), zoom: 20.0),
          ),
        );
        mapController.clearMarkers();
        mapController.addMarker(
          MarkerOptions(
              position: LatLng(latitudeM, longitudeM),
              infoWindowText: InfoWindowText("My Location", "My Location")),
        );
      } else {
        initPlatformState();
      }
    } else {
      initPlatformState();
    }
  }
}
