import 'package:flutter/material.dart';

class NamazModel {

  //String timings;
  String fajar;
  String Dhuhr;
  NamazModel({this.fajar,this.Dhuhr});
  NamazModel.fromJson(Map<String,dynamic> parsedJson) {
    fajar = parsedJson['Fajr'];
    Dhuhr = parsedJson['Dhuhr'];
  }
}