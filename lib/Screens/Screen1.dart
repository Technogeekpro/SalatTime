import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class Screen1 extends StatefulWidget {
  Screen1({this.namazData, this.currentLocation});

  final namazData;
  final currentLocation;

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {


  String asr;
  String name;
  String magrib;
  String Isha;
  String fajar;
  String zohar;
  String location;

  List<String> namazTime = [];

  void updateUi(dynamic myNamazData) {
    int now = new DateTime.now().month;
    now = now - 1;
    namazTime.add(myNamazData['data'][now]['timings']['Fajr']);
    namazTime.add(myNamazData['data'][now]['timings']['Asr']);
    namazTime.add(myNamazData['data'][now]['timings']['Maghrib']);
    namazTime.add(myNamazData['data'][now]['timings']['Isha']);
    namazTime.add(myNamazData['data'][now]['timings']['Dhuhr']);

    asr = myNamazData['data'][now]['timings']['Asr'];
    magrib = myNamazData['data'][now]['timings']['Maghrib'];
    Isha = myNamazData['data'][now]['timings']['Isha'];
    fajar = myNamazData['data'][now]['timings']['Fajr'];
    zohar = myNamazData['data'][now]['timings']['Dhuhr'];
    location = myNamazData['data'][now]['timings']['Asr'];
  }

  void checkCurrentTime() {
    //Getting current hour
    int now = new DateTime.now().hour;
    var temp;
    var fullTime;
    //Sort the list in acceding order
    namazTime.sort();
    var tmp = namazTime;
    int nTime;

    //This loop will iterate whole list and give the time into integer formate
    for (int i = 0; i <= namazTime.length - 1; i++) {
       temp =
          namazTime.elementAt(i).toString().substring(0, 2).replaceAll("", "");
       fullTime =
           namazTime.elementAt(i).toString().substring(0, 5).replaceAll("", "");
      nTime = int.parse(temp);

      //For converting 24 hour formate time into 12 hour
      if (now <= nTime) {
        print("test1 : " + now.toString());
        print("test2 : " + nTime.toString());
        if (nTime > 12) {
          nTime = nTime - 12;
        }
        print("Your time:" + nTime.toString());
        break;
      }
    }
    print("Your time:" + fullTime.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUi(widget.namazData);
    checkCurrentTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: Icon(Icons.menu),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.search),
            )
          ],
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.pin_drop),
                ),
                Text(widget.currentLocation)
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new displayCurrentNamaz(currentNamazNamz: "Asar"),
            Expanded(
                flex: 2,
                child: ListView(
                  children: <Widget>[
                    new customList(namazName: "Fajr", magrib: fajar),
                    Divider(
                      height: 1,
                    ),
                    new customList(namazName: "Duhr", magrib: zohar),
                    Divider(
                      height: 1,
                    ),
                    new customList(namazName: "Asr", magrib: asr),
                    Divider(
                      height: 1,
                    ),
                    new customList(namazName: "Magreeb", magrib: magrib),
                    Divider(
                      height: 1,
                    ),
                    new customList(namazName: "Isha", magrib: Isha),
                    Divider(
                      height: 1,
                    ),
                  ],
                )),
          ],
        ));
  }
}

class displayCurrentNamaz extends StatelessWidget {
  const displayCurrentNamaz({
    Key key,
    @required this.currentNamazNamz,
  }) : super(key: key);

  final String currentNamazNamz;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          color: darkColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                    child: Text(
                  currentNamazNamz,
                  style: kTempTextStyle,
                )),
              ),
              Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  currentNamazNamz,
                  style: kButtonTextStyle,
                )),
              ),
            ],
          ),
        ));
  }
}

class customList extends StatelessWidget {
  final Color activeCardcolor = semidarkColor;
  final Color deactiveCardColor = Colors.white;

  const customList({
    Key key,
    @required this.magrib,
    @required this.namazName,
    this.isActive,
  }) : super(key: key);

  final String magrib;
  final String namazName;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.grey,
      padding: EdgeInsets.only(bottom: 16),
      child: ListTile(
        onTap: () {},
        title: Text(
          namazName,
          style: namazNameStyle,
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(margin: EdgeInsets.only(right: 20), child: Text(magrib)),
            Icon(
              Icons.access_time,
              color: Colors.yellow[800],
            )
          ],
        ),
        leading: Icon(Icons.access_alarm, color: Colors.yellow[900]),
      ),
    );
  }
}



Widget namazWidget(String namaz) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: Center(
        child: Text(namaz, style: kTempTextStyle),
      ),
    ),
  );
}

