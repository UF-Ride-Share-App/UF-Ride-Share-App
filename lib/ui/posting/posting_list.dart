import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uf_ride_share_app/components/ride_card.dart';
import 'package:uf_ride_share_app/models/ride.dart';

class PostList extends StatefulWidget {
  final Stream<QuerySnapshot> stream;
  final Function(List<Ride>) filter;

  PostList(this.stream, {this.filter}) : super();

  @override
  _PostListState createState() => _PostListState();
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
      stream: this.widget.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        List<Ride> rides = snapshot.data.documents
            .map((data) => Ride.fromSnapshot(data))
            .toList();
        if (this.widget.filter != null) rides = this.widget.filter(rides);
        return _buildList(context, rides);
      },
    );
  }

  Widget _buildList(BuildContext context, List<Ride> rides) {
    return ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children: rides.map((ride) => _buildListItem(context, ride)).toList());
  }

  Widget _buildListItem(BuildContext context, Ride ride) {
    return RideCard(ride: ride);
  }
}

//   Widget _buildStream(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: this.widget.stream,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return LinearProgressIndicator();
//         return _buildList(context, snapshot.data.documents);
//       },
//     );
//   }

//   Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//     return ListView(
//       padding: const EdgeInsets.only(top: 20.0),
//       children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//     );
//   }

//   Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//     final ride = Ride.fromSnapshot(data);
//     return RideCard(ride: ride);
//   }
// }
