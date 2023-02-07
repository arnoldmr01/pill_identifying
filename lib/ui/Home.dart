import 'package:clock_app/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/helpers.dart';
import 'package:clock_app/ui/DetectMain.dart';
import 'DetectMain.dart';
import 'HomePage.dart';

class Home extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: RiceWhite,
      appBar: AppBar(
        leading: (Padding(
          padding: const EdgeInsets.fromLTRB(30, .0, .0, .0),
          child: appLogo,
        )),
        title: Text(
          "藥報報",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: DarkGreen,
        centerTitle: false,
        elevation: 20,
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 240, 0, 240),
        ),
      Container(
              width: 10,
              height: 100,
              color: Orange,
              child: TextButton.icon(
                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.pie_chart,
                      color: Colors.white,
                      size: 40,
                    ),
                    label: Text("鬧鐘提醒",
                        style: TextStyle(fontSize: 30, color: Colors.white)))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                width: 200,
                height: 100,
                color: DarkGreen,
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage2(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.pie_chart,
                      color: Colors.white,
                      size: 40,
                    ),
                    label: Text("藥物資訊",
                        style: TextStyle(fontSize: 30, color: Colors.white)))),
            Container(
                width: 200,
                height: 100,
                color: Orange,
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetectMain(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                      size: 40,
                    ),
                    label: Text("藥物辨識",
                        style: TextStyle(fontSize: 30, color: Colors.white)))),
          ],
        )
      ]), //body
    ); //scaffold
  } //build
} //state
