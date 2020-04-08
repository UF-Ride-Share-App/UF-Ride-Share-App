import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uf_ride_share_app/models/ride.dart';

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
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final ride = Ride.fromSnapshot(data);

    return Container(
        key: ValueKey(ride.id),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: CupertinoButton(
            color: Colors.tealAccent[700],
            onPressed: () {
              print('pressed');
              // RideCartPrompt().createDialog(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image:
                                AssetImage('assets/images/sampleProfile.jpeg'),
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: Colors.lightGreenAccent,
                            width: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
