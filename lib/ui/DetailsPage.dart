import 'package:flutter/material.dart';
import 'models/Record.dart';
import 'package:clock_app/helpers.dart';

class DetailPage extends StatelessWidget {
  final Record record;
  DetailPage({this.record});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: RiceWhite,
        appBar: new AppBar(
          title: new Text('藥物資訊'),
          backgroundColor: DarkGreen,
        ),
        body: new ListView(children: <Widget>[
          GestureDetector(
              onTap: () {},
              child: new Container(
                padding: const EdgeInsets.all(32.0),
                child: new Row(
                  children: [
                    // First child in the Row for the name and the
                    new Expanded(
                      // Name and Address are in the same column
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Code to create the view for name.
                          new Container(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: new Text(
                              record.name,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                          // Code to create the view for Introduction.
                          new Container(
                            padding: const EdgeInsets.only(top: 15),
                            child: new Text("藥品介紹：\n" + record.introduction,
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 17)),
                          ),
                          new Container(
                            padding: const EdgeInsets.only(top: 30),
                            child: new Text(
                              "注意事項： \n" + record.notice,
                              style: new TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Icon to indicate the phone number.

                    //new Text(' ${record.contact}'),
                  ],
                ),
              )),
        ]));
  }
}
