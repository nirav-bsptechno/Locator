import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Global {
  static isNetAval(var _connectionStatus) {
    bool connectionStatus = false;
    if (_connectionStatus != null && _connectionStatus.isNotEmpty) {
      if (_connectionStatus == ConnectivityResult.mobile.toString()) {
        // I am connected to a mobile network.
        connectionStatus = true;
      } else if (_connectionStatus == ConnectivityResult.wifi.toString()) {
        // I am connected to a wifi network.
        connectionStatus = true;
      } else {
        connectionStatus = false;
      }
    }
    return connectionStatus;
  }

  // show dialog
  static showDialogM(BuildContext contextM, String strTitle, String strMsg) {
    // return object of type Dialog
    var alert = new AlertDialog(
      title: new Text(strTitle),
      content: new Text(
        strMsg,
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text(
            "Ok",
          ),
          onPressed: () {
            Navigator.of(contextM, rootNavigator: true).pop();
          },
        ),
      ],
    );
    showDialog(context: contextM, child: alert);
  }
}
