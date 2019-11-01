import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'Screen1.dart';
import '../Services/NetworkHelper.dart';


class Screen0 extends StatefulWidget {
  @override
  _Screen0State createState() => _Screen0State();
}

class _Screen0State extends State<Screen0> {





  double lang1;
  double lat2;
  String city;
  String IshaTime;

  String fajar;
  String zohar;
  String asar;
  String magrib;
  String isha;

  //'https://muslimsalat.com/$city.json?key==eebf32a65d8f3849d2bb127b3b6c6911'

  final String ApiKey = 'eebf32a65d8f3849d2bb127b3b6c6911';

  String lang;
  String lat;
  String locality;
  String country;
  Geolocator geolocator = Geolocator();
  Position userLocation;




  void getLocation() async {
    var currentLocation;

    try {
      //get the langitude and the latitiude 
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double lang1 = position.longitude;
      double lat2 = position.latitude;
      
      //get city name by cordinates
      List<Placemark> placemark =
      await Geolocator().placemarkFromCoordinates(lat2, lang1);
      city = placemark[0].locality;
      locality = placemark[0].subLocality;
      country = placemark[0].country;
      print(locality);
      
      //get Data from API by city name 
      NetworkHelper networkHelper = NetworkHelper('http://api.aladhan.com/v1/calendar?latitude=$lat2&longitude=$lang1&method=1&month=11&year=2019');
      var data = await networkHelper.getData();
      print('work done');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Screen1(namazData: data,currentLocation: locality,)));
    } catch (e) {
      city = null;
    }
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getLocation();
  }
//AIzaSyB6sxVI56dsDrY5gnymggFEN8LDe6zGRN8

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitPouringHourglass(
        color: Colors.red,
        size: 90,
      )
    );
  }
}

