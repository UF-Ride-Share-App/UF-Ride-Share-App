import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/models/user.dart';
import 'package:uf_ride_share_app/ui/posting/posting_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DriveHistory extends StatelessWidget{
  
  historicalRides(BuildContext context, String currentUser) {
    
    DateTime dateTime = new DateTime.now();
    Timestamp lowerRange = Timestamp.fromDate(
      DateTime.utc(
        dateTime.year, 
        dateTime.month, 
        dateTime.day, 
        dateTime.hour,
        dateTime.minute,
        dateTime.second
    ));
    
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: PostList(Firestore.instance.collection('Rides')
          .where('driver', isEqualTo: currentUser)
          .where('time', isLessThanOrEqualTo: lowerRange)
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
        if(snapshot.hasData){
          return historicalRides(context, snapshot.data);
        }
        else {
          return CircularProgressIndicator();
        }
      } 
    );
  }

}