import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 3"),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'home');
                },
              ),
              MaterialButton(
                onPressed: () {},
              ),
            ],
          )),
    );
  }
}
