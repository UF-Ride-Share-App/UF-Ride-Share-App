import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/models/user.dart';
import 'package:uf_ride_share_app/ui/posting/posting_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uf_ride_share_app/models/ride.dart';

class Postings extends StatelessWidget{

  List<Ride> filterSnapshotResults(List<Ride> rides) {
    List<Ride> results = rides
        .where((ride) => ride.time.compareTo(DateTime.now()) >= 0 )
        .toList();
    results.sort((rideA, rideB) => rideA.time.compareTo(rideB.time));
    return results;
  }

  Widget postedRides(BuildContext context, String currentUser) {

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: PostList(Firestore.instance.collection('Rides')
          .where('driver', isEqualTo: currentUser)
          .snapshots(),
          filter: filterSnapshotResults
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
        return postedRides(context, snapshot.data);
      } 
    );
  }

}