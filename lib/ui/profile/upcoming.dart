import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/models/user.dart';
import 'package:uf_ride_share_app/ui/posting/posting_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Upcoming extends StatelessWidget{ 
  
  upcomingRides(BuildContext context, currentUser) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: PostList(Firestore.instance.collection('Rides')
          .where('passengers', arrayContains: currentUser)
          .where('time', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
          .orderBy('time') 
          .snapshots()
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrentUser(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return upcomingRides(context, snapshot.data);
      } 
    );
  }
}