import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/ui/posting/posting_list.dart';
import 'package:uf_ride_share_app/ui/landing/search.dart';

Stream<QuerySnapshot> stream;

class Landing extends StatefulWidget {

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
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
            color: Colors.tealAccent[700],
            size: 30.0,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(height: 250, child: Search()),
                Divider(color: Colors.grey),
                Expanded(
                  flex: 11,
                  child: PostList(stream),
                )
              ],
            )));
  }
}
