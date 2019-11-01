import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoListenPage extends StatefulWidget {
  @override
  _GeoListenPageState createState() => _GeoListenPageState();
}

class _GeoListenPageState extends State<GeoListenPage> {




  Geolocator geolocator = Geolocator();

  Position userLocation;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _getLocation().then((position) {
      userLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator()
                : Text("Location:" +
                    userLocation.latitude.toString() +
                    " " +
                    userLocation.longitude.toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                    });
                  });
                },
                color: Colors.blue,
                child: Text(
                  "Get Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> _getLocation() async {
    var currentLocation;


    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
      double lang1 = position.longitude;
      double lat2 = position.latitude;
      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat2, lang1);
      print(placemark[0].country);
      print(placemark[0].position);
      print(placemark[0].locality);
      print(placemark[0].administrativeArea);
      print(placemark[0].postalCode);
      print(placemark[0].name);
      print(placemark[0].isoCountryCode);
      print(placemark[0].subLocality);
      print(placemark[0].subThoroughfare);
      print(placemark[0].thoroughfare);

    } catch (e) {
      currentLocation = null;
    }

    return currentLocation;
  }
}
