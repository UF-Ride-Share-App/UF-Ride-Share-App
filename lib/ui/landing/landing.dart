import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/ui/posting/posting_list.dart';
import 'package:uf_ride_share_app/ui/landing/search.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  Stream<QuerySnapshot> stream =
      Firestore.instance.collection('Rides').snapshots();
  String startLocation = '';
  String endLocation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          title: Text("Share & Ride"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.filter_list),
              ),
            ),
          ],
          actionsIconTheme: IconThemeData(
            color: Colors.teal[700],
            size: 30.0,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                    height: 230,
                    child: Search(
                        onSearch: (String start, String end, DateTime time) {
                      setState(() {
                        if (time != null) {
                          Timestamp lowerRange = Timestamp.fromDate(
                              DateTime.utc(time.year, time.month, time.day));
                          Timestamp upperRange = Timestamp.fromDate(DateTime.utc(
                              time.year, time.month, time.day, 23, 59, 59));
                          stream = Firestore.instance
                              .collection('Rides')
                              .where('time', isGreaterThanOrEqualTo: lowerRange)
                              .where('time', isLessThanOrEqualTo: upperRange)
                              .snapshots();
                        } else {
                          print('no time');
                          stream = Firestore.instance
                              .collection('Rides')
                              .snapshots();
                        }
                      });
                    })),
                Divider(color: Colors.grey),
                Expanded(
                  flex: 11,
                  child: PostList(stream),
                )
              ],
            )));
  }
}
