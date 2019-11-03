import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'Screen1.dart';
import '../Services/NetworkHelper.dart';

enum GettingPositionState { loading, done, error }

class Screen0 extends StatefulWidget {
  @override
  _Screen0State createState() => _Screen0State();
}

class _Screen0State extends State<Screen0> {
  GettingPositionState _state;
  String _errorMessage;
  // double lang1;
  // double lat2;
  String _city;
  String _ishaTime;
  String _fajar;
  String _zohar;
  String _asar;
  String _magrib;
  String _isha;

  //'https://muslimsalat.com/$city.json?key==eebf32a65d8f3849d2bb127b3b6c6911'

  final String _apiKey = 'eebf32a65d8f3849d2bb127b3b6c6911';

  String locality;
  String country;
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
  Position _lastKnownPosition;
  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  initPosition() async {
    await _initLastKnownLocation();
    await _initCurrentLocation();
    print(_lastKnownPosition.toString());
    print(_currentPosition.toString());
  }

  Future<void> _initLastKnownLocation() async {
    Position position;

    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = true;
      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best);
    } on PlatformException {
      position = null;
    }
    setState(() {
      _lastKnownPosition = position;
    });
  }

  _initCurrentLocation() {
    Geolocator()
      ..forceAndroidLocationManager = true
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        setState(() => _currentPosition = position);
      }).catchError((e) {
        //
      });
  }

  getCityName(double _lat, double _long) async {
    //get city name by cordinates
    try {
      if (_lat == null || _long == null) {
        return;
      }

      List<Placemark> placemark =
          await Geolocator().placemarkFromCoordinates(_lat, _long);
      _city = placemark[0].locality;
      locality = placemark[0].subLocality;
      country = placemark[0].country;
      print(locality);

      //get Data from API by city name

      NetworkHelper networkHelper = NetworkHelper(
          'http://api.aladhan.com/v1/calendar?latitude=$_lat&longitude=$_long&method=1&month=11&year=2019');
      var data = await networkHelper.getData();
      print('work done');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Screen1(
                namazData: data,
                currentLocation: locality,
              )));
    } catch (e) {
      print("crash produced $e");
      _city = null;
    }
  }

  void getLocation() async {
    // var currentLocation;
    print("im here");
    await initPosition();
    if (_currentPosition == null) {
      await initPosition();
      if (_lastKnownPosition == null) {
        await initPosition();
      } else {
        await getCityName(
            _lastKnownPosition.latitude, _lastKnownPosition.longitude);
      }
    } else {
      await getCityName(_currentPosition.latitude, _currentPosition.longitude);
    }
  }

//AIzaSyB6sxVI56dsDrY5gnymggFEN8LDe6zGRN8

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<GeolocationStatus>(
            future: Geolocator().checkGeolocationPermissionStatus(),
            builder: (BuildContext context,
                AsyncSnapshot<GeolocationStatus> snapshot) {
              if (!snapshot.hasData) {
                return SpinKitPouringHourglass(
                  color: Colors.red,
                  size: 90,
                );
              }

              if (snapshot.data == GeolocationStatus.denied) {
                return const Text(
                    'Access to location denied Allow access to the location services for this App using the device settings.');
              }
              print(_lastKnownPosition.toString());
              print(_currentPosition.toString());
              return SpinKitPouringHourglass(
                color: Colors.red,
                size: 90,
              );
            }));
  }
}

askForGeolocationPermission(_) {
  return SimpleDialog(
    children: <Widget>[
      Container(child: Icon(Icons.gps_off)),
      Container(child: Text("Please active your GPS")),
      Container(
        alignment: Alignment.bottomRight,
        child: FlatButton(
          child: Text("OK"),
          onPressed: () => Navigator.of(_).pop(),
        ),
      )
    ],
  );
}
