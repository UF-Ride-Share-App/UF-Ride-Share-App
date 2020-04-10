import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uf_ride_share_app/components/ride_card.dart';
import 'package:uf_ride_share_app/models/ride.dart';

final dummySnapshot = [
  {
    'driver': '1',
    'passengers': ['2'],
    'time': Timestamp.fromDate(DateTime.now()),
    'seats': 4,
    'start_location': 'Gainesville',
    'end_location': 'Miami'
  },
  {
    'driver': '1',
    'passengers': ['2', '3'],
    'time': Timestamp.fromDate(DateTime.now()),
    'seats': 3,
    'start_location': 'Tampa',
    'end_location': 'Gainesville'
  }
];

class PostList extends StatefulWidget {
  @override
  _PostListState createState() {
    return _PostListState();
  }
}

class _PostListState extends State<PostList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildStream(context);
  }

  Widget _buildStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Rides').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
    // return _buildList(context, dummySnapshot);
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final ride = Ride.fromSnapshot(data);

    return RideCard(ride: ride);
  }
}
