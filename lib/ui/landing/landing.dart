import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/ui/landing/search.dart';

class Landing extends StatelessWidget {
  Landing();

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
                Expanded(
                  flex: 6,
                  child: Search()
                ),
                Expanded(
                  flex: 11,
                  child: Container(color: Colors.yellow),
                )
              ],
            )));
  }
}
