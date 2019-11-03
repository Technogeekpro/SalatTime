import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';


class CurrentLocationWidget extends StatefulWidget {

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<CurrentLocationWidget> {
  Position _lastKnownPosition;
  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _initLastKnownLocation();
    _initCurrentLocation();
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initLastKnownLocation() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager =true;
      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best);
    } on PlatformException {
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    

    setState(() {
      _lastKnownPosition = position;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  _initCurrentLocation() {
    Geolocator()
      ..forceAndroidLocationManager =true
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        
          setState(() => _currentPosition = position);
        
      }).catchError((e) {
        //
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      FutureBuilder<GeolocationStatus>(
          future: Geolocator().checkGeolocationPermissionStatus(),
          builder:
              (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == GeolocationStatus.denied) {
              return const PlaceholderWidget('Access to location denied',
                  'Allow access to the location services for this App using the device settings.');
            }

            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  PlaceholderWidget(
                      'Last known location:', _lastKnownPosition.toString()),
                  PlaceholderWidget(
                      'Current location:', _currentPosition.toString()),
                ],
              ),
            );
          }),
    );
  }

}


class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget(this.title, this.message);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        
        children: <Widget>[
          Text(title,
              style: const TextStyle(fontSize: 32.0, color: Colors.black54),
              textAlign: TextAlign.center),
          Text(message,
              style: const TextStyle(fontSize: 16.0, color: Colors.black54),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
