import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/models/ride.dart';
import 'package:uf_ride_share_app/ui/landing/search.dart';
import 'package:uf_ride_share_app/ui/posting/posting_list.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  Stream<QuerySnapshot> stream =
      Firestore.instance.collection('Rides').snapshots();
  String startLocation = '';
  String endLocation = '';
  DateTime upperTime;
  DateTime lowerTime;

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
                        startLocation = start;
                        endLocation = end;
                        if (time != null) {
                          stream = Firestore.instance
                              .collection('Rides')
                              .where('time', isGreaterThanOrEqualTo: Timestamp.fromDate(lowerTime))
                              .where('time', isLessThanOrEqualTo: Timestamp.fromDate(upperTime))
                              .snapshots();
                          lowerTime = DateTime(time.year, time.month, time.day);
                          upperTime = DateTime(
                              time.year, time.month, time.day, 23, 59, 59);
                        }
                      });
                    })),
                Divider(color: Colors.grey),
                Expanded(
                  flex: 11,
                  child: PostList(stream, filter: filterSnapshotResults),
                ),
              ],
            )));
  }

  List<Ride> filterSnapshotResults(List<Ride> rides) {
    List<Ride> results = rides
        .where((ride) =>
            (ride.startLocation == startLocation || startLocation == '') &&
            (ride.endLocation == endLocation || endLocation == ''))
        .toList();
    results.sort((rideA, rideB) => rideA.time.compareTo(rideB.time));
    return results;
  }
}
