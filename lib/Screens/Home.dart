import 'package:flutter/material.dart';
import 'Screen0.dart';
import 'Screen1.dart';
import 'Screen2.dart';
import 'GeoListPage.dart';
import '../utilities/constants.dart';

    class Home extends StatefulWidget {
      @override
      _HomeState createState() => _HomeState();
    }

    class _HomeState extends State<Home> {


      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: darkColor,
          ),
          debugShowCheckedModeBanner: false,
          title: "Home",
          initialRoute: 'home',
          routes: {
            'home' :(context)=> Screen0(),
            'second' :(context)=> Screen1(),
            'third' :(context)=> Screen2(),
            'fourth' :(context)=>GeoListenPage(),
          },
        );
      }
    }
