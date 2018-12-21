import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:locator_app/global/constants.dart';
import 'package:locator_app/global/global.dart';
import 'package:locator_app/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Locator App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        routes: <String, WidgetBuilder>{
          //Home
          Constants.ACT_HOME: (BuildContext context) => new HomePage(),
        });
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MyHomePage> {
  String _connectionStatus = 'Unknown';
  bool connectionStatus = false;
  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  startTime() async {
    var _duration = new Duration(milliseconds:  600);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(Constants.ACT_HOME);
  }

  @override
  void initState() {
    super.initState();
    initConnectivity(context);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => _connectionStatus = result.toString());
      connectionStatus = Global.isNetAval(_connectionStatus);
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: new Center(
          child: Text("Locator App"),
        ));
  }

  Future<Null> initConnectivity(BuildContext context) async {
    String mConnectionStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.


    try {
      mConnectionStatus = (await _connectivity.checkConnectivity()).toString();
    } catch (e) {
      mConnectionStatus = 'Failed to get connectivity.';
    }

    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _connectionStatus = mConnectionStatus;
      connectionStatus = Global.isNetAval(mConnectionStatus);
      if (connectionStatus) {
          startTime();
      } else {
        Global.showDialogM(context, "Alert",
            "no internet connection");
      }
    });
  }
}
